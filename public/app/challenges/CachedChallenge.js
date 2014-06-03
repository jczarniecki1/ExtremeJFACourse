// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').factory('CachedChallenge', function(ChallengeModel) {
    var CachedChallenge, challengeList;
    challengeList = {};
    CachedChallenge = (function() {
      function CachedChallenge() {}

      CachedChallenge.prototype.query = function(args) {
        var _name;
        if ((args != null ? args.courseId : void 0) != null) {
          args = {
            courseId: args.courseId
          };
          return challengeList[_name = args.courseId] != null ? challengeList[_name] : challengeList[_name] = ChallengeModel.query(args);
        } else {
          return challengeList['all'] != null ? challengeList['all'] : challengeList['all'] = ChallengeModel.query();
        }
      };

      return CachedChallenge;

    })();
    return new CachedChallenge();
  });

}).call(this);

//# sourceMappingURL=CachedChallenge.map
