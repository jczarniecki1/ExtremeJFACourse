angular.module 'app'
  .factory 'ChallengeModel', ($resource) ->
    ChallengeResource = $resource '/api/courses/:courseId/challenges/:id', {courseId:"@courseId", _id: "@id"},
      update:
        method: 'PUT'
        isArray: false

    ChallengeResource
