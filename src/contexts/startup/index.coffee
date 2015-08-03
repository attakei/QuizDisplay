# --------------------------------------
#
# 初期設定Context系パッケージ
#
# --------------------------------------
ProgressContext = require('../progress').ProgressContext
MaruBatsuRule = require('../../models/rules').MaruBatsuRule


# 初期化画面用Context
class @StartupContext extends Arda.Context
  component:
    require('../../components/startup').StartupComponent

  initState: (props) ->
    data =
      cnt: 0
      programName: 'None title'
      maxPlayers: props.maxPlayers or 12
      rule: new MaruBatsuRule(7, 3)
    data.playerNames = ('' for _ in [0...data.maxPlayers])
    data

  expandComponentProps: (props, state) ->
    cnt: state.cnt
    programName: state.programName
    maxPlayers: state.maxPlayers
    playerNames: state.playerNames
    rule: state.rule

  delegate: (subscribe) ->
    super

    subscribe 'submit', (form) ->
      form.rule = @state.rule
      form.playerNames = @state.playerNames
      App.router.pushContext(ProgressContext, form)

    subscribe 'change::rule:param', (param) ->
      @state.rule.toWin = param.toWin
      @state.rule.toLose = param.toLose
      @update (state) => state

    subscribe 'change::players', (param) ->
      @state.playerNames = param
      @update (state) => state
