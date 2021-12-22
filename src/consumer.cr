require "yaml"
require "./cli"

class Consumer
  @code : Int32

  def initialize(cli_options : Cli::CliOptions, yaml : YAML::Any)
    @options = cli_options
    @yaml = yaml
    @code = cli_options.code.to_i
  end

  def process
    reject_invalid_params
    pretty_print(@yaml[@code])
  rescue
    puts "Whichttp was unable to find anything worthwhile for you. Perhaps your arguments are unexpected?"
  end

  private def pretty_print(status_code_object)
    puts "HTTP CODE: #{@code.to_s} #{status_code_object["short_description"]}"
    puts "============"
    puts status_code_object["long_description"]
  end

  private def reject_invalid_params
    raise "Invalid Status Code Provided" unless valid_codes.includes?(@code)
  end

  private def valid_codes
    @yaml.as_h.keys
  end
end
