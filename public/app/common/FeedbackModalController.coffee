angular.module 'app'
.controller 'FeedbackModalController', ($scope, $modalInstance, data) ->

  $scope.cancel = -> $modalInstance.dismiss "canceled"

  $scope.send   = -> $modalInstance.close $scope.feedback