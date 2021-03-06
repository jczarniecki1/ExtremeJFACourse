// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').controller('NewCourseController', function($scope, CourseEditor, NotifierService, $location) {
    return $scope.submit = function() {
      var newCourseData;
      newCourseData = {
        title: $scope.title,
        localFilePath: $scope.localFilePath,
        localFileName: $scope.localFileName,
        presentationUrl: $scope.presentationUrl,
        videoUrl: $scope.videoUrl,
        description: $scope.description,
        featured: $scope.featured,
        tags: ($scope.tags || "").replace(/[^a-zA-Z]*/, ' ').split(' ').slice(1).filter(function(x) {
          return x.length > 0;
        })
      };
      return CourseEditor.createCourse(newCourseData).then(function(course) {
        NotifierService.notify('New course created successfully');
        return $location.path("/courses/" + course._id);
      }, NotifierService.error);
    };
  });

}).call(this);

//# sourceMappingURL=NewCourseController.map
