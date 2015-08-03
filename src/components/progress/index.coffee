PlayerState = require('../../models/players').PlayerState
Decision    = require('../../models/rules').Decision


ProgressActions =
  _findColumnNode: (e) ->
    elm = e.target
    if elm.getAttribute != 'col-md-1'
      elm = elm.parentNode
    return elm

  endProgress: ->
    @dispatch 'end-progress'


Player = React.createClass
  mixins: [
    Arda.mixin
  ]

  tryAnswer: (e)->
    @dispatch 'try::answer', @props.player

  render: ->
    @PlayerState = PlayerState
    require("./Player") @


JudgePanel = React.createClass
  mixins: [
    Arda.mixin
  ]

  answerRight: ->
    @dispatch 'answer::decide', Decision.Right

  answerWrong: ->
    @dispatch 'answer::decide', Decision.Wrong

  throughAnswer: ->
    @dispatch 'through-answer'

  resetAnswer: ->
    @dispatch 'reset-answer'

  render: ->
    require("./JudgePanel") @


ViewControlPanel = React.createClass
  render: ->
    require("./ViewControlPanel") @


@ProgressComponent = React.createClass
  mixins: [
    Arda.mixin, ProgressActions
  ]

  render: ->
    @JudgePanel = JudgePanel
    @ViewControlPanel = ViewControlPanel
    @Player = Player
    require("./template") @
