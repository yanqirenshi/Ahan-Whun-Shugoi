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

        let aws      = graphNode.mergeNodes([response.AWS],          state.aws);
        let commands = graphNode.mergeNodes(response.COMMANDS.NODES, state.commands);
        let options  = graphNode.mergeNodes(response.OPTIONS.NODES,  state.options);

        let r = state.r;
        r = graphEdge.mergeEdges(response.COMMANDS.RELATIONSHIPS, r);
        r = graphEdge.mergeEdges(response.OPTIONS.RELATIONSHIPS, r);

        return {
            from: from,
            type: 'FETCHED-AWS',
            data: {
                beach: {
                    aws:      aws,
                    commands: commands,
                    options:  options,
                    r:        r,
                }
            }
        };
    }
}
