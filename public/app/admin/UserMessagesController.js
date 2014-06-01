// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').controller('UserMessagesController', function($scope, $routeParams, UserModel, CachedMessage, NotifierService) {
    var userId;
    userId = $routeParams.userId;
    UserModel.query().$promise.then(function(collection) {
      var user, _i, _len;
      for (_i = 0, _len = collection.length; _i < _len; _i++) {
        user = collection[_i];
        if (user._id === userId) {
          return $scope.user = user;
        }
      }
    });
    $scope.messages = CachedMessage.query({
      userId: userId
    });
    $scope.answer = function(id) {
      return $scope.messages.$promise.then(function(collection) {
        var answer, message, _i, _len;
        for (_i = 0, _len = collection.length; _i < _len; _i++) {
          message = collection[_i];
          if (message._id === id) {
            answer = $scope.body.answer;
            message.$answer({
              id: id,
              answer: answer
            }).then(function() {
              return NotifierService.success("Answer send successfully");
            }, function(error) {
              return NotifierService.error(error);
            });
          }
          return;
        }
        return NotifierService.error("Message not found");
      });
    };
    return $scope["delete"] = function(id) {
      return CachedMessage.remove(id);

      /*.$promise.then (collection) ->
        for message in collection
          if message._id is id
            message.remove({id}).then ->
              NotifierService.info "Message removed successfully"
            , (error) ->
              NotifierService.error error
          return
      
        NotifierService.error "Message not found"
       */
    };
  });

}).call(this);

//# sourceMappingURL=UserMessagesController.map
