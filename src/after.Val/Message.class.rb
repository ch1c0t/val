def initialize name
  @name = name
end

attr_reader :name

def === value
  value.respond_to? @name
end
