def initialize type, value
  @ok = type === value

  @present_keys, @missing_keys = part type.keys, value
  @present_messages, @missing_messages = part type.messages, value
end

attr_reader :present_keys, :missing_keys, :missing_messages

def ok?
  @ok
end

private
  def part assertions, value
    assertions
      .partition { |_name, assertion| assertion === value }
      .map { |group| group.map(&:first) }
  end
