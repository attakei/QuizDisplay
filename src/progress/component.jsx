var ProgressController = require('./index').ProgressController;
var JudgePanel = require('./index').JudgePanel;

Player_jade = require("jade-react!./Player.jade");
Player = React.createClass({
    render: Player_jade
});


ViewControlPanel_jade = require("jade-react!./ViewControlPanel.jade");
ViewControlPanel = React.createClass({
    render: ViewControlPanel_jade
});

module.exports = ProgressComponent
