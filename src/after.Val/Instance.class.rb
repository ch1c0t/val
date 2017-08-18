def initialize type, value
  @claims = type.claims.map &[value]
  @ok = @claims.all? &:ok?

  set_all_instances_of_type Key::Instance
  set_all_instances_of_type Message::Instance

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

private
  def set_all_instances_of_type type
    instances = @claims.grep type
    plural_name = "#{type.name.split('::')[1].downcase}s"

    instance_variable_set :"@#{plural_name}",
      instances.map { |instance| [instance.name, instance] }.to_h

    present_instances, missing_instances = instances.partition &:ok?
    instance_variable_set :"@present_#{plural_name}", present_instances.map(&:name)
    instance_variable_set :"@missing_#{plural_name}", missing_instances.map(&:name)
  end
