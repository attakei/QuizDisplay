# --------------------------------------
# ルール系モデルのテストケース
# --------------------------------------
assert = require("assert")
rules = require('../src/models/rules')
PlayerState = require('../src/models/player').PlayerState


describe 'MaruBatsuRule test', () ->
  describe '#judgeWin', () ->
    it '', () ->
      rule = new rules.MaruBatsuRule(7, 3)
      player = {numOfRights: 6}
      assert.equal false, rule.judgeWin(player)
      player.numOfRights++
      assert.equal true, rule.judgeWin(player)

  describe '#judge', () ->
      rule = new rules.MaruBatsuRule(7, 3)
      player = {numOfRights: 6, state: PlayerState.Neutral}
      assert.equal PlayerState.Neutral, rule.judge(player)
      player.numOfRights++
      assert.equal PlayerState.Win, rule.judge(player)
      assert.equal PlayerState.Win, player.state
