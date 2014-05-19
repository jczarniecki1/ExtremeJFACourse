angular.module 'app', ['ngResource','ngRoute']

angular.module 'app'
  .config ($routeProvider, $locationProvider)->
    routeRoleCheck =
      admin:
        auth: (mvAuth) ->
          mvAuth.authorizeCurrentUserForRoute 'admin'
      user:
        auth: (mvAuth) ->
          mvAuth.authorizeAuthenticatedUserForRoute()

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

      .when '/profile',
        templateUrl: '/partials/account/profile',
        controller: 'profileController'
        resolve: routeRoleCheck.user

      .when '/courses',
        templateUrl: '/partials/courses/course-list',
        controller: 'courseController'

      .when '/courses/:id',
        templateUrl: '/partials/courses/course-details',
        controller: 'courseDetailsController'

angular.module 'app'
  .run ($rootScope, $location) ->
    $rootScope.$on '$routeChangeError', (evt, current, previous, rejection) ->
      if rejection == 'not authorized'
        $location.path '/'