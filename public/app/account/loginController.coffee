angular.module 'app'
  .controller 'loginController', ($scope, $http, mvNotifier, mvIdentity, mvAuth, $location)->
    $scope.identity = mvIdentity
    $scope.signin = (username, password) ->
      mvAuth.authenticateUser username, password
        .then (success)->
          if success
            mvNotifier.notify 'You have successfully signed in!'
          else
            mvNotifier.warning 'Failed to log in.'

    $scope.signout = ->
      mvAuth.logoutUser().then ->
        $scope.username = ""
        $scope.password = ""
        mvNotifier.info 'You have succeessfully signed out'
        $location.path '/'