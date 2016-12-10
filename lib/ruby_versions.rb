class RubyVersions
  attr_reader :repos

  def initialize(repos)
    @repos = repos
  end

  def as_json
    hydra = Typhoeus::Hydra.new

    requests = repos.map do |repo_name|
      url = "https://raw.githubusercontent.com/#{repo_name}/master/.ruby-version"
      request = Typhoeus::Request.new(url, followlocation: true)
      hydra.queue(request)
      [repo_name, request]
    end

    hydra.run

    requests.reduce({}) do |h, (repo_name, request)|
      h[repo_name] = request.response.body.strip
      h
    end
  end
end
