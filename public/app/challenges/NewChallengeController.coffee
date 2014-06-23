angular.module 'app'
.controller 'NewChallengeController', ($scope, ChallengeEditor, $location, $routeParams, NotifierService, ControlsProvider) ->

  courseId = $routeParams.courseId

  $scope.formTitle = "New Challenge"
  $scope.levels = ["basic","advanced","expert"]
  $scope.controls = ControlsProvider.getControls()

  $scope.submit = ->

    try
      parsedConfig = JSON.parse $scope.config
    catch
      return NotifierService.error 'Cannot parse configuration to JSON'

    newChallengeData =
      title:       $scope.title
      description: $scope.description
      level:       $scope.level
      config:      parsedConfig
      control:     $scope.control
      courseId:    courseId

    ChallengeEditor.createChallenge newChallengeData
    .then (challenge) ->
      NotifierService.notify 'New challenge created successfully'
      $location.path "/courses/#{courseId}/challenge/#{challenge._id}"
    , NotifierService.error