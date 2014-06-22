app = angular.module 'app', ['ngResource','ngRoute', 'ui.bootstrap', 'dialogs', 'truncate']

app.config ($routeProvider, $locationProvider)->
  routeRoleCheck =
    admin:  auth: (AuthService) -> AuthService.authorizeCurrentUserForRoute 'admin'
    user:   auth: (AuthService) -> AuthService.authorizeAuthenticatedUserForRoute()

  $locationProvider.html5Mode true

  $routeProvider
    .when '/',
      templateUrl: '/partials/main/main'
      controller: 'MainController'

    .when '/about',
      templateUrl: '/partials/about/about'
      controller: 'AboutController'

    .when '/admin/users',
      templateUrl: '/partials/admin/user-list'
      controller: 'UserListController'
      resolve: routeRoleCheck.admin

    .when '/admin/messages/:userId',
      templateUrl: '/partials/admin/user-messages'
      controller: 'UserMessagesController'
      resolve: routeRoleCheck.admin

    .when '/admin/ratings/:userId',
      templateUrl: '/partials/admin/user-ratings'
      controller: 'UserRatingsController'
      resolve: routeRoleCheck.admin

    .when '/courses/new',
      templateUrl: '/partials/courses/new-course'
      controller: 'NewCourseController'
      resolve: routeRoleCheck.admin

    .when '/courses/edit/:id',
      templateUrl: '/partials/courses/new-course'
      controller: 'EditCourseController'
      resolve: routeRoleCheck.admin

    .when '/signup',
      templateUrl: '/partials/account/signup'
      controller: 'SignupController'

    .when '/profile',
      templateUrl: '/partials/account/profile'
      controller: 'ProfileController'
      resolve: routeRoleCheck.user

    .when '/courses',
      templateUrl: '/partials/courses/course-list'
      controller: 'CourseController'

    .when '/courses/:id',
      templateUrl: '/partials/courses/course-details'
      controller: 'CourseDetailsController'

    .when '/courses/:courseId/challenge/new',
      templateUrl: '/partials/challenges/new-challenge'
      controller: 'NewChallengeController'
      resolve: routeRoleCheck.admin

    .when '/courses/:courseId/challenge/:challengeId',
      templateUrl: '/partials/challenges/challenge-details'
      controller: 'ChallengeDetailsController'

    .when '/courses/:courseId/challenge/edit/:challengeId',
      templateUrl: '/partials/challenges/new-challenge'
      controller: 'EditChallengeController'
      resolve: routeRoleCheck.admin

app.run ($rootScope, $location) ->
  $rootScope.$on '$routeChangeError', (evt, current, previous, rejection) ->
    if rejection is 'not authorized'
      $location.path '/'