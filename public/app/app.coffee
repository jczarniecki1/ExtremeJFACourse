angular.module 'app', ['ngResource','ngRoute']

angular.module 'app'
  .config ($routeProvider, $locationProvider)->
    $locationProvider.html5Mode true
    $routeProvider
      .when '/',
        templateUrl: '/partials/main',
        controller: 'mainController'

angular.module 'app'
  .controller 'mainController', ($scope)->
    $scope.title = 'Extreme JFA Course'
