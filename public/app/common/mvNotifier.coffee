angular.module 'app'
.value 'mvToastr', toastr

angular.module 'app'
.factory 'mvNotifier', (mvToastr) ->
  {
    notify: (msg) ->
      mvToastr.success msg
      console.log msg
  }