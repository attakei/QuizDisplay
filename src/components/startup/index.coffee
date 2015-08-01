clone = require('clone')
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
    @PlayerEntryList = PlayerEntryList
    @MaruBatsuForm = MaruBatsuForm

    require("./template") @


PlayerEntryList = React.createClass
  mixins: [
    Arda.mixin,
    React.addons.LinkedStateMixin,
  ]

  renameEntry: (e) ->
    playerNames = clone @props.playerNames
    playerNames[e.target.getAttribute('data-index')] = e.target.value
    @dispatch 'change::players', playerNames

  render: ->
    require('./PlayerEntryList') @
