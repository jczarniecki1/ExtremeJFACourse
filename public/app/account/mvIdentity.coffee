angular.module 'app'
.factory 'mvIdentity', ->
  {
    currentUser: undefined,
    isAuthenticated: ->
      return !!this.currentUser
  }