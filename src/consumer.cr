require "./cli"
require "./method_loader"

class Consumer
  def initialize(cli_options : Cli::CliOptions, http_methods_config : MethodLoader::HttpStatusObject)
    @options = cli_options
    @http_methods_config = http_methods_config
  end

  def process
    reject_invalid_params
    pretty_print_status
  rescue
    puts "Whichttp was unable to find anything worthwhile for you. Perhaps your arguments are unexpected?"
  end

  def status_code_from_symbol
    http_methods_config_key = 200
    http_methods_config.each do |k, v|
      if v.has_key?("rails_symbol") && v["rails_symbol"] == symbol
        http_methods_config_key = k
      end
    end
    http_methods_config_key
  end

  def http_methods_config
    @http_methods_config
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

  private def pretty_print_status
    status_code_object = http_methods_config[code]
    puts "HTTP CODE: #{code.to_s} #{status_code_object["short_description"]}"
    puts "============"
    puts status_code_object["long_description"]
    if status_code_object.has_key? "rails_symbol"
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
    http_methods_config.keys
  end

  private def valid_symbols
    symbols = [] of String
    http_methods_config.each do |k, v|
      if v.has_key?("rails_symbol")
        symbols << v["rails_symbol"]
      end
    end
    symbols
  end
end
