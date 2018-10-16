class Actions extends Vanilla_Redux_Actions {
    movePage (data) {
        return {
            type: 'MOVE-PAGE',
            data: data
        };
    }
    fetchAws (from) {
        let self = this;
        API.get('/aws', function (response) {
            STORE.dispatch(self.fetchedAws(response, from));
        });
    }
    fetchedAws (response, from) {
        let GraphUtil = new GraphUtility();
        let graphNode = new GraphNode();
        let graphEdge = new GraphEdge();

        let state = STORE.get('beach');

        response.AWS.commands = response.COMMANDS;

        state.aws     = graphNode.mergeNodes([response.AWS],                 state.aws);
        state.options = graphNode.mergeNodes(response.OPTIONS.NODES,         state.options);
        state.r       = graphEdge.mergeEdges(response.OPTIONS.RELATIONSHIPS, state.r);

        // injection
        let edges = state.r.list;
        let nodes = Object.assign({}, state.aws.ht, state.options.ht);
        graphEdge.injections(edges, nodes);

        return {
            from: from,
            type: 'FETCHED-AWS',
            data: {
                beach: state
            }
        };
    }
    switchDisplay (type, _id, display) {
        let self = this;

        let path = '/' + type.toLowerCase()  + 's/' + _id + '/display/' + display;

        API.get(path, function (response) {
            STORE.dispatch(self.switchedDisplay(response, type, _id, display));
        });
    }
    switchedDisplay (response, type, _id, display) {
        let data = STORE.get('beach');

        if (type=='COMMAND')
            data.commands.ht[_id]._core.display = display;

        return {
            type: 'SWITCHED-DISPLAY',
            data: data,
            data_type: type,
        };
    }
}
