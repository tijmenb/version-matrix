require 'bundler'

class GemVersions
  attr_reader :repos, :all_gems

  def initialize(repos, all_gems)
    @repos = repos
    @all_gems = all_gems
  end

  def as_json
    hydra = Typhoeus::Hydra.new

    requests = repos.map do |repo_name|
      url = "https://raw.githubusercontent.com/#{repo_name}/master/Gemfile.lock"
      request = Typhoeus::Request.new(url, followlocation: true)
      hydra.queue(request)
      [repo_name, request]
    end

    hydra.run

    requests.reduce({}) do |repos, (repo_name, request)|
      lockfile = Bundler::LockfileParser.new(request.response.body)

      repos[repo_name] = all_gems.reduce({}) do |gem_hash, gem_name|
        gem_hash[gem_name] = deployed_version_for(lockfile, gem_name)
        gem_hash
      end

      repos
    end
  end

private

  def deployed_version_for(lockfile, gem_name)
    spec = lockfile.specs.find { |spec| spec.name == gem_name }
    spec && spec.version.to_s
  end
end
