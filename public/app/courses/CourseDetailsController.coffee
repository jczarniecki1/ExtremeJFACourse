angular.module 'app'
.controller 'CourseDetailsController', ($scope, CachedCourse, CachedRating, $routeParams, IdentityService, NotifierService, $location, $dialogs, FeedbackMessage) ->
  $scope.identity = IdentityService
  existingRating = null
  savingRating = null
  courseId = $routeParams.id

  $scope.start = ->
    $scope.course.$start({id:courseId})
    .then (startDate) ->
      user = $scope.identity.currentUser
      user.courses.push {id: courseId, startDate }
      $scope.course.started = true
      NotifierService.notify "Course was started"
    , NotifierService.error

  $scope.publish = ->
    $dialogs.confirm 'Confirm', 'Are you sure you want to publish this course?'
    .result.then ->
      $scope.course.$publish({id:courseId})
      .then ->
        $scope.course.published = true
        NotifierService.notify "Course was published"
      , NotifierService.error

  $scope.unpublish = ->
    $scope.course.$unpublish({id:courseId})
    .then ->
      $scope.course.published = false
      NotifierService.info "Course was unpublished"
    , NotifierService.error

  $scope.readyToTest = (enabled) ->
    $scope.course.$setNotReady({id:courseId})
    .then ->
      $scope.course.readyToTest = enabled
      NotifierService.info "Course 'Ready' flag is #{if enabled then 'set' else 'unset'}"
    , NotifierService.error

  $scope.edit = ->
    $location.path "/courses/edit/#{courseId}"

  $scope.delete = ->
    $dialogs.danger 'Confirm', 'Are you sure you want to remove this course entirely?'
    .result.then ->
      CachedCourse.remove courseId
      .then ->
        NotifierService.notify "Course removed successfully"
        $location.path "/"
      , NotifierService.error

  $scope.openFeedbackModal = ->
    $dialogs.create '/partials/bootstrap/modal/feedbackModal', 'FeedbackModalController', {}, {key: false, back: 'static'}
    .result.then (feedback) ->
      messageData =
        url: $location.url()
        location: "Course: #{$scope.course.title}"
        text: feedback

      newFeedback = new FeedbackMessage(messageData)
      newFeedback.$save()
      .then ->
        NotifierService.notify "Message submitted successfully"
      , NotifierService.error

  CachedCourse.query().$promise
  .then (collection) ->
    collection.findById courseId, (course) ->
      $scope.course = course

      if IdentityService.isAuthenticated()

        if $scope.identity.currentUser?.courses.any((x) -> x.id is courseId)
          course.started = true

        ratingArgs =
          url: $location.url()
          location: "Course: #{$scope.course.title}"
          objectId : courseId
          type : 'course'

        $scope.isReadonly = true

        saveRating = ->
          unless existingRating?
            ratingArgs.value = $scope.userRate

            CachedRating.create ratingArgs
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

        $scope.leaveRating = ->
          unless IdentityService.currentUser.isAdmin()
            $scope.isRatingHovered = false
            savingRating = setTimeout ->
              unless $scope.isRatingHovered or $scope.userRate is $scope.currentRate
                $scope.userRate = $scope.currentRate
                saveRating()
            , 1000

        afterFetchRating = ->
          $scope.isReadonly = false


        CachedRating.findOne ratingArgs
        .then (rating) ->
          $scope.currentRate = $scope.userRate = rating.value
          existingRating = rating
          afterFetchRating()
        , ->
          $scope.currentRate = $scope.userRate = 0
          afterFetchRating()
