angular.module 'app'
.factory 'AuthService', ($http, IdentityService, UserModel, $q) ->

  class AuthService

    authenticateUser: (username, password) ->
      $d = $q.defer()
      $http.post '/login', {username, password}
      .then (response) ->
        if response.data?.success
          user = new UserModel()
          angular.extend user, response.data.user
          IdentityService.currentUser = user
          $d.resolve true
        else
          $d.resolve false
      , -> $d.resolve false

      $d.promise

    logoutUser: ->
      $d = $q.defer()
      $http.post '/logout', {logout: true}
      .then () ->
        IdentityService.currentUser = undefined
        $d.resolve()

      $d.promise

    authorizeCurrentUserForRoute: (role) ->
      if IdentityService.isAuthorized role
        true
      else
        $q.reject 'not authorized'

    authorizeAuthenticatedUserForRoute: ->
      if IdentityService.isAuthenticated()
        true
      else
        $q.reject 'not authorized'

    createUser: (newUserData) ->
      newUser = new UserModel newUserData
      $d = $q.defer()

      newUser.$save()
      .then ->
        IdentityService.currentUser = newUser
        $d.resolve()
      , (error) ->
        $d.reject error

      $d.promise

    updateCurrentUser: (updatedUserData) ->
      $d = $q.defer()

      clone = angular.copy IdentityService.currentUser
      angular.extend clone, updatedUserData
      clone.$update()
      .then ->
        IdentityService.currentUser = clone
        $d.resolve()
      , (error) -> $d.reject error

      $d.promise

  new AuthService()