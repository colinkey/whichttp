require "./method_loader"
require "./cli"
require "./consumer"

module Whichttp
  VERSION = "0.1.0"

  user_options = Cli.call
  method_yaml = MethodLoader.load

  Consumer.new(user_options, method_yaml).process
end
