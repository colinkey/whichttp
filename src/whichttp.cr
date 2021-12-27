require "./method_loader"
require "./cli"
require "./consumer"

module Whichttp
  VERSION = "0.1.0"

  user_options = Cli.call
  http_method_config = MethodLoader.load

  Consumer.new(user_options, http_method_config).process
end
