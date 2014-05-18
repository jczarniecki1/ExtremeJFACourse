angular.module 'app'
  .value 'mvToastr', toastr

angular.module 'app'
  .factory 'mvNotifier', (mvToastr) ->
    {
      notify: (msg) ->
        mvToastr.success msg
        console.log msg

      warning: (msg) ->
        mvToastr.warning msg
        console.warn msg

      error: (msg) ->
        mvToastr.error msg
        console.error msg

      info: (msg) ->
        mvToastr.info msg
        console.log msg

    }