ProgressActions =
  _findColumnNode: (e) ->
    elm = e.target
    if elm.getAttribute != 'col-md-1'
      elm = elm.parentNode
    return elm

  tryAnswer: (e) ->
    elm = @_findColumnNode(e)
    console.debug(elm.getAttribute('data-playerid') + ': try answer.')
    @dispatch 'try-answer', parseInt(elm.getAttribute('data-playerid'))

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
  render: ->
    @PlayerState = PlayerState
    require("jade-react!../components/Player.jade") @


JudgePanel = React.createClass
  render: ->
    require("jade-react!../components/JudgePanel.jade") @


ViewControlPanel = React.createClass
  render: ->
    require("jade-react!../components/ViewControlPanel.jade") @


ProgressComponent = React.createClass
  mixins: [
    Arda.mixin, ProgressActions
  ]

  render: ->
    @BootstrapFooter = require('../components/common').BootstrapFooter
    @JudgePanel = JudgePanel
    @ViewControlPanel = ViewControlPanel
    @Player = Player
    require("./template") @
