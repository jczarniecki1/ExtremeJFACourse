String::contains = (value) ->
  @indexOf(value) >= 0

String::startsWith = (value) ->
  @indexOf(value) is 0

Array::remove = (value) ->
  index = @indexOf value
  if index >= 0 then @splice index, 1
