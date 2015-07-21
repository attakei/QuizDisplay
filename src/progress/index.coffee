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



class @ProgressContext extends Arda.Context
  component:
    require('./component')
  initState: (props) ->
    quizCount: 0
  expandComponentProps: (props, state) ->
    programName: props.programName
    playerNames: props.players
    quizCount: state.quizCount
