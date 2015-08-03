# --------------------------------------
# ルール系モデルのテストケース
# --------------------------------------
assert = require("assert")
rules = require('../../src/models/rules')
PlayerState = require('../../src/models/players').PlayerState


describe 'MaruBatsuRule test', () ->
  TestTargetRule = rules.MaruBatsuRule

  it '#judgeWin', () ->
    rule = new TestTargetRule(7, 3)
    player = {rights: 6}
    assert.equal false, rule.judgeWin(player)
    player.rights++
    assert.equal true, rule.judgeWin(player)

  it '#judgeLose', () ->
    rule = new TestTargetRule(7, 3)
    player = {wrongs: 2}
    assert.equal false, rule.judgeLose(player)
    player.wrongs++
    assert.equal true, rule.judgeLose(player)

  describe '#judge', () ->
    rule = new TestTargetRule(7, 3)

    it 'If num of rights is more then rules, it change state', () ->
      player = {rights: 6, state: PlayerState.Neutral}
      assert.equal PlayerState.Neutral, rule.judge(player)
      player.rights++
      assert.equal PlayerState.Win, rule.judge(player)
      assert.equal PlayerState.Win, player.state

    it 'If num of wrongs is more then rules, change state to Lose', () ->
      player = {wrongs: 2, state: PlayerState.Neutral}
      assert.equal PlayerState.Neutral, rule.judge(player)
      player.wrongs++
      assert.equal PlayerState.Lose, rule.judge(player)
      assert.equal PlayerState.Lose, player.state

    it 'If state is already Win, it do not change state', () ->
      player = {rights: 7, wrongs: 2, state: PlayerState.Win}
      assert.equal PlayerState.None, rule.judge(player)
      player.wrongs++
      assert.equal PlayerState.None, rule.judge(player)

    it 'If state is already Win, it do not change state', () ->
      player = {rights: 6, wrongs: 3, state: PlayerState.Lose}
      assert.equal PlayerState.None, rule.judge(player)
      player.rights++
      assert.equal PlayerState.None, rule.judge(player)

  describe '#displayPositive', () ->
    rule = new TestTargetRule(7, 3)

    it 'ref player.rights', () ->
      player = {rights: 0, wrongs: 0, state: PlayerState.Neutral}
      assert.equal '◯ 0', rule.displayPositive(player)
      player.rights++
      assert.equal '◯ 1', rule.displayPositive(player)
      player.rights = 7
      assert.equal '勝抜', rule.displayPositive(player)

    it 'not ref player.wrongs', () ->
      player = {rights: 0, wrongs: 0, state: PlayerState.Neutral}
      player.wrongs++
      assert.equal '◯ 0', rule.displayPositive(player)

    it 'not ref player.state', () ->
      player = {rights: 0, wrongs: 0, state: PlayerState.Neutral}
      player.state = PlayerState.Win
      assert.equal '勝抜', rule.displayPositive(player)

  describe '#displayNegative', () ->
    rule = new TestTargetRule(7, 3)

    it 'ref player.wrongs', () ->
      player = {rights: 0, wrongs: 0, state: PlayerState.Neutral}
      assert.equal '✕ 0', rule.displayNegative(player)
      player.wrongs++
      assert.equal '✕ 1', rule.displayNegative(player)
      player.wrongs = 3
      assert.equal '失格', rule.displayNegative(player)

    it 'not ref player.rights', () ->
      player = {rights: 0, wrongs: 0, state: PlayerState.Neutral}
      player.rights++
      assert.equal '✕ 0', rule.displayNegative(player)

    it 'not ref player.state', () ->
      player = {rights: 0, wrongs: 0, state: PlayerState.Neutral}
      player.state = PlayerState.Lose
      assert.equal '失格', rule.displayNegative(player)


describe 'PointsRule', () ->
  TestTargetRule = rules.PointsRule

  describe '#constructor', () ->
    it 'default', () ->
      rule = new TestTargetRule()
      assert.equal 10, rule.scoreToWin
      assert.equal 1, rule.scoreForRight
      assert.equal null, rule.scoreToLose
      assert.equal -1, rule.scoreForWrong

    it 'specify arg', () ->
      rule = new TestTargetRule(2)
      assert.equal 2, rule.scoreToWin
      assert.equal null, rule.scoreToLose
      assert.equal -1, rule.scoreForWrong
      rule = new TestTargetRule(10,-2)
      assert.equal -2, rule.scoreToLose

  describe '#calcScore', () ->
    it 'default', () ->
      rule = new TestTargetRule(10, -10)
      player = {rights: 0, wrongs: 0, state: PlayerState.Neutral}
      player.rights++
      assert.equal 1, rule.calcScore(player)

    it 'right points', () ->
      rule = new TestTargetRule(10, -10, 2, -1)
      player = {rights: 0, wrongs: 0, state: PlayerState.Neutral}
      player.rights++
      assert.equal 2, rule.calcScore(player)

    it 'wrong points', () ->
      rule = new TestTargetRule(10, -10, 1, -2)
      player = {rights: 0, wrongs: 0, state: PlayerState.Neutral}
      player.wrongs++
      assert.equal -2, rule.calcScore(player)

  describe '#displayPositive', () ->
    rule = new TestTargetRule()
    it 'count up and down', () ->
      player = {rights: 0, wrongs: 0, state: PlayerState.Neutral}
      assert.equal '0 pts', rule.displayPositive(player)
      player.wrongs++
      assert.equal '', rule.displayPositive(player)
      player.rights++
      assert.equal '0 pts', rule.displayPositive(player)
      player.rights++
      assert.equal '1 pts', rule.displayPositive(player)
    it 'count up and down', () ->
      player = {rights: 10, wrongs: 0, state: PlayerState.Neutral}
      assert.equal '勝抜', rule.displayPositive(player)

  describe '#displayNegative', () ->
    rule = new TestTargetRule()
    it 'count up and down', () ->
      player = {rights: 0, wrongs: 0, state: PlayerState.Neutral}
      assert.equal '', rule.displayNegative(player)
      player.rights++
      assert.equal '', rule.displayNegative(player)
      player.wrongs++
      assert.equal '', rule.displayNegative(player)
      player.wrongs++
      assert.equal '-1 pts', rule.displayNegative(player)
    it 'case to set lose score', () ->
      rule = new TestTargetRule(10, -2)
      player = {rights: 0, wrongs: 2, state: PlayerState.Neutral}
      assert.equal '失格', rule.displayNegative(player)

  it '#judgeWin', () ->
    rule = new TestTargetRule()
    player = {rights: 9, wrongs: 0}
    assert.equal false, rule.judgeWin(player)
    player.rights++
    assert.equal true, rule.judgeWin(player)
    player.wrongs++
    assert.equal false, rule.judgeWin(player)
    player.rights++
    assert.equal true, rule.judgeWin(player)

  describe '#judgeLose', () ->
    it 'has scoreToLose', () ->
      rule = new TestTargetRule(10, -3)
      player = {rights: 0, wrongs: 2}
      assert.equal false, rule.judgeLose(player)
      player.wrongs++
      assert.equal true, rule.judgeLose(player)
      player.rights++
      assert.equal false, rule.judgeLose(player)
      player.wrongs++
      assert.equal true, rule.judgeLose(player)

    it 'does not have scoreToLose', () ->
      rule = new TestTargetRule(10)
      player = {rights: 0, wrongs: 2}
      assert.equal false, rule.judgeLose(player)
      player.wrongs++
      assert.equal false, rule.judgeLose(player)
      player.rights++
      assert.equal false, rule.judgeLose(player)
      player.wrongs++
      assert.equal false, rule.judgeLose(player)
