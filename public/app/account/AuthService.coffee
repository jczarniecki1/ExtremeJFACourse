angular.module 'app'
  .factory 'AuthService', ($http, IdentityService, UserModel, $q) ->
    {
      authenticateUser: (username, password)->
        deferred = $q.defer()
        $http.post '/login',
          username: username
          password: password
        .then (response) ->
          if response.data.success
            user = new UserModel()
            angular.extend user, response.data.user
            IdentityService.currentUser = user
            deferred.resolve true
          else
            deferred.resolve false

        deferred.promise

      logoutUser: ->
        deferred = $q.defer()
        $http.post '/logout',
          logout: true
        .then () ->
          IdentityService.currentUser = undefined
          deferred.resolve()

        deferred.promise

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
        deferred = $q.defer()

        newUser.$save()
          .then ->
            IdentityService.currentUser = newUser
            deferred.resolve()
          , (error) ->
            deferred.reject error

        deferred.promise

      updateCurrentUser: (updatedUserData) ->
        deferred = $q.defer()

        clone = angular.copy IdentityService.currentUser
        angular.extend clone, updatedUserData
        clone.$update()
          .then ->
            IdentityService.currentUser = clone
            deferred.resolve()
          , (error) ->
             deferred.reject error

        deferred.promise
    }