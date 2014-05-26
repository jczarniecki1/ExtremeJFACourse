
angular.module 'app'
  .controller 'MainController', ($scope, CachedCourse)->
    $scope.title = 'Extreme JFA Course'
    $scope.courses = CachedCourse.query()