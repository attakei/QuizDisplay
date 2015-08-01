MaruBatsuForm = require('../_rules').MaruBatsuForm


# InitComponent用mixn
StartupComponentActions =
  getInitialState: ->
    {}

  handleSubmit: ->
    formData = {}
    # TODO: beta2以降で随時戻すことを検討する
    # formData.programName = @linkState('programName').value
    formData.programName = @linkState('programName').value or @props.rule.title()
    formData.playerNames = []
    for i in [0..@props.maxPlayers]
      val_ = @linkState('player[' + i + ']').value
      val_ = '' if typeof val_ == "undefined"
      formData.playerNames.push(val_)
    # TODO: 仮に7◯3✕をセットする
    @dispatch('submit', formData)


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
