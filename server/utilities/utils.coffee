String::contains = (value) ->
  @indexOf(value) >= 0

String::startsWith = (value) ->
  @indexOf(value) is 0
