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

ProgressComponent = React.createClass({
    mixins: [Arda.mixin, ProgressController],
    render: function(){
        var players = [];
        var self = this;
        this.props.players.map(function(player){
            players.push(<Player player={player} tryAnswer={self.tryAnswer} />);
        });
        return (
    <div>
    <nav className="navbar navbar-default">
      <div className="container-fluid">
        <div className="navbar-header">
          <p className="navbar-brand"><strong>{this.props.programName}</strong></p>
        </div>

        <div className="collapse navbar-collapse">
          <ul className="nav navbar-nav navbar-right">
            <li><a>{this.props.quizCount} 問経過</a></li>
            <li><a>menu</a></li>
          </ul>
        </div>
      </div>
    </nav>
    <div className="container">
      <div className="row">
      　{players}
      </div>
      <JudgePanel resetAnswer={this.resetAnswer} answerRight={this.answerRight} answerWrong={this.answerWrong} throughAnswer={this.throughAnswer} />
      {/*<ViewControlPanel />*/}
    </div>

    </div>
        );
    }
});

module.exports = ProgressComponent
