def initialize name
  @name = name
  @keys, @messages = {}, {}
end

attr_reader :name

def === value
  value.respond_to? @name
end


attr_reader :keys, :messages

def [] value
  Instance.new self, value
end
