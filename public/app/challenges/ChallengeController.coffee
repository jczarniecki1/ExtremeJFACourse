angular.module 'app'
  .controller 'ChallengeController', ($scope, $routeParams, CachedChallenge, CachedCourse) ->
    courseId = $routeParams.id

    $scope.course = (CachedCourse.query().filter (c) -> c._id is courseId)[0]
    $scope.challenges = CachedChallenge.query {courseId}