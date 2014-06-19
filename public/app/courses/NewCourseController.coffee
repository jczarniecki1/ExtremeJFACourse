angular.module 'app'
.controller 'NewCourseController', ($scope, CourseEditor, NotifierService, $location) ->
  $scope.create = ->

    newCourseData =
      title:    $scope.title
      featured: $scope.featured
      tags:     ($scope.tags or "").split ','

    CourseEditor.createCourse newCourseData
    .then (course) ->
      NotifierService.notify 'New course created successfully'
      $location.path "/courses/#{course._id}"
    , NotifierService.error