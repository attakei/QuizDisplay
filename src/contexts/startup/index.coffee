# --------------------------------------
#
# 初期設定Context系パッケージ
#
# --------------------------------------
ProgressContext = require('../progress').ProgressContext
CreditContext = require('../credit').CreditContext
{MaruBatsuRule, PointsRule} = require('../../models/rules')


# 初期化画面用Context
class @StartupContext extends Arda.Context
  component:
    require('../../components/startup').StartupComponent

  initState: (props) ->
    data =
      cnt: 0
      programName: 'None title'
      maxPlayers: props.maxPlayers or 12
    data.playerNames = ('' for _ in [0...data.maxPlayers])
    data.rules = [
      new MaruBatsuRule(7, 3)
      , new PointsRule(10, -3, 1, -1)
    ]
    data.currentRule = data.rules[0]
    data

  expandComponentProps: (props, state) ->
    cnt: state.cnt
    programName: state.programName
    maxPlayers: state.maxPlayers
    playerNames: state.playerNames
    rules: state.rules
    currentRule: state.currentRule

  delegate: (subscribe) ->
    super

    subscribe 'start::program', (form) ->
      form.rule = @state.currentRule
      form.playerNames = @state.playerNames
      App.router.pushContext(ProgressContext, form)

    subscribe 'start::context:credit', (from) ->
      App.router.pushContext(CreditContext, {})

    subscribe 'change::rule', (index) ->
      @update (state) =>
        state.currentRule = state.rules[index]
        state

    subscribe 'change::rule:param', (param) ->
#      @state.rule.toWin = param.toWin
#      @state.rule.toLose = param.toLose
#      @update (state) => state
      @update (state) =>
        for key, value of param
          state.currentRule[key] = value
        state

    subscribe 'change::players', (updateData) ->
      @state.playerNames[updateData.dataIndex] = updateData.name
      @update (state) => state
