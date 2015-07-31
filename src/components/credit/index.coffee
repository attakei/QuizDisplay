@CreditComponent = React.createClass
  mixins: [
    Arda.mixin
  ]

  render: ->
    require("./template") @

  doEndComponent: ->
    @dispatch 'end::context'
