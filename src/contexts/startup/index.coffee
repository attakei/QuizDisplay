# --------------------------------------
#
# 初期設定Context系パッケージ
#
# --------------------------------------
ProgressContext = require('../progress').ProgressContext


# InitComponent用mixn
InitController =
  getInitialState: ->
    {}

  handleSubmit: ->
    formData = {}
    # TODO: beta2以降で随時戻すことを検討する
    # formData.programName = @linkState('programName').value
    formData.programName = '7○3✕'
    formData.playerNames = []
    for i in [0..@props.maxPlayers]
      val_ = @linkState('player[' + i + ']').value
      val_ = '' if typeof val_ == "undefined"
      formData.playerNames.push(val_)
    # TODO: 仮に7◯3✕をセットする
    MaruBatsuRule = require('../../models/rules').MaruBatsuRule
    formData.rule = new MaruBatsuRule(7, 3)
    @dispatch('submit', formData)


InitComponent = React.createClass
  mixins: [Arda.mixin, React.addons.LinkedStateMixin, InitController],
  render: ->
    @BootstrapFooter = require('../../components/common').BootstrapFooter
    require("jade-react!../../components/startup/template.jade") @


# 初期化画面用Context
class @StartupContext extends Arda.Context
  component:
    InitComponent
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