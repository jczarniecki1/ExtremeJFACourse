// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').controller('LoginController', function($scope, $http, NotifierService, IdentityService, AuthService, $location) {
    var userActions;
    $scope.identity = IdentityService;
    $scope.signin = function(username, password) {
      return AuthService.authenticateUser(username, password).then(function(response) {
        if (response != null ? response.success : void 0) {
          return NotifierService.notify('You have successfully signed in!');
        } else {
          if (response != null ? response.reason : void 0) {
            return NotifierService.warning("Failed to log in. Wrong " + response.reason);
          } else {
            return NotifierService.error('Cannot log in. Request not accepted');
          }
        }
      });
    };
    userActions = $('#userActions');
    userActions.find('.dropdown-toggle').click(function() {
      return userActions.toggleClass('open');
    });
    return $scope.signout = function() {
      return AuthService.logoutUser().then(function() {
        $scope.username = "";
        $scope.password = "";
        NotifierService.info('You have succeessfully signed out');
        return $location.path('/');
      });
    };
  });

}).call(this);

//# sourceMappingURL=LoginController.map
