String::contains = (value) ->
  @indexOf(value) >= 0

String::startsWith = (value) ->
  @indexOf(value) is 0

Array::remove = (value) ->
  index = @indexOf value
  if index >= 0 then @splice index, 1

Array::avg = ->
  if @length is 0
    0
  else
    sum = 0
    sum += x for x in @
    sum / @length
