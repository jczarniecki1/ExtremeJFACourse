angular.module 'app'
  .factory 'mvCourseEditor', (mvCourse, $q) ->
    {
      createCourse: (newCourseData) ->
        newCourse = new mvCourse newCourseData
        deferred = $q.defer()

        newCourse.$save()
        .then (course) ->
          deferred.resolve course
        , (response) ->
          deferred.reject response.data.reason

        deferred.promise
    }