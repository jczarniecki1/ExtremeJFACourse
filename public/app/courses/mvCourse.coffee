angular.module 'app'
  .factory 'mvCourse', ($resource) ->
    CourseResource = $resource '/api/courses/:id', {_id: "@id"},
      update:
        method: 'PUT'
        isArray: false

    CourseResource
