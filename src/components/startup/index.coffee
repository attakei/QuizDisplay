MaruBatsuForm = require('../_rules').MaruBatsuForm


# InitComponent用mixn
StartupComponentActions =
  getInitialState: ->
    {}

  handleSubmit: ->
    formData = {}
    # TODO: beta2以降で随時戻すことを検討する
    # formData.programName = @linkState('programName').value
    rule = @props.rule
    formData.programName = rule.props.toWin + '○' + rule.props.toLose + '✕'
    formData.playerNames = []
    for i in [0..@props.maxPlayers]
      val_ = @linkState('player[' + i + ']').value
      val_ = '' if typeof val_ == "undefined"
      formData.playerNames.push(val_)
    # TODO: 仮に7◯3✕をセットする
    MaruBatsuRule = require('../../models/rules').MaruBatsuRule
    formData.rule = new MaruBatsuRule(rule.props.toWin, rule.props.toLose)
    @dispatch('submit', formData)

  goToCredit: ->
    @dispatch 'start::context:credit'


@StartupComponent = React.createClass
  mixins: [
    Arda.mixin,
    React.addons.LinkedStateMixin,
    StartupComponentActions
  ]

  render: ->
    @BootstrapFooter = require('../common').BootstrapFooter
    @MaruBatsuForm = MaruBatsuForm
    require("./template") @
