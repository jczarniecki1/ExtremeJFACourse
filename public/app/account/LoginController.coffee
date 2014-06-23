angular.module 'app'
.controller 'LoginController', ($scope, $http, NotifierService, IdentityService, AuthService, $location, $dialogs, FeedbackMessage, CachedCourse) ->

  $scope.identity = IdentityService

  signinUser = ->
    AuthService.authenticateUser $scope.username, $scope.password
    .then (response) ->
      if response?.success
        CachedCourse.query().$promise.then (collection) ->
          for course in collection
            if $scope.identity.currentUser?.courses.any((x) -> x.id is course._id)
              course.started = true

        NotifierService.notify 'You have successfully signed in!'
      else
        if response?.reason
          NotifierService.warning "Failed to log in. Wrong #{response.reason}"
        else
          NotifierService.error 'Cannot log in. Request not accepted'

  $scope.signin = () ->
    unless $scope.username? or $scope.password?
      $('[ng-model="username"]').trigger 'change'
      $('[ng-model="password"]').trigger 'change'
      setTimeout signinUser, 100
    else
      signinUser()

  userActions = $('#userActions')
  userActions.find('.dropdown-toggle').click -> userActions.toggleClass 'open'

  $scope.signout = ->
    AuthService.logoutUser()
    .then ->
      $scope.username = ""
      $scope.password = ""
      NotifierService.info 'You have succeessfully signed out'
      $location.path '/'

  $scope.openFeedbackModal = ->
    $dialogs.create '/partials/bootstrap/modal/feedbackModal', 'FeedbackModalController', {}, {key: false, back: 'static'}
    .result.then (feedback) ->
      messageData =
        url: $location.url()
        location: "Feedback used from menu"
        text: feedback

      newFeedback = new FeedbackMessage(messageData)
      newFeedback.$save()
      .then ->
        NotifierService.notify "Message submitted successfully"
      , NotifierService.error
