// Generated by CoffeeScript 1.7.1
(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  angular.module('app').factory('UserModel', function($resource) {
    var UserResource;
    UserResource = $resource('/api/users/:id', {
      _id: "@id"
    }, {
      update: {
        method: 'PUT',
        isArray: false
      },
      remove: {
        method: 'DELETE',
        isArray: false
      }
    });
    UserResource.prototype.isAdmin = function() {
      return (this.roles != null) && __indexOf.call(this.roles, 'admin') >= 0;
    };
    return UserResource;
  });

}).call(this);

//# sourceMappingURL=UserModel.map
