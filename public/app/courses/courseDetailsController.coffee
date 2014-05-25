angular.module 'app'
  .controller 'courseDetailsController', ($scope, mvCachedCourse, $routeParams, mvIdentity) ->
    $scope.identity = mvIdentity
    mvCachedCourse.query().$promise.then (collection) ->
      collection.forEach (course) ->
        if course._id is $routeParams.id
          $scope.course = course
          false