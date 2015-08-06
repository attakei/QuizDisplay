# --------------------------------------
# ルール系モデルのテストケース
# --------------------------------------
require '../../src/globals'
assert         = require("assert")
StartupContext = require('../../src/contexts/startup').StartupContext


describe 'MaruBatsuRule test', () ->
  describe '#initState', () ->
    context = new StartupContext
    it 'test defaults', () ->
      state_ = context.initState({})
      assert.equal 12, state_.maxPlayers
      assert.equal 12, state_.playerNames.length
      assert.equal '', state_.playerNames[0]
      assert.equal '', state_.playerNames[11]

    it 'test overwrite', () ->
      state_ = context.initState({maxPlayers: 3})
      assert.equal 3, state_.maxPlayers
      assert.equal 3, state_.playerNames.length
      assert.equal '', state_.playerNames[0]
      assert.equal '', state_.playerNames[1]

  describe '#expandComponentProps', () ->
    context = new StartupContext

    it 'test to inherit player names', () ->
      state_ = context.initState({})
      state_.playerNames[1] = 'test'
      props_ = context.expandComponentProps({}, state_)
      assert.equal 'test', props_.playerNames[1]
