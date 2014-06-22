angular.module 'app'
.controller 'LoginController', ($scope, $http, NotifierService, IdentityService, AuthService, $location) ->

  $scope.identity = IdentityService

  signinUser = ->
    AuthService.authenticateUser $scope.username, $scope.password
    .then (response) ->
      if response?.success
        NotifierService.notify 'You have successfully signed in!'
      else
        if response?.reason
          NotifierService.warning "Failed to log in. Wrong #{response.reason}"
        else
          NotifierService.error 'Cannot log in. Request not accepted'

  $scope.signin = () ->
    unless $scope.username? or $scope.password?
      $('[ng-model="username"]').trigger 'change'
      $('[ng-model="password"]').trigger 'change'
      setTimeout signinUser, 100
    else
      signinUser()

  userActions = $('#userActions')
  userActions.find('.dropdown-toggle').click -> userActions.toggleClass 'open'

  $scope.signout = ->
    AuthService.logoutUser()
    .then ->
      $scope.username = ""
      $scope.password = ""
      NotifierService.info 'You have succeessfully signed out'
      $location.path '/'