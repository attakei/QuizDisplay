# --------------------------------------
#
# 起動時Context
#
# --------------------------------------


# 初期設定用context
class @StartupContext extends Arda.Context
  component: null
    #pass

  initState: (props) ->
    programName: ''
    maxPlayers: props.maxPlayers or 12

  expandComponentProps: (props, state) ->
    programName: state.programName
    maxPlayers: state.maxPlayers

  delegate: (subscribe) ->
    super
