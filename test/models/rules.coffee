# --------------------------------------
# ルール系モデルのテストケース
# --------------------------------------
assert      = require("assert")
rules       = require('../../src/models/rules')
PlayerState = require('../../src/models/players').PlayerState


class RuleImpl extends rules.RuleBase
  _judgeRight: (player) ->
    return true

  _judgeWrong: (player) ->
    return false


describe 'RuleBase tests', () ->
  rule = new RuleImpl
  player = {}

  it '#judge with right', () ->
    assert.equal true, rule.judge(player, rules.Judge.Right)

  it '#judge with wrong', () ->
    assert.equal false, rule.judge(player, rules.Judge.Wrong)


describe 'MaruBatsuRule test', () ->
  TestTargetRule = rules.MaruBatsuRule
  rule = new rules.MaruBatsuRule(4, 2)

  describe '#judge', () ->
    it 'test right', () ->
      player = {rights: 0}
      rule.judge(player, rules.Judge.Right)
      assert.equal 1, player.rights

    it 'test wrong', () ->
      player = {wrongs: 0}
      rule.judge(player, rules.Judge.Wrong)
      assert.equal 1, player.wrongs

  it '#_checkStateWin', () ->
    rule = new TestTargetRule(7, 3)
    player = {rights: 6}
    assert.equal false, rule._checkStateWin(player)
    player.rights++
    assert.equal true, rule._checkStateWin(player)

  it '#_checkStateLose', () ->
    rule = new TestTargetRule(7, 3)
    player = {wrongs: 2}
    assert.equal false, rule._checkStateLose(player)
    player.wrongs++
    assert.equal true, rule._checkStateLose(player)

  describe '#checkNextState', () ->
    rule = new TestTargetRule(7, 3)

    it 'If num of rights is more then rules, it change state', () ->
      player = {rights: 6, state: PlayerState.Neutral}
      assert.equal PlayerState.Neutral, rule.checkNextState(player)
      player.rights++
      assert.equal PlayerState.Win, rule.checkNextState(player)
#      assert.equal PlayerState.Win, player.state

    it 'If num of wrongs is more then rules, change state to Lose', () ->
      player = {wrongs: 2, state: PlayerState.Neutral}
      assert.equal PlayerState.Neutral, rule.checkNextState(player)
      player.wrongs++
      assert.equal PlayerState.Lose, rule.checkNextState(player)
#      assert.equal PlayerState.Lose, player.state

    it 'If state is already Win, it do not change state', () ->
      player = {rights: 7, wrongs: 2, state: PlayerState.Win}
      assert.equal PlayerState.Win, rule.checkNextState(player)
      player.wrongs++
      assert.equal PlayerState.Win, rule.checkNextState(player)

    it 'If state is already Win, it do not change state', () ->
      player = {rights: 6, wrongs: 3, state: PlayerState.Lose}
      assert.equal PlayerState.Lose, rule.checkNextState(player)
      player.rights++
      assert.equal PlayerState.Lose, rule.checkNextState(player)

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
      assert.equal 10, rule.toWin
      assert.equal 1, rule.scoreForRight
      assert.equal null, rule.toLose
      assert.equal -1, rule.scoreForWrong

    it 'specify arg', () ->
      rule = new TestTargetRule(2)
      assert.equal 2, rule.toWin
      assert.equal null, rule.toLose
      assert.equal -1, rule.scoreForWrong
      rule = new TestTargetRule(10,-2)
      assert.equal -2, rule.toLose

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

  describe '#judge', () ->
    rule = new TestTargetRule()

    it 'test right', () ->
      player = {rights: 0}
      rule.judge(player, rules.Judge.Right)
      assert.equal 1, player.rights

    it 'test wrong', () ->
      player = {wrongs: 0}
      rule.judge(player, rules.Judge.Wrong)
      assert.equal 1, player.wrongs

  describe '#_checkStateWin', () ->
    rule = new TestTargetRule()

    it '', ->
      player = {rights: 9, wrongs: 0, state: PlayerState.Neutral}
      assert.equal false, rule._checkStateWin(player)
      player.rights++
      assert.equal true, rule._checkStateWin(player)

  describe '#_checkStateLose', () ->
    it 'has toLose', () ->
      rule = new TestTargetRule(10, -10)
      player = {rights: 0, wrongs: 9, state: PlayerState.Neutral}
      assert.equal false, rule._checkStateLose(player)
      player.wrongs++
      assert.equal true, rule._checkStateLose(player)

    it 'not has toLose', () ->
      rule = new TestTargetRule(10)
      player = {rights: 0, wrongs: 9, state: PlayerState.Neutral}
      assert.equal false, rule._checkStateLose(player)
      player.wrongs++
      assert.equal false, rule._checkStateLose(player)
