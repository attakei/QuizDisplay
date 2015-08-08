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
    Arda.mixin
  ]

  render: ->
    require('./PointsRuleForm') @
