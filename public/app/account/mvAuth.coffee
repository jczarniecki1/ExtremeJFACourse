angular.module 'app'
  .factory 'mvAuth', ($http, mvIdentity, mvUser, $q) ->
    {
      authenticateUser: (username, password)->
        deferred = $q.defer()
        $http.post '/login',
          username: username
          password: password
        .then (response) ->
          if response.data.success
            user = new mvUser()
            angular.extend user, response.data.user
            mvIdentity.currentUser = user
            deferred.resolve true
          else
            deferred.resolve false

        deferred.promise

      logoutUser: ->
        deferred = $q.defer()
        $http.post '/logout',
          logout: true
        .then () ->
          mvIdentity.currentUser = undefined
          deferred.resolve()

        deferred.promise

      authorizeCurrentUserForRoute: (role) ->
        if mvIdentity.isAuthorized role
          true
        else
          $q.reject 'not authorized'

      authorizeAuthenticatedUserForRoute: ->
        if mvIdentity.isAuthenticated()
          true
        else
          $q.reject 'not authorized'

      createUser: (newUserData) ->
        newUser = new mvUser newUserData
        deferred = $q.defer()

        newUser.$save()
          .then ->
            mvIdentity.currentUser = newUser
            deferred.resolve()
          , (response) ->
            deferred.reject response.data.reason

        deferred.promise

      updateCurrentUser: (updatedUserData) ->
        deferred = $q.defer()

        clone = angular.copy mvIdentity.currentUser
        angular.extend clone, updatedUserData
        clone.$update()
          .then ->
            mvIdentity.currentUser = clone
            deferred.resolve()
          , (response) ->
             deferred.reject response.data.reason

        deferred.promise
    }