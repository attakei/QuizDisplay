assert = require("assert")
players = require('../../src/models/players')
{Player, PlayerState} = require('../../src/models/players')


describe 'Player test', () ->
  describe 'constructor', () ->
    player = new Player(1, 'test')

    it 'state is Neutral', () ->
      assert.equal PlayerState.Neutral, player.state


describe 'ScorePlayer test', () ->
  player = new players.ScorePlayer(1, 'test')

  it '#calcScore', () ->
    assert.equal 0, player.calcScore()

  it '#displayPositive', () ->
    assert.equal '0 pts', player.displayPositive()

  it '#displayNegative', () ->
    assert.equal '', player.displayNegative()
