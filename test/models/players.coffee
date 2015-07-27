assert = require("assert")
players = require('../../src/models/players')
{Player, PlayerState} = require('../../src/models/players')


describe 'Player test', () ->
  describe 'constructor', () ->
    player = new Player(1, 'test')

    it 'state is Neutral', () ->
      assert.equal PlayerState.Neutral, player.state

  describe '#displayPositive', () ->
    it 'ref it.numOfRights', () ->
      p = new Player(1, 'test')
      assert.equal '◯ 0', p.displayPositive()
      p.numOfRights++
      assert.equal '◯ 1', p.displayPositive()
      p.numOfWrongs++
      assert.equal '◯ 1', p.displayPositive()

  describe '#displayNegative', () ->
    it 'ref it.numOfWrongs', () ->
      p = new Player(1, 'test')
      assert.equal '✕ 0', p.displayNegative()
      p.numOfWrongs++
      assert.equal '✕ 1', p.displayNegative()
      p.numOfRights++
      assert.equal '✕ 1', p.displayNegative()


describe 'ScorePlayer test', () ->
  player = new players.ScorePlayer(1, 'test')

  it '#calcScore', () ->
    assert.equal 0, player.calcScore()

  it '#displayPositive', () ->
    assert.equal '0 pts', player.displayPositive()

  it '#displayNegative', () ->
    assert.equal '', player.displayNegative()
