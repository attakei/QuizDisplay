require '../../spec_helper'
rules = require('../../../src/components/_rules')


it 'toggleToLose render', () ->
  class StubComponent extends rules.PointsRuleForm
    render: ->
      React.createElement 'div'

  class StubContext extends Arda.Context
    component: StubComponent

    expandComponentProps: (props, state) ->
      rule: {toLose: 1}

    delegate: (subscribe) ->
      super

      subscribe 'change::rule:param', (param) ->
        assert.equal param.hasLose, true

  router = new Arda.Router Arda.DefaultLayout, document.body
  router.pushContext(StubContext, {})
    .then (context) ->
      assert context instanceof Arda.Context
      component = context.getActiveComponent()
      button = {target: React.createElement 'input', {checked:false}}
      component.toggleToLose(button)
