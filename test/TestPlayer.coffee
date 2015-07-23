assert = require("assert")
players = require('../src/models/player')


describe 'Player test', () ->
  describe '#displayPositive', () ->
    it 'ref it.numOfRights', () ->
      p = new players.Player(1, 'test')
      assert.equal '◯ 0', p.displayPositive()
      p.numOfRights++
      assert.equal '◯ 1', p.displayPositive()
      p.numOfWrongs++
      assert.equal '◯ 1', p.displayPositive()

  describe '#displayNegative', () ->
    it 'ref it.numOfWrongs', () ->
      p = new players.Player(1, 'test')
      assert.equal '✕ 0', p.displayNegative()
      p.numOfWrongs++
      assert.equal '✕ 1', p.displayNegative()
      p.numOfRights++
      assert.equal '✕ 1', p.displayNegative()
