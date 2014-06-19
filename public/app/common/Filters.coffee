angular.module 'app'
.filter 'capitalize', ->
  (input, scope) ->
    if input?
      input = input.toLowerCase()
      input[0].toUpperCase() + input.substr(1)
