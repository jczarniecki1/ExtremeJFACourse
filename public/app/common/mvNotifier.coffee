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
        theMsg = msg || 'Unknown error'
        mvToastr.error theMsg
        console.error theMsg

      info: (msg) ->
        mvToastr.info msg
        console.log msg

    }