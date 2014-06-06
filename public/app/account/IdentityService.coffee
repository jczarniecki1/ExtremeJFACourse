angular.module 'app'
.factory 'IdentityService', ($window, UserModel) ->

  currentUser = undefined
  if $window.bootstrappedUserObject?
    currentUser = new UserModel()
    angular.extend currentUser, $window.bootstrappedUserObject

  class IdentityService
    currentUser: currentUser

    isAuthenticated: ->
      @currentUser?

    isAuthorized: (role) ->
      @currentUser? and role in @currentUser?.roles

  new IdentityService()
