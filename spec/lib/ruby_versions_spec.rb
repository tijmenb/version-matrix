require 'spec_helper'

RSpec.describe RubyVersions do
  describe '#as_json' do
    it 'returns the ruby versions' do
      VCR.use_cassette "ruby_versions" do
        versions = RubyVersions.new(
          %w[alphagov/finder-frontend alphagov/government-frontend]
        ).as_json

        expect(versions).to eql(
          "alphagov/finder-frontend" => "2.3.1",
          "alphagov/government-frontend" => "2.3.1"
        )
      end
    end
  end
end
