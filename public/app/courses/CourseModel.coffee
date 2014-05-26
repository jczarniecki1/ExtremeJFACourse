angular.module 'app'
  .factory 'CourseModel', ($resource) ->
    CourseResource = $resource '/api/courses/:id', {_id: "@id"},
      update:
        method: 'PUT'
        isArray: false

    CourseResource
