// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').config(function($provide) {
    $provide.decorator('ratingDirective', function($delegate) {
      $delegate[0].templateUrl = '/partials/bootstrap/rating/rating';
      return $delegate;
    });
    $provide.decorator('modalBackdropDirective', function($delegate) {
      $delegate[0].templateUrl = '/partials/bootstrap/modal/backdrop';
      return $delegate;
    });
    $provide.decorator('modalWindowDirective', function($delegate) {
      $delegate[0].templateUrl = '/partials/bootstrap/modal/window';
      return $delegate;
    });
    return $provide.decorator('popoverPopupDirective', function($delegate) {
      $delegate[0].templateUrl = '/partials/bootstrap/popover/popover';
      return $delegate;
    });
  });

}).call(this);

//# sourceMappingURL=bootstrap-decorators.map
