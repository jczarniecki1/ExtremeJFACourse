angular.module 'app'
  .controller 'CourseDetailsController', ($scope, CachedCourse, $routeParams, IdentityService, NotifierService, $location) ->
    $scope.identity = IdentityService

    $scope.delete = ->
      CachedCourse.remove($routeParams.id).then ->
        NotifierService.notify "Course removed successfully"
        $location.path "/"
      , (reason) ->
        NotifierService.error reason


    CachedCourse.query().$promise.then (collection) ->
      collection.forEach (course) ->
        if course._id is $routeParams.id
          $scope.course = course
          false