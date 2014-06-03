angular.module 'app'
.controller 'CourseController', ($scope, CachedCourse) ->
  $scope.courses = CachedCourse.query()

  $scope.sortOptions = [
    { value: "title", text: "Sort by Title" },
    { value: "published", text: "Sort by Publish Date" }
  ]
  $scope.sortOrder = $scope.sortOptions[0].value