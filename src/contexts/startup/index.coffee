# --------------------------------------
#
# 初期設定Context系パッケージ
#
# --------------------------------------
ProgressContext = require('../progress').ProgressContext
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
      # rule: new PointsRule(10, -3, 1, -1)
      rule: new MaruBatsuRule()
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

    subscribe 'start::program', (form) ->
      form.rule = @state.rule
      form.playerNames = @state.playerNames
      App.router.pushContext(ProgressContext, form)

    subscribe 'change::rule:param', (param) ->
#      @state.rule.toWin = param.toWin
#      @state.rule.toLose = param.toLose
#      @update (state) => state
      @update (state) =>
        for key, value of param
          state.rule[key] = value
        state

    subscribe 'change::players', (updateData) ->
      @state.playerNames[updateData.dataIndex] = updateData.name
      @update (state) => state
