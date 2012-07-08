require 'spec_helper'

describe "Kahana::Defaults" do

  it "return a hash of default options" do
    Kahana::Defaults.options.should be_a Hash
  end

  it "return nothing for an unspecified option" do
    Kahana::Defaults.options[:nothing].should be_nil
  end

  it "has a default http adapter" do
    Kahana::Defaults.http_adapter.should == Faraday.default_adapter
  end

end

