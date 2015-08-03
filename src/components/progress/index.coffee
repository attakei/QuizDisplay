PlayerState = require('../../models/players').PlayerState


ProgressActions =
  _findColumnNode: (e) ->
    elm = e.target
    if elm.getAttribute != 'col-md-1'
      elm = elm.parentNode
    return elm

  answerRight: ->
    console.debug '正解'
    @dispatch 'answer-right'

  answerWrong: ->
    console.debug '誤答'
    @dispatch 'answer-wrong'

  throughAnswer: ->
    @dispatch 'through-answer'

  resetAnswer: ->
    @dispatch 'reset-answer'

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
    @BootstrapFooter = require('../common').BootstrapFooter
    @JudgePanel = JudgePanel
    @ViewControlPanel = ViewControlPanel
    @Player = Player
    require("./template") @
