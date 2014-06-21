angular.module 'app'
.factory 'CourseModel', ($resource) ->
  $resource '/api/courses/:id/:action', {_id: "@id"},
    update: { method: 'PUT', isArray: false }
    publish: { method: 'PUT', isArray: false, params: {action:'publish'} }
    unpublish: { method: 'PUT', isArray: false, params: {action:'unpublish'}  }
    remove: { method: 'DELETE', isArray: false }
