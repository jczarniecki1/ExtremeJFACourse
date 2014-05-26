angular.module 'app'
  .factory 'IdentityService', ($window, UserModel)->

    currentUser = undefined
    if !!$window.bootstrappedUserObject
      currentUser = new UserModel()
      angular.extend currentUser, $window.bootstrappedUserObject

    {
      currentUser: currentUser

      isAuthenticated: ->
        return !!this.currentUser

      isAuthorized: (role) ->
        this.currentUser && this.currentUser.roles.indexOf 'admin' > -1
    }
