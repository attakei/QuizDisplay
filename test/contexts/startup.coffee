# --------------------------------------
# ルール系モデルのテストケース
# --------------------------------------
require '../../src/globals'
assert         = require("assert")
StartupContext = require('../../src/contexts/startup').StartupContext


describe 'MaruBatsuRule test', () ->
  describe 'default state', () ->
    context = new StartupContext(null, {})
    it 'test right', () ->
      state_ = context.initState(context.props)
      assert.equal 12, state_.maxPlayers
      assert.equal 12, state_.playerNames.length
      assert.equal '', state_.playerNames[0]
      assert.equal '', state_.playerNames[11]
