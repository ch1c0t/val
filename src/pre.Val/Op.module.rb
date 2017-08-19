OR = -> *values do
  -> value do
    values.any? &[:===, value]
  end
end
