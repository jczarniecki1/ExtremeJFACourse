angular.module 'app'
  .controller 'courseController', ($scope, mvCachedCourse) ->
    $scope.courses = mvCachedCourse.query()

    $scope.sortOptions = [
      { value: "title", text: "Sort by Title" },
      { value: "published", text: "Sort by Publish Date" }
    ]
    $scope.sortOrder = $scope.sortOptions[0].value