def initialize name
  @name = name
  @arrows = []
end

attr_reader :name, :arrows

def arrow &block
  @arrows << Arrow.new(@name, &block)
end

def === value
  self[value].ok?
end

def [] value
  Instance.new self, value
end

class Arrow
  def initialize name, &block
    @name = name
    instance_exec &block if block_given?
  end

  attr_reader :name, :input, :expected_output

  def from *all
    @input = all
  end

  def to one
    @expected_output = one
  end

  def [] value
    Instance.new self, value
  end

  class Instance
    def initialize type, value
      @actual_output = value.send type.name, *type.input
      @ok = @actual_output == type.expected_output
    rescue
      @error = $!
    end

    attr_reader :error

    def ok?
      @ok
    end
  end
end

class Instance
  def initialize type, value
    @name = type.name
    @available = value.respond_to? @name
    @arrows = type.arrows.map &[value]
    @ok = @available && @arrows.all?(&:ok?)
  end

  attr_reader :name, :arrows

  def available?
    @available
  end

  def ok?
    @ok
  end
end
