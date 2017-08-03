def initialize name, type
  @name, @type = name, type
end

def === value
  value.respond_to?(:[]) && value[@name] && valid_type?(value[@name])
end

def valid_type? name
  if @type
    @type === name
  else
    true
  end
end
