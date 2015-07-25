# --------------------------------------
# Test for StartupContexts (./contexts/startup)
# --------------------------------------
require '../globals'
assert = require('assert')
TargetIndex = require('../../src/contexts/startup')
TargetContext = require('../../src/contexts/startup').StartupContext


describe 'StartupContext tests', () ->
  it '#programName', () ->
    context = new TargetContext()
    state = context.initState({})
    assert.equal state.programName, ''

  describe '#maxPlayers', () ->
    context = new TargetContext()

    it 'default value', () ->
      state = context.initState({})
      assert.equal state.maxPlayers, 8

    it 'use value of props', () ->
      state = context.initState({maxPlayers: 1})
      assert.equal state.maxPlayers, 1

  describe '#expandComponentProps', () ->
    context = new TargetContext()

    it 'maxPlayers', () ->
      props = context.expandComponentProps({}, {maxPlayers: 10})
      assert.equal props.maxPlayers, 10


describe 'StartupComponent tests', () ->
  it 'none test(stub)', () ->
    assert.ok true


describe 'StartupController tests', () ->
  Impl = React.createClass
    mixins: [TargetIndex.StartupController, React.addons.LinkedStateMixin]
    render: ->
    dispatch: (name, params) ->
      return [name, params]
  impl = new Impl({programName: '', maxPlayers: 3})

  it '#state', () ->
    state = impl.getInitialState()
    assert.ok state.hasOwnProperty('programName')
    assert.ok state.hasOwnProperty('playerName-2')
    assert.ok !state.hasOwnProperty('playerName-3')

  it '#handleSubmit', () ->
    ret = impl.handleSubmit()
    assert.equal 'start:program', ret[0]
    assert.ok ret[1].hasOwnProperty('name')
    assert.ok ret[1].hasOwnProperty('playerNames')
    assert.equal 3, ret[1].playerNames.length
