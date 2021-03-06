angular.module 'app'
.factory 'UserModel', ($resource) ->
  UserResource = $resource '/api/users/:id', {_id: "@id"},
    update: { method: 'PUT', isArray: false }
    remove: { method: 'DELETE', isArray: false }

  UserResource::isAdmin = ->
    @roles? and 'admin' in @roles

  UserResource::isTester = ->
    @roles? and ('lab' in @roles or @isAdmin())

  UserResource