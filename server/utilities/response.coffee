response = require('express').response

response.SendSuccess = (answer) ->
  @status 200
  if answer?
    @send answer
  else
    @end()


response.SendError = (answer, reason = null) ->
  reason =
    unless reason?
      error?.toString()
    else
      if typeof reason is 'function'
        reason error
      else
        reason

  @status 400
  @send {reason}


response.SendIfPossible = (answer, error, reason) ->
  unless error?
    @SendSuccess answer
  else
    @SendError error, reason


response.SendOkIfPossible = (error, reason) ->
  @SendIfPossible null, error, reason