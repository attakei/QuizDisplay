# --------------------------------------
# ルール系モデルのテストケース
# --------------------------------------
assert = require("assert")
rules = require('../../src/models/rules')
PlayerState = require('../../src/models/players').PlayerState


describe 'MaruBatsuRule test', () ->
  it '#judgeWin', () ->
    rule = new rules.MaruBatsuRule(7, 3)
    player = {numOfRights: 6}
    assert.equal false, rule.judgeWin(player)
    player.numOfRights++
    assert.equal true, rule.judgeWin(player)

  it '#judgeLose', () ->
    rule = new rules.MaruBatsuRule(7, 3)
    player = {numOfWrongs: 2}
    assert.equal false, rule.judgeLose(player)
    player.numOfWrongs++
    assert.equal true, rule.judgeLose(player)

  describe '#judge', () ->
    rule = new rules.MaruBatsuRule(7, 3)

    it 'If num of rights is more then rules, it change state', () ->
      player = {numOfRights: 6, state: PlayerState.Neutral}
      assert.equal PlayerState.Neutral, rule.judge(player)
      player.numOfRights++
      assert.equal PlayerState.Win, rule.judge(player)
      assert.equal PlayerState.Win, player.state

    it 'If num of wrongs is more then rules, change state to Lose', () ->
      player = {numOfWrongs: 2, state: PlayerState.Neutral}
      assert.equal PlayerState.Neutral, rule.judge(player)
      player.numOfWrongs++
      assert.equal PlayerState.Lose, rule.judge(player)
      assert.equal PlayerState.Lose, player.state

    it 'If state is already Win, it do not change state', () ->
      player = {numOfRights: 7, numOfWrongs: 2, state: PlayerState.Win}
      assert.equal PlayerState.None, rule.judge(player)
      player.numOfWrongs++
      assert.equal PlayerState.None, rule.judge(player)

    it 'If state is already Win, it do not change state', () ->
      player = {numOfRights: 6, numOfWrongs: 3, state: PlayerState.Lose}
      assert.equal PlayerState.None, rule.judge(player)
      player.numOfRights++
      assert.equal PlayerState.None, rule.judge(player)
