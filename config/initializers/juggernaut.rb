#https://github.com/tsigo/jugglf/blob/a1c512cc011421cf15091f4d3bb348031936c435/config/initializers/juggernaut.rb
module Juggernaut
  def self.[](key)
    unless @config
      raw_config = File.read("#{Rails.root}/config/juggernaut.yml")
      @config = YAML.load(raw_config)[Rails.env].symbolize_keys
    end
    @config[key]
  end

  def self.[]=(key, value)
    @config[key.to_sym] = value
  end
end