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
    file_path = Path.new(__FILE__).dirname + "/http_status_codes.yml"
    if File.exists?(file_path)
      file_path
    else
      raise "Unable to resolve status codes config at #{file_path.to_s}"
    end
  end
end
