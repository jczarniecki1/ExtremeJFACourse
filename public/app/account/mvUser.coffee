angular.module 'app'
  .factory 'mvUser', ($resource) ->
    UserResource = $resource '/api/users/:id',
      _id: "@id"

    UserResource.prototpe.isAdmin = ->
      this.roles && this.role.indexOf('admin') > -1

    UserResource