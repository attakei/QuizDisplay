var ProgressController = require('./index').ProgressController


Player = React.createClass({
    render: function(){
        if (this.props.player.isAnswer) {
            var playerIdTag = <p className="text-center" style={{backgroundColor: 'yellow'}}>{this.props.player.id}</p>;
        } else {
            var playerIdTag = <p className="text-center">{this.props.player.id}</p>;
        }
        return (
        <div className="col-md-1" onClick={this.props.tryAnswer} data-playerid={this.props.player.id} data-answer={this.props.player.isAnswer}>
            {playerIdTag}
            <p className="text-center">{this.props.player.name}</p>
            <p className="text-center">○1</p>
            <p className="text-center">○1</p>
        </div>
        );
    }
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
    </div>
    <div className="container">
      <div className="row">
        正誤操作
        <button type="button" className="btn btn-default" onClick={this.resetAnswer}>リセット</button>
        <button type="button" className="btn btn-primary">正解</button>
        <button type="button" className="btn btn-danger">誤答</button>
      </div>
    </div>
    <div className="container">
      <div className="row">
        表示操作
        <button type="button" className="btn btn-info">Info</button>
        <button type="button" className="btn btn-info">Info</button>
        <button type="button" className="btn btn-info">Info</button>
      </div>
    </div>

    </div>
        );
    }
});

module.exports = ProgressComponent
