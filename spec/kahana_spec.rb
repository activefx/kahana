require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Kahana" do

  it "must be defined" do
    Kahana::VERSION.should_not be_nil
  end

end

