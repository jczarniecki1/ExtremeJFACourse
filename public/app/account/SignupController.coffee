angular.module 'app'
.controller 'SignupController', ($scope, AuthService, UserModel, NotifierService, $location) ->

  $scope.signup = ->

    newUserData =
      username:  $scope.email
      password:  $scope.password
      firstName: $scope.fname
      lastName:  $scope.lname

    AuthService.createUser newUserData
    .then ->
      NotifierService.notify 'User account created'
      $location.path '/'
    , NotifierService.error