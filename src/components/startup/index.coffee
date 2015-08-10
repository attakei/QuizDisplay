clone = require('clone')
{RuleSelector, MaruBatsuRuleForm, PointsRuleForm} = require('../_rules')


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
    @dispatch 'start::program', formData


@StartupComponent = React.createClass
  mixins: [
    Arda.mixin,
    React.addons.LinkedStateMixin,
    StartupComponentActions
  ]

  render: ->
    @PlayerEntryList = PlayerEntryList
    @RuleSelector = RuleSelector
    @MaruBatsuRuleForm = MaruBatsuRuleForm
    @PointsRuleForm = PointsRuleForm

    require("./template") @


PlayerEntryList = React.createClass
  mixins: [
    Arda.mixin,
  ]

  render: ->
    @PlayerEntry = PlayerEntry
    require('./PlayerEntryList') @


PlayerEntry = React.createClass
  mixins: [
    Arda.mixin,
  ]

  changeName: (e) ->
    updateData =
      dataIndex: e.target.getAttribute('data-index')
      name: e.target.value
    @dispatch 'change::players', updateData

  render: ->
    require('./PlayerEntry') @
