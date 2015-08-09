clone = require('clone')

@MaruBatsuForm = React.createClass
  mixins: [
    Arda.mixin
  ]

  render: ->
    require('./MaruBatsuForm') @

  changeToWin: (e) ->
    param = clone @props
    param.toWin = +e.target.value
    @dispatch 'change::rule:param', param

  changeToLose: (e) ->
    param = clone @props
    param.toLose = +e.target.value
    @dispatch 'change::rule:param', param


@PointsRuleForm = React.createClass
  mixins: [
    Arda.mixin,
    React.addons.LinkedStateMixin,
  ]

  getInitialState: ->
    toLose: @props.rule.toLose or null

  render: ->
    require('./PointsRuleForm') @

  changeRuleParam: (e) ->
    param = {}
    param[e.target.name] = +e.target.value
    @dispatch 'change::rule:param', param

  toggleToLose: (e) ->
    param = {}
    param.hasLose = not e.target.checked
    @dispatch 'change::rule:param', param
