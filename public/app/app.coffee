angular.module 'app', ['ngResource','ngRoute']

angular.module 'app'
  .config ($routeProvider, $locationProvider)->
    $locationProvider.html5Mode true
    $routeProvider
      .when '/',
        templateUrl: '/partials/main/main',
        controller: 'mainController'
