angular.module 'app'
.controller 'NewCourseController', ($scope, CourseEditor, NotifierService, $location) ->
  $scope.submit = ->

    newCourseData =
      title:           $scope.title
      localFilePath:   $scope.localFilePath
      localFileName:   $scope.localFileName
      presentationUrl: $scope.presentationUrl
      videoUrl: $scope.videoUrl
      description:     $scope.description
      featured:        $scope.featured
      tags:           ($scope.tags or "")
        .replace(/[^a-zA-Z]*/,' ')
        .split(' ')[1..]
        .filter (x)-> x.length > 0

    CourseEditor.createCourse newCourseData
    .then (course) ->
      NotifierService.notify 'New course created successfully'
      $location.path "/courses/#{course._id}"
    , NotifierService.error