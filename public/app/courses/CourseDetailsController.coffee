angular.module 'app'
.controller 'CourseDetailsController', ($scope, CachedCourse, CachedRating, $routeParams, IdentityService, NotifierService, $location) ->
  $scope.identity = IdentityService
  existingRating = null
  savingRating = null

  $scope.delete = ->
    CachedCourse.remove($routeParams.id).then ->
      NotifierService.notify "Course removed successfully"
      $location.path "/"
    , (error) ->
      NotifierService.error error

  CachedCourse.query().$promise.then (collection) ->
    collection.findById $routeParams.id, (course) ->
      $scope.course = course

  if IdentityService.isAuthenticated()

    args =
      objectId : $routeParams.id
      type : 'course'

    $scope.isReadonly = true

    saveRating = ->
      unless existingRating?
        args.value = $scope.userRate

        CachedRating.create(args)
        .then (rating) ->
          existingRating = rating
      else
        existingRating.value = $scope.userRate

        existingRating.$update()
        .then (rating) ->
          existingRating = rating

    $scope.hoverRating = ->
      clearTimeout savingRating
      $scope.isRatingHovered = true

    $scope.showFeedbackDialog = ->
      console.log "TODO: showFeedbackDialog"

    unless IdentityService.currentUser.isAdmin()
      $scope.leaveRating = ->
        $scope.isRatingHovered = false
        savingRating = setTimeout ->
          unless $scope.isRatingHovered or $scope.userRate is $scope.currentRate
            $scope.userRate = $scope.currentRate
            saveRating()
        , 1000

      afterFetchRating = ->
        $scope.isReadonly = false

      CachedRating.findOne(args).then (rating) ->
        $scope.currentRate = $scope.userRate = rating.value
        existingRating = rating
        afterFetchRating()
      , ->
        $scope.currentRate = $scope.userRate = 0
        afterFetchRating()
