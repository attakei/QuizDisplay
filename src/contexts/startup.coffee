# --------------------------------------
#
# 起動時Context
#
# --------------------------------------


# StartupComponentのロジック(view->context)部分
@StartupController = StartupController =
  getInitialState: ->
    state_ = {}
    state_.programName = @props.programName
    state_.playerNames = []
    for id in [0...@props.maxPlayers]
      state_['playerName-'+id] = ''
    return state_

  handleSubmit: ->
    programParam = {}
    programParam.name = @linkState('programName').value
    programParam.playerNames = (@linkState('playerName-' + i).value or '' for i in [0...@props.maxPlayers])
    # TODO: 仮に7◯3✕をセットする
    programParam.rule = 'NanaSan'
    programParam.ruleParam = {toWin: 7, toLose: 3}
    console.log programParam
    @dispatch('start:program', programParam)


StartupComponent = React.createClass
  mixins: [
    Arda.mixin
    React.addons.LinkedStateMixin
    StartupController
  ]

  render: ->
    @BootstrapFooter = require('../components/common').BoostrapFooter
    require("jade-react!./startup.jade") @


# 初期設定用context
class @StartupContext extends Arda.Context
  component:
    StartupComponent

  initState: (props) ->
    programName: ''
#    maxPlayers: props.maxPlayers or 12
    maxPlayers: props.maxPlayers or 8

  expandComponentProps: (props, state) ->
    programName: state.programName
    maxPlayers: state.maxPlayers

  delegate: (subscribe) ->
    super

    subscribe 'start:program', (params) ->
      MaruBatsuRule = require('../models/rules').MaruBatsuRule
      ProgressContext = require('./progress').ProgressContext
      params.rule = new MaruBatsuRule(params.ruleParam.toWin, params.ruleParam.toLose)
      App.router.pushContext(ProgressContext, params)
