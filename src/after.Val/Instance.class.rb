def initialize type, value
  @claims = type.claims.map &[value]
  @ok = @claims.all? &:ok?

  keys = @claims.grep Key::Instance
  unless keys.empty?
    @keys = keys.map { |key| [key.name, key] }.to_h
    @present_keys ||= keys.select(&:ok?).map(&:name)
    @missing_keys ||= keys.reject(&:ok?).map(&:name)
  end

  messages = @claims.grep Message::Instance
  unless messages.empty?
    @messages = messages.map { |key| [key.name, key] }.to_h
    @present_messages = messages.select(&:ok?).map(&:name)
    @missing_messages = messages.reject(&:ok?).map(&:name)
  end

  @type, @value = type, value
end

attr_reader :claims, :type, :value
attr_reader :keys, :messages,
  :present_keys, :missing_keys,
  :present_messages, :missing_messages

def m name
  messages[name]
end

def key key
  keys[key]
end

def ok?
  @ok
end
