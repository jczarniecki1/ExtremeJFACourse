angular.module 'app'
.factory 'FeedbackMessage', ($resource) ->
  $resource '/api/feedback'