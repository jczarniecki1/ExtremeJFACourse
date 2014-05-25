angular.module 'app'
  .factory 'mvCachedCourse', (mvCourse) ->
    courseList = undefined
    {
      query: ->
        courseList or= mvCourse.query()
    }