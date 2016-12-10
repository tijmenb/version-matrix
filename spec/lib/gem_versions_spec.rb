require 'spec_helper'

RSpec.describe GemVersions do
  describe '#as_json' do
    it 'returns the gems & versions' do
      VCR.use_cassette "gem_versions" do
        versions = GemVersions.new(
          %w[alphagov/finder-frontend alphagov/government-frontend something-unfindable],
          %w[slimmer rails no-such-gem]
        ).as_json

        expect(versions).to eql(
          "alphagov/finder-frontend" => {
            "slimmer" => "9.0.1",
            "rails" => "4.2.7.1",
            "no-such-gem" => nil,
          },
          "alphagov/government-frontend" => {
            "slimmer" => "9.6.0",
            "rails" => "5.0.0.1",
            "no-such-gem" => nil,
          },
          "something-unfindable" => {
            "slimmer" => nil,
            "rails" => nil,
            "no-such-gem" => nil
          }
        )
      end
    end
  end
end
