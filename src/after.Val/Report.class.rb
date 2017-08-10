def initialize type, value
  @ok = type === value

  @present_keys, @missing_keys = type.keys
    .partition(&[:===, value])
    .map { |keys| keys.map(&:name) }

  @present_messages, @missing_messages = type.messages
    .partition(&[:===, value])
    .map { |messages| messages.map(&:name) }
end

attr_reader :present_keys, :missing_keys, :missing_messages

def ok?
  @ok
end
