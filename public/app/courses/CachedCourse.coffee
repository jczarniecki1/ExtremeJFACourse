angular.module 'app'
  .factory 'CachedCourse', (CourseModel) ->
    courseList = undefined
    {
      query: -> courseList or= CourseModel.query()
    }