String::contains = (value) ->
  @indexOf(value) >= 0

Array::any = (fn) ->
  for value in @
    if fn(value) then return true
  return false

String::startsWith = (value) ->
  @indexOf(value) is 0

Array::remove = (value) ->
  index = @indexOf value
  if index >= 0 then @splice index, 1

Array::avg = (selector) ->
  if @length is 0
    0
  else
    sum = 0
    sum += selector(x) for x in @
    sum / @length
