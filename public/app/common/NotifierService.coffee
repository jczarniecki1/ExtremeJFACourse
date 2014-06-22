angular.module 'app'
.value 'Toastr', toastr

angular.module 'app'
.factory 'NotifierService', (Toastr) ->
  class NotifierService
    notify: (msg) ->
      Toastr.success msg
      console.log msg

    warning: (msg) ->
      Toastr.warning msg
      console.warn msg

    error: (error) ->
      message = error?.data?.reason or error or 'Unknown error'
      Toastr.error message
      console.error message

    info: (msg) ->
      Toastr.info msg
      console.log msg

  new NotifierService()