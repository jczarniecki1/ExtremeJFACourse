angular.module 'app'
.controller 'FeedbackModalController', ($scope, $modalInstance, data) ->

  $scope.cancel = -> $modalInstance.dismiss "canceled"

  $scope.save   = -> $modalInstance.close $scope.feedback

  $scope.hitEnter = (evt) ->
    $scope.save()  if angular.equals(evt.keyCode, 13) and not (angular.equals($scope.name, null) or angular.equals($scope.name, ""))