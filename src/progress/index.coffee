# --------------------------------------
#
# 進行表示Context系パッケージ
#
# --------------------------------------


@ProgressController =
  _findColumnNode: (e) ->
    elm = e.target
    if elm.getAttribute != 'col-md-1'
      elm = elm.parentNode
    return elm

  tryAnswer: (e) ->
    elm = @_findColumnNode(e)
    console.debug(elm.getAttribute('data-playerid') + ': try answer.')
    @dispatch 'try-answer', elm.getAttribute('data-playerid')


class Player
  constructor: (name) ->
    @name = name
    @isAnswer = false


class @ProgressContext extends Arda.Context
  component:
    require('./component')

  initState: (props) ->
    quizCount: 0
    players: (new Player(name) for name in props.playerNames)

  expandComponentProps: (props, state) ->
    programName: props.programName
    players: state.players
    quizCount: state.quizCount

  delegate: (subscribe) ->
    super

    subscribe 'try-answer', (playerId) ->
      hasAnswer = @state.players.some (val, idc, arr) ->
        return val.isAnswer
      if hasAnswer
        console.debug('already answers')
      @state.players[playerId].isAnswer = true

