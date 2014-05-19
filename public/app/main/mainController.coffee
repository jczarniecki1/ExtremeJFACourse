
angular.module 'app'
  .controller 'mainController', ($scope, mvCachedCourse)->
    $scope.title = 'Extreme JFA Course'
    $scope.courses = mvCachedCourse.query()