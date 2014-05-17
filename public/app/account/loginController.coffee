angular.module 'app'
  .controller 'loginController', ($scope, $http, mvNotifier, mvIdentity, mvAuth)->
    $scope.identity = mvIdentity
    $scope.signin = (username, password) ->
      mvAuth.authenticateUser username, password
        .then (success)->
          if success
            mvNotifier.notify 'You have successfully signed in!'
          else
            mvNotifier.warning 'Failed to log in.'
