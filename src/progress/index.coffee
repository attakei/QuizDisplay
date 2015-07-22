# --------------------------------------
#
# 進行表示Context系パッケージ
#
# --------------------------------------
Player = require('../models/player').Player


@ProgressController =
  _findColumnNode: (e) ->
    elm = e.target
    if elm.getAttribute != 'col-md-1'
      elm = elm.parentNode
    return elm

  tryAnswer: (e) ->
    elm = @_findColumnNode(e)
    console.debug(elm.getAttribute('data-playerid') + ': try answer.')
    @dispatch 'try-answer', parseInt(elm.getAttribute('data-playerid'))

  resetAnswer: ->
    @dispatch 'reset-answer'


class @ProgressContext extends Arda.Context
  component:
    require('./component')

  initState: (props) ->
    quizCount: 0
    players: (new Player(idx, name) for name, idx in props.playerNames)

  expandComponentProps: (props, state) ->
    programName: props.programName
    players: state.players
    quizCount: state.quizCount

  delegate: (subscribe) ->
    super

    subscribe 'try-answer', (playerId) ->
      # 誰か一人でも解答権を持っている場合は、処理を進めない
      hasAnswer = @state.players.some (val, idc, arr) ->
        return val.isAnswer
      if hasAnswer
        console.debug('already answers')
        return
      players_ = @state.players.map (player) ->
        if player.id == playerId
          player.isAnswer = true
        return player
      console.log players_
      @update (state) =>
        state.players= players_
        return state

    subscribe 'reset-answer', ->
      players_ = @state.players
      for player in players_
        player.isAnswer = false
      @update (state) =>
        state.players= players_
        return state
