angular.module 'app'
.factory 'ChallengeModel', ($resource) ->
  $resource '/api/courses/:courseId/challenges/:id', {courseId:"@courseId", _id: "@id"},
    update: { method: 'PUT', isArray: false }
    remove: { method: 'DELETE', isArray: false }
