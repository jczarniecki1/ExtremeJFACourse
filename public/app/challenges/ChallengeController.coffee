angular.module 'app'
.controller 'ChallengeController', ($scope, $routeParams, CachedChallenge, CachedCourse, NotifierService) ->
  courseId = $routeParams.id

  $scope.course = (CachedCourse.query().filter (c) -> c._id is courseId)[0]
  $scope.challenges = CachedChallenge.query {courseId}

  $scope.delete = (id) ->
    CachedChallenge.remove(courseId, id).then ->
      NotifierService.notify "Challenge removed successfully"
    , (error) ->
      NotifierService.error error
