# --------------------------------------
# ルール系モデルのテストケース
# --------------------------------------
assert = require("assert")
rules = require('../src/models/rules')


describe 'MaruBatsuRule test', () ->
  describe '#judgeWin', () ->
    it '', () ->
      rule = new rules.MaruBatsuRule(7, 3)
