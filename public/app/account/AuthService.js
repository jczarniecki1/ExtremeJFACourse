// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').factory('AuthService', function($http, IdentityService, UserModel, $q) {
    return {
      authenticateUser: function(username, password) {
        var deferred;
        deferred = $q.defer();
        $http.post('/login', {
          username: username,
          password: password
        }).then(function(response) {
          var user;
          if (response.data.success) {
            user = new UserModel();
            angular.extend(user, response.data.user);
            IdentityService.currentUser = user;
            return deferred.resolve(true);
          } else {
            return deferred.resolve(false);
          }
        });
        return deferred.promise;
      },
      logoutUser: function() {
        var deferred;
        deferred = $q.defer();
        $http.post('/logout', {
          logout: true
        }).then(function() {
          IdentityService.currentUser = void 0;
          return deferred.resolve();
        });
        return deferred.promise;
      },
      authorizeCurrentUserForRoute: function(role) {
        if (IdentityService.isAuthorized(role)) {
          return true;
        } else {
          return $q.reject('not authorized');
        }
      },
      authorizeAuthenticatedUserForRoute: function() {
        if (IdentityService.isAuthenticated()) {
          return true;
        } else {
          return $q.reject('not authorized');
        }
      },
      createUser: function(newUserData) {
        var deferred, newUser;
        newUser = new UserModel(newUserData);
        deferred = $q.defer();
        newUser.$save().then(function() {
          IdentityService.currentUser = newUser;
          return deferred.resolve();
        }, function(error) {
          return deferred.reject(error);
        });
        return deferred.promise;
      },
      updateCurrentUser: function(updatedUserData) {
        var clone, deferred;
        deferred = $q.defer();
        clone = angular.copy(IdentityService.currentUser);
        angular.extend(clone, updatedUserData);
        clone.$update().then(function() {
          IdentityService.currentUser = clone;
          return deferred.resolve();
        }, function(error) {
          return deferred.reject(error);
        });
        return deferred.promise;
      }
    };
  });

}).call(this);

//# sourceMappingURL=AuthService.map
