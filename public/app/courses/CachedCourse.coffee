angular.module 'app'
  .factory 'CachedCourse', (CourseModel, $q) ->
    courseList = undefined

    {
      query: -> courseList or= CourseModel.query()

      remove: (id) ->
        $d = $q.defer()

        courseList.$promise
        .then (collection) ->
          for course in collection
            if course._id is id
              course.$remove({id})
              .then ->
                  collection.remove(course) and $d.resolve()
                , (response) ->
                  $d.reject response.data.reason
              return
          $d.reject "Course not found"

        $d.promise
    }