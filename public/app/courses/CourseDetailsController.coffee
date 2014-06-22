angular.module 'app'
.controller 'CourseDetailsController', ($scope, CachedCourse, CachedRating, $routeParams, IdentityService, NotifierService, $location, $dialogs, FeedbackMessage) ->
  $scope.identity = IdentityService
  existingRating = null
  savingRating = null

  $scope.open = (challengeId) ->
    $location.path "/courses/#{$routeParams.id}/challenge/#{challengeId}"

  #if IdentityService.currentUser?.isAdmin()

  $scope.publish = ->
    $dialogs.confirm 'Confirm', 'Are you sure you want to publish this course?'
    .result.then ->
      $scope.course.$publish({id:$routeParams.id})
      .then ->
        $scope.course.published = true
        NotifierService.notify "Course was published"
      , NotifierService.error

  $scope.unpublish = ->
    $scope.course.$unpublish({id:$routeParams.id})
    .then ->
      $scope.course.published = false
      NotifierService.info "Course was unpublished"
    , NotifierService.error

  $scope.setReadyForTest = ->
    $scope.course.$setReady({id:$routeParams.id})
    .then ->
      $scope.course.readyToTest = true
      NotifierService.notify "Course 'Ready' flag is set"
    , NotifierService.error

  $scope.unsetReadyForTest = ->
    $scope.course.$setNotReady({id:$routeParams.id})
    .then ->
      $scope.course.readyToTest = false
      NotifierService.info "Course 'Ready' flag is unset"
    , NotifierService.error

  $scope.edit = ->
    $location.path "/courses/edit/#{$routeParams.id}"

  $scope.editChallenge = (id) ->
    $location.path "/courses/#{$routeParams.id}/challenge/edit/#{id}"

  $scope.delete = ->
    $dialogs.danger 'Confirm', 'Are you sure you want to remove this course entirely?'
    .result.then ->
      CachedCourse.remove $routeParams.id
      .then ->
        NotifierService.notify "Course removed successfully"
        $location.path "/"
      , NotifierService.error

  CachedCourse.query().$promise
  .then (collection) ->
    collection.findById $routeParams.id, (course) ->
      $scope.course = course

      if IdentityService.isAuthenticated()

        ratingArgs =
          url: $location.url()
          location: "Course: #{$scope.course.title}"
          objectId : $routeParams.id
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


        CachedRating.findOne ratingArgs
        .then (rating) ->
          $scope.currentRate = $scope.userRate = rating.value
          existingRating = rating
          afterFetchRating()
        , ->
          $scope.currentRate = $scope.userRate = 0
          afterFetchRating()
