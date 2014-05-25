angular.module 'app'
  .controller 'challengeController', ($scope, mvChallenge) ->
    $scope.challenges = mvChallenge.query()