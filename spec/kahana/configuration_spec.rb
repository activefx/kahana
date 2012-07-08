require 'spec_helper'

describe "Kahana::Configuration" do

  before(:each) do
    @default_adapter = Faraday.default_adapter
    @sample_adapter = :typhoeus
    Kahana.reset!
  end

  it "for testing purposes, sample_adapter should never match default_adapter" do
    @default_adapter.should_not == @sample_adapter
  end

  context ".configure" do

    it "yields itself" do
      Kahana.configure.should == Kahana
    end

    it "yields itself to set options via a block" do
      Kahana.configure{}.should == Kahana
    end

    it "accepts block level configuration" do
      Kahana.configure{ |c| c.http_adapter = @sample_adapter }
      Kahana.http_adapter.should == @sample_adapter
    end

    it "accepts top level configuration" do
      Kahana.http_adapter = @sample_adapter
      Kahana.http_adapter.should == @sample_adapter
    end

  end

  context ".available_options" do

    it "include http adapter" do
      Kahana.available_options.should include :http_adapter
    end

    it "do not include non-existant values" do
      Kahana.available_options.should_not include :nothing
    end

  end

  context ".defaults" do

    it "set the default http adapter from library defaults" do
      Kahana.defaults[:http_adapter].should == Kahana::Defaults.http_adapter
    end

    it "do not include non-existant values" do
      Kahana.defaults[:nothing].should be_nil
    end

  end

  context ".settings" do

    it "initialize the default if not defined" do
      Kahana.settings[:http_adapter].should == @default_adapter
    end

    it "do not include non-existant values" do
      Kahana.settings[:nothing].should be_nil
    end

    it "return the specified configuration option" do
      Kahana.http_adapter = @sample_adapter
      Kahana.settings[:http_adapter].should == @sample_adapter
    end

  end

  context ".options" do

    it "default to default settings" do
      Kahana.settings[:http_adapter].should == @default_adapter
      Kahana.options[:http_adapter].should == @default_adapter
    end

    it "are configurable" do
      Kahana.http_adapter = @sample_adapter
      Kahana.options[:http_adapter].should == @sample_adapter
    end

  end

  context ".reset!" do

    it "restores the library defaults" do
      Kahana.http_adapter = @sample_adapter
      Kahana.http_adapter.should == @sample_adapter
      Kahana.reset!
      Kahana.http_adapter.should == @default_adapter
    end

  end

end

