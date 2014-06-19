setLocation = (desiredLocation) ->
  window.location = desiredLocation unless window.location != desiredLocation

scenario = ->
  setLocation '/courses'
#  $('[ng-model="username"]').val 'admin'
  $('[ng-model="username"]').val 'joe@pj.com'
  $('[ng-model="username"]').trigger 'change'
#  $('[ng-model="password"]').val 'xxx'
  $('[ng-model="password"]').val 'asd'
  $('[ng-model="password"]').trigger 'change'
  $('#login:visible').trigger 'click'

  console.debug '>> scenario finished...'

try
  console.debug '>> executing scenario...'
  setTimeout scenario, 1000
catch
  console.debug '>> cannot execute defined scenario...'