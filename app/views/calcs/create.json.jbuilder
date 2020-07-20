json.calculation do
  json.Operation @calc.set_operation
  json.Result @calc.result
  json.ID @calc.id
  json.Count @calc.number_of_calcs
end