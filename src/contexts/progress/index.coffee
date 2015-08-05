# --------------------------------------
#
# 進行表示Context系パッケージ
#
# --------------------------------------
{Player, PlayerState} = require('../../models/players')
Decision              = require('../../models/rules').Decision


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

    subscribe 'try::answer', (player) ->
      # 誰か一人でも解答権を持っている場合は、処理を進めない
      if @findAnswerPlayer() != null
        console.log 'already answers'
        return
      if player.state == PlayerState.Neutral
        player.state = PlayerState.Answer
      @update (state) => state

    subscribe 'answer::decide', (decision) ->
      answerPlayer = @findAnswerPlayer()
      @props.rule.decide(answerPlayer, decision)
      @props.rule.judge(answerPlayer)
      @state.quizCount++;
      @update (state) => state

    subscribe 'through-answer', ->
      @state.quizCount++;
      @update (state) => state

    subscribe 'answer::reset', ->
      for player in @state.players
        player.state = PlayerState.Neutral
      @update (state) => state

    subscribe 'end-progress', ->
      App.router.popContext()
