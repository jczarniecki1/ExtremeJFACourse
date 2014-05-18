angular.module 'app'
  .controller 'profileController', ($scope, mvAuth, mvIdentity, mvNotifier) ->
    u = mvIdentity.currentUser
    $scope.email = u.username
    $scope.fname = u.firstName
    $scope.lname = u.lastName

    $scope.update = ->
      newUserData =
        username: $scope.email
        firstName: $scope.fname
        lastName: $scope.lname

      newPassword = $scope.password
      if newPassword && newPassword.length > 0
        newUserData.password = newPassword

      mvAuth.updateCurrentUser newUserData
        .then ->
          mvNotifier.notify 'Your user account has been updated'
        , (reason) ->
          mvNotifier.error reason

