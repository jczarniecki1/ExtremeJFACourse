angular.module 'app'
.factory 'CourseModel', ($resource) ->
  $resource '/api/courses/:id', {_id: "@id"},
    update: { method: 'PUT', isArray: false }
    remove: { method: 'DELETE', isArray: false }
