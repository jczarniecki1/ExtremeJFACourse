angular.module 'app'
  .controller 'courseDetailsController', ($scope, mvCachedCourse, $routeParams) ->
    mvCachedCourse.query().$promise.then (collection) ->
      collection.forEach (course) ->
        if course._id == $routeParams.id
          $scope.course = course
          false