# --------------------------------------
#
# 初期設定Context系パッケージ
#
# --------------------------------------
ProgressContext = require('../progress').ProgressContext


# 初期化画面用Context
class @StartupContext extends Arda.Context
  component:
    require('../../components/startup').StartupComponent
  initState: (props) ->
    cnt: 0
    programName: 'None title'
    maxPlayers: props.maxPlayers or 12
  expandComponentProps: (props, state) ->
    cnt: state.cnt
    programName: state.programName
    maxPlayers: state.maxPlayers
  delegate: (subscribe) ->
    super

    subscribe 'submit', (form) ->
      App.router.pushContext(ProgressContext, form)
