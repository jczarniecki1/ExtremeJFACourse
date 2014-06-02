angular.module 'app'
  .controller 'CourseDetailsController', ($scope, CachedCourse, $routeParams, IdentityService, NotifierService, $location) ->
    $scope.identity = IdentityService

    $scope.delete = ->
      CachedCourse.remove($routeParams.id).then ->
        NotifierService.notify "Course removed successfully"
        $location.path "/"
      , (error) ->
        NotifierService.error error

    $scope.myRate = 2

    $scope.rate = (rate) ->
      console.log rate
      $scope.myRate = rate

    $scope.rankHover = (rate) ->
      console.log rate
      $scope.rate = rate

    $scope.rankReset = () ->
      $scope.rate = $scope.myRate

    $scope.rankReset()

    CachedCourse.query().$promise.then (collection) ->
      collection.findById $routeParams.id, (course) ->
        $scope.course = course
