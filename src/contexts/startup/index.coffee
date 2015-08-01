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
    cnt: 0
    programName: 'None title'
    maxPlayers: props.maxPlayers or 12
    rule: new MaruBatsuRule(7, 3)

  expandComponentProps: (props, state) ->
    cnt: state.cnt
    programName: state.programName
    maxPlayers: state.maxPlayers
    rule: state.rule

  delegate: (subscribe) ->
    super

    subscribe 'submit', (form) ->
      form.rule = @state.rule
      App.router.pushContext(ProgressContext, form)

    subscribe 'change::rule:param', (param) ->
      @state.rule.rightsForWin = param.toWin
      @state.rule.wrongsForLose = param.toLose
      @update (state) => state
