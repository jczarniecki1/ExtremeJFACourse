// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').factory('CourseModel', function($resource) {
    return $resource('/api/courses/:id', {
      _id: "@id"
    }, {
      update: {
        method: 'PUT',
        isArray: false
      },
      remove: {
        method: 'DELETE',
        isArray: false
      }
    });
  });

}).call(this);

//# sourceMappingURL=CourseModel.map
