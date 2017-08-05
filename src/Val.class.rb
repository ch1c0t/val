require 'to_proc/all'

OR = -> *values do
  -> value do
    values.any? &[:===, value]
  end
end

def OR *all
  OR[*all]
end

def initialize &block
  @conditions = []
  result = instance_exec &block
  if @conditions.empty?
    condition = result
    @conditions << condition
  end
end

def key name, *conditions
  first = conditions.first

  if first.is_a?(Module) || first.is_a?(Val) || first.equal?(nil)
    type = first
    @conditions << Key.new(name, type)
  else
    @conditions.concat conditions.map { |condition|
      -> value {
        begin
          condition.to_proc === value[name] 
        rescue ArgumentError
          false
        end
      }
    }
  end
end

def is_a type
  condition = -> value { value.is_a? type }
  @conditions << condition
end

def === value
  @conditions.all? &[:===, value]
end

Bool = new { OR[true, false] }
