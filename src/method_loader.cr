require "yaml"

class MethodLoader
  alias HttpStatusObject = Hash(Int32, Hash(String, String))

  def self.load
    HttpStatusObject.from_yaml(loaded_file)
  rescue e
    puts e
    exit
  end

  def self.loaded_file
    {{ read_file(__DIR__ + "/http_status_codes.yml") }}
  end
end
