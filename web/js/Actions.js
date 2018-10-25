class Actions extends Vanilla_Redux_Actions {
    constructor() {
        super();
        this.tools = {
            graph: {
                util: new GraphUtility(),
                node: new GraphNode(),
                edge: new GraphEdge(),
            }
        };
    }
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

        let aws = response.AWS;
        state.aws     = graphNode.mergeNodes([aws],                          state.aws);
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
    fetchCommandsAtDisplayed () {
        let self = this;
        API.get('/commands/display', (response) => {
            STORE.dispatch(this.fetchedCommandsAtDisplayed(response));
        });
    }
    fetchedCommandsAtDisplayed (response) {
        let commands = response.NODES;
        let parent_r = response.EDGES;

        let state = STORE.get('beach');
        let tools = this.tools.graph;
        state.commands = tools.node.mergeNodes(commands, state.commands);
        state.r        = tools.edge.mergeEdges(parent_r, state.r);

        return {
            type: 'FETCHED-COMMANDS-AT-DISPLAYED',
            data: { beach: state },
        };
    }
    fetchSubcommandsAtDisplayed () {
        let self = this;
        API.get('/subcommands/display', (response) => {
            STORE.dispatch(this.fetchedSubcommandsAtDisplayed(response));
        });
    }
    fetchedSubcommandsAtDisplayed (response) {
        let subcommands = response.NODES;
        let parent_r = response.EDGES;

        let state = STORE.get('beach');
        let tools = this.tools.graph;

        state.subcommands = tools.node.mergeNodes(subcommands, state.subcommands);
        state.r           = tools.edge.mergeEdges(parent_r, state.r);

        return {
            type: 'FETCHED-SUBCOMMANDS-AT-DISPLAYED',
            data: { beach: state }
        };
    }
    fetchOptionsAtDisplayed () {
        let self = this;
        API.get('/options/display', (response) => {
            STORE.dispatch(this.fetchedOptionsAtDisplayed(response));
        });
    }
    fetchedOptionsAtDisplayed (response) {
        let options  = response.NODES;
        let parent_r = response.EDGES;

        let state = STORE.get('beach');
        let tools = this.tools.graph;

        state.options = tools.node.mergeNodes(options, state.options);
        state.r       = tools.edge.mergeEdges(parent_r, state.r);

        return {
            type: 'FETCHED-OPTIONS-AT-DISPLAYED',
            data: { beach: state }
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
        let command = [response.COMMAND];
        let parent = [response.PARENT.NODE];
        let parent_r = [response.PARENT.EDGE];

        let state = STORE.get('beach');
        let tools = this.tools.graph;
        state.commands = tools.node.mergeNodes(command,  state.commands);
        state.aws      = tools.node.mergeNodes(parent,   state.aws);
        state.r        = tools.edge.mergeEdges(parent_r, state.r);

        return {
            type: 'SWITCHED-DISPLAY',
            data: { beach: state },
            data_type: type,
        };
    }
}
