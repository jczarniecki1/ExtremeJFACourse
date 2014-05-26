angular.module 'app'
  .factory 'ChallengeModel', ($resource) ->
    ChallengeResource = $resource '/api/challenges/:id', {_id: "@id"},
      update:
        method: 'PUT'
        isArray: false

    ChallengeResource
