# --------------------------------------
#
# クレジットContext系パッケージ
#
# --------------------------------------
class @CreditContext extends Arda.Context
  component:
    require('../../components/credit').CreditComponent

  delegate: (subscribe) ->
    super

    subscribe 'end::context', ->
      App.router.popContext()
