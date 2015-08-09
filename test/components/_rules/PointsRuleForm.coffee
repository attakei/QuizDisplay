require '../../spec_helper'
rules = require('../../../src/components/_rules')


describe 'PointsRuleForm tests', ->
  class StubComponent extends rules.PointsRuleForm
    render: ->
      React.createElement 'div'

  it '#toggleToLose render', () ->
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

  it '#changeRuleParam render', () ->
    class StubContext extends Arda.Context
      component: StubComponent

      expandComponentProps: (props, state) ->
        rule: {toLose: 1}

      delegate: (subscribe) ->
        super

        subscribe 'change::rule:param', (param) ->
          assert.equal param.toLose, 2

    router = new Arda.Router Arda.DefaultLayout, document.body
    router.pushContext(StubContext, {})
    .then (context) ->
      assert context instanceof Arda.Context
      component = context.getActiveComponent()
      component.changeRuleParam({target: {'name': 'toLose', 'value': 2}})
