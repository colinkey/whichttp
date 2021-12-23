require "yaml"

class MethodLoader
  def self.load
    yaml = YAML.parse(loaded_yaml)
  rescue e
    puts e
    Process.exit()
  end

  def self.loaded_yaml
    {{ read_file(__DIR__ + "/http_status_codes.yml") }}
  end
end
