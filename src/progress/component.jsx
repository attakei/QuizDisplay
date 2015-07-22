var ProgressController = require('./index').ProgressController

Player_jade = require("jade-react!./Player.jade");
Player = React.createClass({
    render: Player_jade
});


JudgePanel_jade = require("jade-react!./JudgePanel.jade");
JudgePanel = React.createClass({
    render: JudgePanel_jade
});

ViewControlPanel_jade = require("jade-react!./ViewControlPanel.jade");
ViewControlPanel = React.createClass({
    render: ViewControlPanel_jade
});

ProgressComponent_jade = require("jade-react!./ProgressComponent.jade");
ProgressComponent = React.createClass({
    mixins: [Arda.mixin, ProgressController],
    render: ProgressComponent_jade
});

module.exports = ProgressComponent
