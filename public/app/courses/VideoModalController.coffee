angular.module 'app'
.controller 'VideoModalController', ($scope, $modalInstance, data) ->

  $scope.cancel = -> $modalInstance.dismiss "canceled"
