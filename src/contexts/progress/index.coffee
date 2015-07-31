# --------------------------------------
#
# 進行表示Context系パッケージ
#
# --------------------------------------
CreditContext = require('../credit').CreditContext
{Player, PlayerState} = require('../../models/players')


class @ProgressContext extends Arda.Context
  component:
    require('../../components/progress').ProgressComponent

  initState: (props) ->
    quizCount: 0
    players: (new Player(idx, name) for name, idx in props.playerNames)

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

    subscribe 'start::context:credit', (from) ->
      App.router.pushContext(CreditContext, {})

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

    subscribe 'end-progress', ->
      App.router.popContext()
