// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').factory('AuthService', function($http, IdentityService, UserModel, $q) {
    var AuthService;
    AuthService = (function() {
      function AuthService() {}

      AuthService.prototype.authenticateUser = function(username, password) {
        var $d;
        $d = $q.defer();
        $http.post('/login', {
          username: username,
          password: password
        }).then(function(response) {
          var user;
          if (response.data.success) {
            user = new UserModel();
            angular.extend(user, response.data.user);
            IdentityService.currentUser = user;
            return $d.resolve(true);
          } else {
            return $d.resolve(false);
          }
        });
        return $d.promise;
      };

      AuthService.prototype.logoutUser = function() {
        var $d;
        $d = $q.defer();
        $http.post('/logout', {
          logout: true
        }).then(function() {
          IdentityService.currentUser = void 0;
          return $d.resolve();
        });
        return $d.promise;
      };

      AuthService.prototype.authorizeCurrentUserForRoute = function(role) {
        if (IdentityService.isAuthorized(role)) {
          return true;
        } else {
          return $q.reject('not authorized');
        }
      };

      AuthService.prototype.authorizeAuthenticatedUserForRoute = function() {
        if (IdentityService.isAuthenticated()) {
          return true;
        } else {
          return $q.reject('not authorized');
        }
      };

      AuthService.prototype.createUser = function(newUserData) {
        var $d, newUser;
        newUser = new UserModel(newUserData);
        $d = $q.defer();
        newUser.$save().then(function() {
          IdentityService.currentUser = newUser;
          return $d.resolve();
        }, function(error) {
          return $d.reject(error);
        });
        return $d.promise;
      };

      AuthService.prototype.updateCurrentUser = function(updatedUserData) {
        var $d, clone;
        $d = $q.defer();
        clone = angular.copy(IdentityService.currentUser);
        angular.extend(clone, updatedUserData);
        clone.$update().then(function() {
          IdentityService.currentUser = clone;
          return $d.resolve();
        }, function(error) {
          return $d.reject(error);
        });
        return $d.promise;
      };

      return AuthService;

    })();
    return new AuthService();
  });

}).call(this);

//# sourceMappingURL=AuthService.map
