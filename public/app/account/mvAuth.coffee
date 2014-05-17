angular.module 'app'
  .factory 'mvAuth', ($http, mvIdentity, $q) ->
    {
      authenticateUser: (username, password)->
        deferred = $q.defer()
        $http.post '/login',
          username: username
          password: password
        .then (response) ->
          if response.data.success
            mvIdentity.currentUser = response.data.user
            deferred.resolve true
          else
            deferred.resolve false

        deferred.promise
    }