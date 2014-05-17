// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').value('mvToastr', toastr);

  angular.module('app').factory('mvNotifier', function(mvToastr) {
    return {
      notify: function(msg) {
        mvToastr.success(msg);
        return console.log(msg);
      },
      warning: function(msg) {
        mvToastr.warning(msg);
        return console.warn(msg);
      }
    };
  });

}).call(this);

//# sourceMappingURL=mvNotifier.map
