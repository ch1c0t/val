def self.new name, condition 
  if [Module, Val].any? &[condition, :is_a?]
    Type.new name, condition
  else
    Array.new name, condition
  end
end

attr_reader :name

def initialize name, condition = nil
  @name, @condition = name, condition
end

def === value
  value.respond_to?(:[]) && value[@name] && valid?(value[@name])
end

def valid? _value
  true
end
