angular.module 'app'
.controller 'EditChallengeController', ($scope, CachedChallenge, $location, $routeParams, ControlsProvider, NotifierService) ->

  courseId = $routeParams.courseId
  challengeId = $routeParams.challengeId

  $scope.formTitle = "Edit Challenge"
  $scope.levels = ["basic","advanced","expert"]
  $scope.controls = ControlsProvider.getControls()

  CachedChallenge.query({courseId}).$promise
  .then (collection) ->
    $scope.challengeIndex = collection.findById challengeId, (challenge) ->
      $scope.challenge = challenge
      $scope.title = challenge.title
      $scope.description = challenge.description
      $scope.level = challenge.level
      $scope.config = JSON.stringify challenge.config
      $scope.control = challenge.control

  $scope.submit = ->

    try
      parsedConfig = JSON.parse $scope.config
    catch
      return NotifierService.error 'Cannot parse configuration to JSON'

    updatedChallengeData =
      title:       $scope.title
      description: $scope.description
      level:       $scope.level
      config:      parsedConfig
      control:     $scope.control

    clone = angular.copy $scope.challenge
    angular.extend clone, updatedChallengeData

    clone.$update({courseId, id:challengeId})
    .then ->
      NotifierService.notify 'Challenge updated successfully'
      angular.extend $scope.challenge, updatedChallengeData
      $location.path "/courses/#{courseId}/challenge/#{challengeId}"
    , NotifierService.error