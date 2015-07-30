@MaruBatsuForm = React.createClass
  mixins: [
    Arda.mixin,
    React.addons.LinkedStateMixin
  ]

  render: ->
    require('./MaruBatsuForm') @
