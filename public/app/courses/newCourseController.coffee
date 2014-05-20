angular.module 'app'
  .controller 'newCourseController', ($scope, mvCourseEditor, mvNotifier, $location) ->
    $scope.create = ->

      newCourseData =
        title: $scope.title
        featured: $scope.featured
        tags: $scope.tags.split(',')

      mvCourseEditor.createCourse newCourseData
        .then (course) ->
          mvNotifier.notify 'New course created successfully'
          $location.path '/courses/' + course._id
        , (reason) ->
          mvNotifier.error reason