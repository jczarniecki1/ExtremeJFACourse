angular.module 'app'
.controller 'EditCourseController', ($scope, CachedCourse, NotifierService, $location, $routeParams) ->
  courseId = $routeParams.id
  CachedCourse.query().$promise
  .then (collection) ->
    collection.findById courseId, (course) ->
      $scope.course = course
      $scope.title = course.title
      $scope.localFilePath = course.localFilePath
      $scope.localFileName = course.localFileName
      $scope.presentationUrl = course.presentationUrl
      $scope.description = course.description
      $scope.featured = course.featured
      $scope.tags = course.tags.join(', ')

  $scope.submit = ->

    updatedCourseData =
      title:           $scope.title
      localFilePath:   $scope.localFilePath
      localFileName:   $scope.localFileName
      presentationUrl: $scope.presentationUrl
      description:     $scope.description
      featured:        $scope.featured
      tags:           ($scope.tags or "")
        .replace(/[^a-zA-Z]*/,' ')
        .split(' ')[1..]
        .filter (x)-> x.length > 0

    clone = angular.copy $scope.course
    angular.extend clone, updatedCourseData

    clone.$update({id:courseId})
    .then ->
      NotifierService.notify 'Course updated successfully'
      angular.extend $scope.course, updatedCourseData
      $location.path "/courses/#{courseId}"
    , NotifierService.error