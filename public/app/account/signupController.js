// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').controller('SignupController', function($scope, AuthService, UserModel, NotifierService, $location) {
    return $scope.signup = function() {
      var newUserData;
      newUserData = {
        username: $scope.email,
        password: $scope.password,
        firstName: $scope.fname,
        lastName: $scope.lname
      };
      return AuthService.createUser(newUserData).then(function() {
        NotifierService.notify('User account created');
        return $location.path('/');
      }, function(reason) {
        return NotifierService.error(reason);
      });
    };
  });

}).call(this);

//# sourceMappingURL=SignupController.map
