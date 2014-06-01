angular.module 'app'
  .factory 'CachedCourse', (CourseModel, $q) ->
    courseList = undefined

    {
      query: -> courseList or= CourseModel.query()

      remove: (id) ->
        $d = $q.defer()

        courseList.$promise
        .then (collection) ->
          collection.findById id, (course) ->
            course.$remove({id})
            .then ->
                collection.remove(course) and $d.resolve()
              , (response) ->
                $d.reject response.data.reason
          , -> $d.reject "Course not found"

        $d.promise
    }