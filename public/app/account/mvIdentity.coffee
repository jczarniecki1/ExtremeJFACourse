angular.module 'app'
  .factory 'mvIdentity', ($window, mvUser)->

    currentUser = undefined
    if !!$window.bootstrappedUserObject
      currentUser = new mvUser()
      angular.extend currentUser, $window.bootstrappedUserObject
      
    {
      currentUser: currentUser,
      isAuthenticated: ->
        return !!this.currentUser
    }