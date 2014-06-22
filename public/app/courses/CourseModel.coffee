angular.module 'app'
.factory 'CourseModel', ($resource) ->
  $resource '/api/courses/:id/:action', {_id: "@id"},
    update:      { method: 'PUT', isArray: false, params: {action:'edit'} }
    publish:     { method: 'PUT', isArray: false, params: {action:'publish'} }
    unpublish:   { method: 'PUT', isArray: false, params: {action:'unpublish'}  }
    setReady:    { method: 'PUT', isArray: false, params: {action:'ready'} }
    setNotReady: { method: 'PUT', isArray: false, params: {action:'notready'}  }
    remove:      { method: 'DELETE', isArray: false }
