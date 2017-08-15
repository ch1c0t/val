def initialize name
  @name = name
end

attr_reader :name

def === value
  self[value].ok?
end

def [] value
  Instance.new self, value
end

class Instance
  def initialize type, value
    @ok = value.respond_to? type.name
  end

  def ok?
    @ok
  end
end
