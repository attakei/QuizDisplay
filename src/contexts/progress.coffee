# --------------------------------------
#
# 進行表示Context系パッケージ
#
# --------------------------------------
Player2 = require('../models/players').Player
PlayerState = require('../models/players').PlayerState


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
    Arda.mixin, ProgressController
  ]

  render: ->
    @BootstrapFooter = require('../components/common').BootstrapFooter
    @JudgePanel = JudgePanel
    @ViewControlPanel = ViewControlPanel
    @Player = Player
    require("jade-react!../components/ProgressComponent.jade") @


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
    rule: props.rule

  findAnswerPlayer: ->
    answerPlayers_ = (player for player in @state.players when player.state == PlayerState.Answer)
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
      console.log @state.players
      players_ = @state.players.map (player) ->
        # 解答権を取りに行ける状態でないとステート更新しない
        if player.id == playerId and player.state == PlayerState.Neutral
          player.state = PlayerState.Answer
        return player
      @update (state) =>
        state.players= players_
        return state

    subscribe 'answer-right', ->
      answerPlayer = @findAnswerPlayer()
      answerPlayer.doRight()
      @props.rule.judge(answerPlayer)
      @state.quizCount++;
      @update (state) => state

    subscribe 'answer-wrong', ->
      answerPlayer = @findAnswerPlayer()
      answerPlayer.doWrong()
      @props.rule.judge(answerPlayer)
      @state.quizCount++;
      @update (state) => state

    subscribe 'through-answer', ->
      @state.quizCount++;
      @update (state) => state

    subscribe 'reset-answer', ->
      players_ = @state.players
      for player in players_
        player.state = PlayerState.Neutral
      @update (state) =>
        state.players= players_
        return state
