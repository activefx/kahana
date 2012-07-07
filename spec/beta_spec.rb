require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Beta" do

  it "must be defined" do
    Beta::VERSION.should_not be_nil
  end

end

