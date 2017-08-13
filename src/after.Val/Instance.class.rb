def initialize type, value
  @ok = type === value

  @keys = type.keys.transform_values &[value]
  @messages = type.messages.transform_values &[value]

  @type, @value = type, value
end

attr_reader :type, :value

def key key
  @keys[key]
end

def ok?
  @ok
end


def present_keys
  @present_keys ||= @keys.select{|_,v|v.ok?}.to_h.keys
end

def missing_keys
  @missing_keys ||= @keys.reject{|_,v|v.ok?}.to_h.keys
end

def present_messages
  @present_messages ||= @messages.select{|_,v|v.ok?}.to_h.keys
end

def missing_messages
  @missing_messages ||= @messages.reject{|_,v|v.ok?}.to_h.keys
end
