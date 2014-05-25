angular.module 'app'
  .factory 'mvChallenge', ($resource) ->
    ChallengeResource = $resource '/api/challenges/:id', {_id: "@id"},
      update:
        method: 'PUT'
        isArray: false

    ChallengeResource
