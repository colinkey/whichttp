require "yaml"

class MethodLoader
  def self.load
    yaml = File.open(resolve_file_name) do |file|
      YAML.parse(file)
    end
  rescue e
    puts e
    Process.exit()
  end

  def self.resolve_file_name
    if File.exists?(__DIR__ + "/http_status_codes.yml")
      __DIR__ + "/http_status_codes.yml"
    else
      raise "Unable to resolve status codes config"
    end
  end
end
