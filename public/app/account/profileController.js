// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').controller('ProfileController', function($scope, AuthService, IdentityService, NotifierService) {
    var u;
    u = IdentityService.currentUser;
    $scope.email = u.username;
    $scope.fname = u.firstName;
    $scope.lname = u.lastName;
    return $scope.update = function() {
      var newPassword, newUserData;
      newUserData = {
        username: $scope.email,
        firstName: $scope.fname,
        lastName: $scope.lname
      };
      newPassword = $scope.password;
      if (newPassword && newPassword.length > 0) {
        newUserData.password = newPassword;
      }
      return AuthService.updateCurrentUser(newUserData).then(function() {
        return NotifierService.notify('Your user account has been updated');
      }, function(reason) {
        return NotifierService.error(reason);
      });
    };
  });

}).call(this);

//# sourceMappingURL=ProfileController.map
