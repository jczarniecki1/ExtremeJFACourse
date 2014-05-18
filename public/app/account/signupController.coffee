angular.module 'app'
  .controller 'signupController', ($scope, mvAuth, mvUser, mvNotifier, $location) ->
    $scope.signup = ->

      newUserData =
        username: $scope.email
        password: $scope.password
        firstName: $scope.fname
        lastName: $scope.lname

      mvAuth.createUser newUserData
        .then ->
          mvNotifier.notify 'User account created'
          $location.path '/'
        , (reason) ->
          mvNotifier.error reason