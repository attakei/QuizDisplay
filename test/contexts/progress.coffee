# --------------------------------------
# ルール系モデルのテストケース
# --------------------------------------
ProgressContext       = require('../../src/contexts/progress').ProgressContext
{Player, PlayerState} = require('../../src/models/players')


describe 'ProgressContext tests', () ->
  context = new ProgressContext
  players = [new Player(0, 'test1'), new Player(1, 'test2')]

  describe '#findAnswerPlayer', ->
    it 'not found', ->
      context.state = {players: players}
      assert.equal null, context.findAnswerPlayer()

    it 'found', ->
      context.state = {players: players}
      players[0].state = PlayerState.Answer
      answerPlayer = context.findAnswerPlayer()
      assert.notEqual null, answerPlayer
      assert.equal 'test1', answerPlayer.name
