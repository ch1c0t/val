OR = -> *values do
  -> value do
    values.any? &[:===, value]
  end
end

NOT = -> question do
  -> value do
    not value.send question
  end
end
