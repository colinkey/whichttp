require "yaml"

class MethodLoader
  def self.load
    yaml = File.open("./src/http_status_codes.yml") do |file|
      YAML.parse(file)
    end
  end
end
