require "option_parser"

class Cli
  struct CliOptions
    property code, symbol

    def initialize(@code : String?, @symbol : String?)
    end
  end

  def self.call
    passed_code = nil
    passed_symbol = nil

    OptionParser.parse do |parser|
      parser.on "-c CODE", "--code CODE", "Look up status by code. Default behavior of Whichttp and flag is optional" do |code|
        passed_code = code
      end

      parser.on "-s SYMBOL", "--symbol SYMBOL", "Look up status by rails symbol" do |symbol|
        passed_symbol = symbol
      end

      parser.on "-h", "--help", "Show help" do
        puts parser
        exit
      end

      parser.on "-a", "--acknowledgements", "Show acknowledgments" do
        puts acknowledgements
        exit
      end

      parser.unknown_args do |args|
        passed_code = args.first unless args.empty?
      end
    end

    CliOptions.new(
      code: passed_code,
      symbol: passed_symbol,
    )
  end

  def self.acknowledgements
    "Data for the HTTP status codes was obtained from the wikipedia entry for HTTP status codes at https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
Data for the valid rails symbols was obtained from the following gist https://gist.github.com/mlanett/a31c340b132ddefa9cca
Data is as accurate as of the last update on December 20th, 2021"
  end
end


