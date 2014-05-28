angular.module 'app'
  .factory 'UserModel', ($resource) ->
    UserResource = $resource '/api/users/:id', {_id: "@id"},
      update:
        method: 'PUT'
        isArray: false

    UserResource::isAdmin = ->
      @roles? and 'admin' in @roles

    UserResource