angular.module 'app'
  .controller 'CourseDetailsController', ($scope, CachedCourse, $routeParams, IdentityService, NotifierService, $location) ->
    $scope.identity = IdentityService

    $scope.delete = ->
      CachedCourse.remove($routeParams.id).then ->
        NotifierService.notify "Course removed successfully"
        $location.path "/"
      , (error) ->
        NotifierService.error error


    CachedCourse.query().$promise.then (collection) ->
      collection.findById $routeParams.id, (course) ->
        $scope.course = course
