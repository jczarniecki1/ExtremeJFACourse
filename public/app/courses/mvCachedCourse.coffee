angular.module 'app'
  .factory 'mvCachedCourse', (mvCourse) ->
    courseList = undefined
    {
      query: ->
        courseList || (courseList = mvCourse.query())
    }