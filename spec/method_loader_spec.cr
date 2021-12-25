require "./spec_helper"
require "yaml"

describe MethodLoader do
  it "should property load yaml and return hash" do
    results = MethodLoader.load
    results.class.should eq(YAML::Any)
  end

  it "should return properly formatted yaml object" do
    results = MethodLoader.load
    first_result = results[results.as_h.keys.first].as_h
    first_result.has_key?("short_description").should eq(true)
    first_result.has_key?("long_description").should eq(true)
    first_result.has_key?("rails_symbol").should eq(true)
  end
end
