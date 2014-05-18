// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app', ['ngResource', 'ngRoute']);

  angular.module('app').config(function($routeProvider, $locationProvider) {
    var routeRoleCheck;
    routeRoleCheck = {
      admin: {
        auth: function(mvAuth) {
          return mvAuth.authorizeCurrentUserForRoute('admin');
        }
      },
      user: {
        auth: function(mvAuth) {
          return mvAuth.authorizeAuthenticatedUserForRoute();
        }
      }
    };
    $locationProvider.html5Mode(true);
    return $routeProvider.when('/', {
      templateUrl: '/partials/main/main',
      controller: 'mainController'
    }).when('/admin/users', {
      templateUrl: '/partials/admin/user-list',
      controller: 'userListController',
      resolve: routeRoleCheck.admin
    }).when('/signup', {
      templateUrl: '/partials/account/signup',
      controller: 'signupController'
    }).when('/profile', {
      templateUrl: '/partials/account/profile',
      controller: 'profileController',
      resolve: routeRoleCheck.user
    });
  });

  angular.module('app').run(function($rootScope, $location) {
    return $rootScope.$on('$routeChangeError', function(evt, current, previous, rejection) {
      if (rejection === 'not authorized') {
        return $location.path('/');
      }
    });
  });

}).call(this);

//# sourceMappingURL=app.map
