// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').controller('NewCourseController', function($scope, CourseEditor, NotifierService, $location) {
    return $scope.create = function() {
      var newCourseData;
      newCourseData = {
        title: $scope.title,
        featured: $scope.featured,
        tags: $scope.tags.split(',')
      };
      return CourseEditor.createCourse(newCourseData).then(function(course) {
        NotifierService.notify('New course created successfully');
        return $location.path("/courses/" + course._id);
      }, function(reason) {
        return NotifierService.error(reason);
      });
    };
  });

}).call(this);

//# sourceMappingURL=NewCourseController.map
