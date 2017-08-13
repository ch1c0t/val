def initialize name
  @name = name
  @claims, @keys, @messages = [], {}, {}
end

attr_reader :name

def === value
  value.respond_to? @name
end


attr_reader :claims, :keys, :messages

def [] value
  Instance.new self, value
end
