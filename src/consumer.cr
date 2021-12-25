require "yaml"
require "./cli"

class Consumer
  def initialize(cli_options : Cli::CliOptions, yaml : YAML::Any)
    @options = cli_options
    @yaml = yaml
  end

  def process
    reject_invalid_params
    pretty_print_status yaml[code]
  rescue
    puts "Whichttp was unable to find anything worthwhile for you. Perhaps your arguments are unexpected?"
  end

  def status_code_from_symbol
    yaml_key = 200
    yaml.as_h.each do |k, v|
      if v.as_h.has_key?("rails_symbol") && v.as_h["rails_symbol"].to_s == symbol
        yaml_key = k
      end
    end
    yaml_key
  end

  def yaml
    @yaml
  end

  def code
    if @options.code.is_a? String
      @options.code.as(String).to_i
    else
      status_code_from_symbol
    end
  end

  def symbol
    @options.symbol
  end

  private def pretty_print_status(status_code_object)
    puts "HTTP CODE: #{code.to_s} #{status_code_object["short_description"]}"
    puts "============"
    puts status_code_object["long_description"]
    if status_code_object.as_h.has_key? "rails_symbol"
      puts "============"
      puts "Rails symbol #{status_code_object["rails_symbol"]}"
    end
  end

  private def reject_invalid_params
    if symbol.nil?
      raise "Invalid Status Code Provided" unless valid_codes.includes?(code)
    else
      raise "Invalid Symbol Provided" unless valid_symbols.includes?(symbol)
    end
  end

  private def valid_codes
    yaml.as_h.keys
  end

  private def valid_symbols
    symbols = [] of String
    yaml.as_h.each do |k, v|
      if v.as_h.has_key?("rails_symbol")
        symbols << v.as_h["rails_symbol"].to_s
      end
    end
    symbols
  end
end
