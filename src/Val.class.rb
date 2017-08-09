require 'to_proc/all'

include DSL

def initialize &block
  @conditions = []
  result = instance_exec &block
  if @conditions.empty?
    condition = result
    @conditions << condition
  end
end

def === value
  @conditions.all? &[:===, value]
end

def [] value
  report = Report.new

  if self === value
    report.ok = true
  end

  report
end

Bool = new { OR(true, false) }
