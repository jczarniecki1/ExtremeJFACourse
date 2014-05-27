angular.module 'app'
  .controller 'ChallengeController', ($scope, ChallengeModel) ->
    $scope.challenges = ChallengeModel.query()