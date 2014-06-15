angular.module 'app'
.factory 'CachedCourse', (CourseModel, $q) ->

  courseList = undefined

  class CachedCourse
    query: -> courseList or= CourseModel.query()

    findById: (id, callback, onError) ->
      @query().$promise.then (collection) ->
        collection.findById id, callback, onError

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

  new CachedCourse()