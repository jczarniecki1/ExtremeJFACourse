
FeedbackModalController = ($scope, $modalInstance, items) ->
  $scope.items = items
  $scope.selected = item: $scope.items[0]
  $scope.ok = ->
    $modalInstance.close $scope.selected.item

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"

angular.module 'app'
.controller 'CourseDetailsController', ($scope, CachedCourse, CachedRating, $routeParams, IdentityService, NotifierService, $location, $modal, $log) ->
  $scope.identity = IdentityService
  existingRating = null
  savingRating = null

  $scope.items = ['item1', 'item2', 'item3']

  $scope.openFeedbackModal = (size) ->
    modalInstance = $modal.open
      templateUrl: "/partials/bootstrap/modal/feedbackModal"
      controller: FeedbackModalController
      size: size
      resolve:
        items: ->
          $scope.items

    modalInstance.result
    .then (selectedItem) ->
      $scope.selected = selectedItem
    , ->
      $log.info "Modal dismissed at: " + new Date()


  $scope.delete = ->
    CachedCourse.remove $routeParams.id
    .then ->
      NotifierService.notify "Course removed successfully"
      $location.path "/"
    , (error) ->
      NotifierService.error error

  CachedCourse.query().$promise
  .then (collection) ->
    collection.findById $routeParams.id, (course) ->
      $scope.course = course

  if IdentityService.isAuthenticated()

    ratingArgs =
      objectId : $routeParams.id
      type : 'course'

    $scope.isReadonly = true

    saveRating = ->
      unless existingRating?
        ratingArgs.value = $scope.userRate

        CachedRating.create(ratingArgs)
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
