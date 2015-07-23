# --------------------------------------
# ルール系モデル
# --------------------------------------


class @MaruBatsuRule
  constructor: (rightsForWin, wrongsForLose) ->
    @rightsForWin = rightsForWin
    @wrongsForLose = wrongsForLose
