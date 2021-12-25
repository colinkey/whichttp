require "option_parser"

class Cli
  struct CliOptions
    property code, symbol

    def initialize(@code : String?, @symbol : String?)
    end
  end

  def self.call
    code = nil
    symbol = nil
    OptionParser.parse do |parser|
      parser.on "-c PASSED_CODE", "--code PASSED_CODE", "Look up status by code. Default behavior of Whichttp and flag is optional" do |passed_code|
        code = passed_code
      end

      parser.on "-s PASSED_SYMBOL", "--symbol PASSED_SYMBOL", "Look up status by rails symbol" do |passed_symbol|
        symbol = passed_symbol
      end

      parser.unknown_args do |args|
        code = args.first unless args.empty?
      end
    end

    CliOptions.new(
      code: code,
      symbol: symbol,
    )
  end
end


