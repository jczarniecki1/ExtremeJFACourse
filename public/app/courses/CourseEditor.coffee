angular.module 'app'
.factory 'CourseEditor', (CourseModel, $q) ->
  class CourseEditor
    createCourse: (newCourseData) ->
      newCourse = new CourseModel newCourseData
      deferred = $q.defer()

      newCourse.$save()
      .then (course) ->
        deferred.resolve course
      , (error) ->
        deferred.reject error

      deferred.promise

  new CourseEditor()