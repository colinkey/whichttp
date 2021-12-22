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
    return "./http_status_codes.yml" if File.exists?("./http_status_codes.yml")
    return "./src/http_status_codes.yml" if File.exists?("./src/http_status_codes.yml")

    raise "Unable to resolve status codes config"
  end
end
