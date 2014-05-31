angular.module 'app'
  .value 'mvToastr', toastr

angular.module 'app'
  .factory 'NotifierService', (mvToastr) ->
    {
      notify: (msg) ->
        mvToastr.success msg
        console.log msg

      warning: (msg) ->
        mvToastr.warning msg
        console.warn msg

      error: (error) ->
        message = error?.data?.reason || 'Unknown error'
        mvToastr.error message
        console.error message

      info: (msg) ->
        mvToastr.info msg
        console.log msg

    }