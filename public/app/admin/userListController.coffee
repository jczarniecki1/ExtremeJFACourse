angular.module 'app'
  .controller 'userListController', ($scope, mvUser) ->
    $scope.users = mvUser.query()