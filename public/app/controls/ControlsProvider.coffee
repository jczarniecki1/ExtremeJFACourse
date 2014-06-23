angular.module 'app'
.factory 'ControlsProvider', ->
  class ControlsProvider
    constructor: ->
      @controls = [
        {
          id:   'JFA-RegExp'
          name: 'JFA: RegExp Exercise'
          init: ($container, config, onSuccess) ->
            template = $("#regex-template").html()
            $container.regexExercise(template, config, onSuccess)
        },
        {
          id:   'JFA-StateMachine'
          name: 'JFA: State Machine Exercise'
          init: ($container, config, onSuccess, onFail, afterQuiz) ->
            template = $("#automaton-template").html()
            $container.automataExercise(template, config, onSuccess, onFail, afterQuiz)
        }
      ]

    getControls: ->
      @controls.map (x) ->
        { id, name } = x
        { id, name }

    findById: (id) ->
      foundControls = @controls.filter (x) -> x.id is id
      if foundControls.length > 0
        foundControls[0]
      else null

  new ControlsProvider()