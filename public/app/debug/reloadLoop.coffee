
# TODO: Pause, Notifications

reloadDelay = 10000

reloadPage = ->
  console.debug '>> reloading...'
  window.location = '/'

tryReloadAfterDelay = (response) ->

  if response?.status is 'error' then console.debug '>> cannot reload the page...'

  unless window.stopReload

    setTimeout ->
      $.ajax
        url: window.location
        success: reloadPage
        error: tryReloadAfterDelay
    , reloadDelay

  else
    setTimeout tryReloadAfterDelay, reloadDelay/2

#tryReloadAfterDelay()