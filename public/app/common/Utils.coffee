String::contains = (value) ->
  @indexOf(value) >= 0

String::startsWith = (value) ->
  @indexOf(value) is 0

Array::remove = (value) ->
  index = @indexOf value
  if index >= 0 then @splice index, 1

Array::findById = (id, callback, onError) ->
  for element, index in @
    if element._id is id
      callback(element)
      return index
  if onError? then onError()