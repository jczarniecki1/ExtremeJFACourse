angular.module 'app'
  .controller 'CourseDetailsController', ($scope, CachedCourse, $routeParams, IdentityService) ->
    $scope.identity = IdentityService
    CachedCourse.query().$promise.then (collection) ->
      collection.forEach (course) ->
        if course._id is $routeParams.id
          $scope.course = course
          false