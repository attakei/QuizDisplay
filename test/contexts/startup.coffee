# --------------------------------------
# Test for StartupContexts (./contexts/startup)
# --------------------------------------
require '../globals'
assert = require('assert')
TargetContext = require('../../src/contexts/startup').StartupContext


describe 'StartupContext tests', () ->
  describe '#programName', () ->
    context = new TargetContext()
    state = context.initState({})
    assert.equal state.programName, ''

  describe '#maxPlayers', () ->
    context = new TargetContext()

    it 'default value', () ->
      state = context.initState({})
      assert.equal state.maxPlayers, 12

    it 'use value of props', () ->
      state = context.initState({maxPlayers: 1})
      assert.equal state.maxPlayers, 1

  describe '#expandComponentProps', () ->
    context = new TargetContext()

    it 'maxPlayers', () ->
      props = context.expandComponentProps({}, {maxPlayers: 10})
      assert.equal props.maxPlayers, 10
