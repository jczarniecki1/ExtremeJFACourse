// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').factory('CourseModel', function($resource) {
    return $resource('/api/courses/:id/:action', {
      _id: "@id"
    }, {
      start: {
        method: 'PUT',
        isArray: false,
        params: {
          action: 'start'
        }
      },
      update: {
        method: 'PUT',
        isArray: false,
        params: {
          action: 'update'
        }
      },
      publish: {
        method: 'PUT',
        isArray: false,
        params: {
          action: 'publish'
        }
      },
      unpublish: {
        method: 'PUT',
        isArray: false,
        params: {
          action: 'unpublish'
        }
      },
      setReady: {
        method: 'PUT',
        isArray: false,
        params: {
          action: 'ready'
        }
      },
      setNotReady: {
        method: 'PUT',
        isArray: false,
        params: {
          action: 'notready'
        }
      },
      remove: {
        method: 'DELETE',
        isArray: false
      }
    });
  });

}).call(this);

//# sourceMappingURL=CourseModel.map
