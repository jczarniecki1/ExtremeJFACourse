angular.module 'app'
.controller 'ChallengeController', ($scope, $routeParams, CachedChallenge, CachedCourse, $location, NotifierService) ->
  courseId = $routeParams.id

  CachedCourse.query().$promise
  .then (collection) ->
    collection.findById courseId, (course) ->
      $scope.course = course

      if $scope.identity.currentUser?.courses.any((x) -> x.id is courseId)
        $scope.course.started = true

  $scope.challenges = CachedChallenge.query {courseId}

  $scope.open = (id) ->
    $location.path "/courses/#{courseId}/challenge/#{id}"

  $scope.edit = (id) ->
    $location.path "/courses/#{courseId}/challenge/edit/#{id}"

  $scope.delete = (id) ->
    CachedChallenge.remove(courseId, id).then ->
      NotifierService.notify "Challenge removed successfully"
    , (error) ->
      NotifierService.error error
