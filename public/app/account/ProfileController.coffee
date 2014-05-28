angular.module 'app'
  .controller 'ProfileController', ($scope, AuthService, IdentityService, NotifierService) ->
    u = IdentityService.currentUser
    $scope.email = u.username
    $scope.fname = u.firstName
    $scope.lname = u.lastName

    $scope.update = ->
      newUserData =
        username:  $scope.email
        firstName: $scope.fname
        lastName:  $scope.lname

      newPassword = $scope.password
      if newPassword?.length > 0
        newUserData.password = newPassword

      AuthService.updateCurrentUser newUserData
        .then ->
          NotifierService.notify 'Your user account has been updated'
        , (reason) ->
          NotifierService.error reason

