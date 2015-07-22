# --------------------------------------
#
# 進行表示Context系パッケージ
#
# --------------------------------------
Player2 = require('../models/player').Player


JudgePanel_jade = require("jade-react!./JudgePanel.jade")
JudgePanel = React.createClass
   render: ->
      require("jade-react!./JudgePanel.jade") @


ViewControlPanel_jade = require("jade-react!./ViewControlPanel.jade")
ViewControlPanel = React.createClass
   render: ->
      require("jade-react!./ViewControlPanel.jade") @


ProgressController =
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


ProgressComponent_jade = require("jade-react!./ProgressComponent.jade")
ProgressComponent = React.createClass
   mixins: [Arda.mixin, ProgressController]
   render: ->
      @JudgePanel = JudgePanel
      @ViewControlPanel = ViewControlPanel
      ProgressComponent_jade @
      # ({self: this, props: this.props, state: this.state, JudgePanel: JudgePanel})



class @ProgressContext extends Arda.Context
  component: ProgressComponent
    # require('./component')

  initState: (props) ->
    quizCount: 0
    players: (new Player2(idx, name) for name, idx in props.playerNames)

  expandComponentProps: (props, state) ->
    programName: props.programName
    players: state.players
    quizCount: state.quizCount

  findAnswerPlayer: ->
    answerPlayers_ = (player for player in @state.players when player.isAnswer)
    if answerPlayers_.length != 1
      return null
    return answerPlayers_[0]

  delegate: (subscribe) ->
    super

    subscribe 'try-answer', (playerId) ->
      # 誰か一人でも解答権を持っている場合は、処理を進めない
      if @findAnswerPlayer() != null
        console.debug('already answers')
        return
      players_ = @state.players.map (player) ->
        if player.id == playerId
          player.isAnswer = true
        return player
      @update (state) =>
        state.players= players_
        return state

    subscribe 'answer-right', ->
      answerPlayer = @findAnswerPlayer()
      answerPlayer.isAnswer = false
      answerPlayer.doRight()
      @state.quizCount++;
      @update (state) => state

    subscribe 'answer-wrong', ->
      answerPlayer = @findAnswerPlayer()
      answerPlayer.isAnswer = false
      answerPlayer.doWrong()
      @state.quizCount++;
      @update (state) => state

    subscribe 'through-answer', ->
      @state.quizCount++;
      @update (state) => state

    subscribe 'reset-answer', ->
      players_ = @state.players
      for player in players_
        player.isAnswer = false
      @update (state) =>
        state.players= players_
        return state
