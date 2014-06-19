angular.module 'app'
.controller 'LoginController', ($scope, $http, NotifierService, IdentityService, AuthService, $location) ->

  $scope.identity = IdentityService

  $scope.signin = (username, password) ->
    AuthService.authenticateUser username, password
    .then (success) ->
      if success
        NotifierService.notify 'You have successfully signed in!'
      else
        NotifierService.warning 'Failed to log in.'

  userActions = $('#userActions')
  userActions.find('.dropdown-toggle').click -> userActions.toggleClass 'open'

  $scope.signout = ->
    AuthService.logoutUser()
    .then ->
      $scope.username = ""
      $scope.password = ""
      NotifierService.info 'You have succeessfully signed out'
      $location.path '/'