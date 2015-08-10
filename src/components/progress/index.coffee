PlayerState = require('../../models/players').PlayerState
Judge       = require('../../models/rules').Judge


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
    @dispatch 'answer::decide', Judge.Right

  answerWrong: ->
    @dispatch 'answer::decide', Judge.Wrong

  throughAnswer: ->
    @dispatch 'answer::through'

  resetAnswer: ->
    @dispatch 'answer::reset'

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
