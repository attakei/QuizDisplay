ProgressComponent = React.createClass({
    mixins: [Arda.mixin],
    render: function(){
        var players = [];
        for (var i = 0; i < this.props.players.length; i++) {
            players.push(
                <div className="col-md-1">
                    <p className="text-center">{this.props.players[i]}</p>
                    <p className="text-center">○1</p>
                    <p className="text-center">○1</p>
                </div>
            );
        }
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
        <button type="button" className="btn btn-default">リセット</button>
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
