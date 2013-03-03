require 'spec_helper'

describe "Kahana::Service" do

  after(:each) do
    Kahana.reset!
  end

  context "when added as a module" do

    let(:example_class) do
      Class.new do
        include Kahana::Service
      end
    end

    it "gets included in the class" do
      example_class.should include Kahana::Service
    end

  end

  context "without configuration" do

    let(:example_class) do
      Class.new do
        include Kahana::Service
      end
    end

    it "uses the library default" do
      example_class.new.http_adapter.should eq Faraday.default_adapter
    end

  end

  context "with application level configuration" do

    before do
      Kahana.configure do |config|
        config.http_adapter = :typhoeus
      end
      @example_class = Class.new do
        include Kahana::Service
      end
    end

    it "uses the configured options" do
      @example_class.new.http_adapter.should eq :typhoeus
    end

  end

  context "with class level configuration" do

    let(:example_class) do
      Class.new do
        include Kahana::Service
        format :json
      end
    end

    it "can override application level settings" do
      example_class.new._format.should eq :json
    end

  end

end

