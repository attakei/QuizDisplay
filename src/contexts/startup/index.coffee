# --------------------------------------
#
# 初期設定Context系パッケージ
#
# --------------------------------------
ProgressContext = require('../progress').ProgressContext
MaruBatsuRule = require('../_rules').MaruBatsuRule


# 初期化画面用Context
class @StartupContext extends Arda.Context
  component:
    require('../../components/startup').StartupComponent

  initState: (props) ->
    rule_ = new MaruBatsuRule
    rule_.props = {toWin: 7, toLose: 3}
    cnt: 0
    programName: 'None title'
    maxPlayers: props.maxPlayers or 12
    rule:  rule_

  expandComponentProps: (props, state) ->
    cnt: state.cnt
    programName: state.programName
    maxPlayers: state.maxPlayers
    rule: state.rule

  delegate: (subscribe) ->
    super

    subscribe 'submit', (form) ->
      App.router.pushContext(ProgressContext, form)
