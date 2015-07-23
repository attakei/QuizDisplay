# --------------------------------------
# ルール系モデルのテストケース
# --------------------------------------
assert = require("assert")
rules = require('../src/models/rules')
PlayerState = require('../src/models/player').PlayerState


describe 'MaruBatsuRule test', () ->
  describe '#judgeWin', () ->
    it 'Num of rights is more than rules, it change state', () ->
      rule = new rules.MaruBatsuRule(7, 3)
      player = {numOfRights: 6}
      assert.equal false, rule.judgeWin(player)
      player.numOfRights++
      assert.equal true, rule.judgeWin(player)

  describe '#judgeLose', () ->
    it 'Num of wrongs is more than rules, it change state', () ->
      rule = new rules.MaruBatsuRule(7, 3)
      player = {numOfWrongs: 2}
      assert.equal false, rule.judgeLose(player)
      player.numOfWrongs++
      assert.equal true, rule.judgeLose(player)

  describe '#judge', () ->
    rule = new rules.MaruBatsuRule(7, 3)
    player = {numOfRights: 6, state: PlayerState.Neutral}
    assert.equal PlayerState.Neutral, rule.judge(player)
    player.numOfRights++
    assert.equal PlayerState.Win, rule.judge(player)
    assert.equal PlayerState.Win, player.state
