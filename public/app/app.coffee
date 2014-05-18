angular.module 'app', ['ngResource','ngRoute']

angular.module 'app'
  .config ($routeProvider, $locationProvider)->
    routeRoleCheck =
      admin:
        auth: (mvAuth) ->
          mvAuth.authorizeCurrentUserForRoute 'admin'

    $locationProvider.html5Mode true

    $routeProvider
      .when '/',
        templateUrl: '/partials/main/main',
        controller: 'mainController'

      .when '/admin/users',
        templateUrl: '/partials/admin/user-list',
        controller: 'userListController'
        resolve: routeRoleCheck.admin

      .when '/signup',
        templateUrl: '/partials/account/signup',
        controller: 'signupController'

angular.module 'app'
  .run ($rootScope, $location) ->
    $rootScope.$on '$routeChangeError', (evt, current, previous, rejection) ->
      if rejection == 'not authorized'
        $location.path '/'