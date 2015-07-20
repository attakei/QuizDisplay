var InitController = require('./index').InitController


module.exports = React.createClass({
    mixins: [Arda.mixin, React.addons.LinkedStateMixin, InitController],
    render: function(){
        var playerNameForms = [];
        for (var i=0; i < this.props.maxPlayers; i++) {
            playerNameForms.push(<input type="text" className="form-control" valueLink={this.linkState('player['+i+']')} />);
        }

        return (
<div className="container" id="container">
    <div className="row">
        <h2>設定</h2>
        <form>
            <div className="form-group">
                <label htmlFor="title">タイトル</label>
                <input type="text" className="form-control" id="title"
                    valueLink={this.linkState('programName')} placeholder="企画名" />
            </div>
            <div className="form-group">
                <label htmlFor="players">参加者</label>
                {playerNameForms}
                <p className="help-block">Example block-level help text here.</p>
            </div>
            <button type="button" className="btn btn-primary" onClick={this.handleSubmit}>開始！</button>
        </form>
    </div>
</div>
        );
    }
});
