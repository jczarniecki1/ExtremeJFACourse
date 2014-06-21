angular.module 'app'
.controller 'MainController', ($scope, CachedCourse, IdentityService)->
  $scope.identity = IdentityService
  $scope.title = 'Extreme JFA Course'
  $scope.courses = CachedCourse.query()