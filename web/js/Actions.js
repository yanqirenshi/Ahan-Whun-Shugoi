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
    can_remove_p (node_id) {
        let state = STORE.get('beach');
        let r_list = state.r.list;

        for (var i in r_list) {
            let r = r_list[i];
            let source = r._source ? r._source : r.source;
            let target = r._target ? r._target : r.target;

            if (node_id==source._id && target._core.display)
                return false;
        }
        return true;
    }
    switchDisplay (type, _id, display) {
        if (!this.can_remove_p(_id))
            return alert('子供で表示しているやつがあるので非表示に出来ません。');

        let self = this;

        let path = '/' + type.toLowerCase()  + 's/' + _id + '/display/' + display;

        API.get(path, function (response) {
            STORE.dispatch(self.switchedDisplay(response, type, _id, display));
        });
    }
    class2key (cls) {
        let keys = {
            'AWS': 'aws',
            'COMMAND': 'commands',
            'SUBCOMMAND': 'subcommands',
            'OPTION': 'options',
        };

        return keys[cls];
    }
    showNode (node, parent_node, parent_edge, response) {
        let state = STORE.get('beach');
        let tools = this.tools.graph;

        let node_key = this.class2key(node._class);
        state[node_key] = tools.node.mergeNodes([node],  state[node_key]);

        let parent_key = this.class2key(parent_node._class);
        state[parent_key] = tools.node.mergeNodes([parent_node], state[parent_key]);

        state.r = tools.edge.mergeEdges(parent_edge, state.r);

        return state;
    }
    removeData(state, delete_p) {
        let data = state;
        let data_ht_new = Object.assign({}, data.ht);
        let data_list_new = [];

        for (var i in data.list) {
            let node = data.list[i];

            if(delete_p(node))
                delete data_ht_new[node._id];
            else
                data_list_new.push(node);
        }

        return { ht:data_ht_new, list: data_list_new };
    }
    hideNode (node, parent_node, parent_edge, response) {
        let state = STORE.get('beach');

        // remove Relationship
        state.r = this.removeData(state['r'], (r) => {
            let target = r._target ? r._target : r.target;
            return target._id==node._id;
        });

        // remove Node
        let node_key = this.class2key(node._class);
        state[node_key] = this.removeData(state[node_key], (target) => {
            return target._id == node._id;
        });

        return state;
    }
    switchedDisplay (response, type, _id, display) {
        let node = response.NODE;
        let parent_node = response.PARENT.NODE;
        let parent_edge = [response.PARENT.EDGE];

        let state;

        if (node.display)
            state = this.showNode(node, parent_node, parent_edge, response);
        else
            state = this.hideNode(node, parent_node, parent_edge, response);

        return {
            type: 'SWITCHED-DISPLAY',
            data: { beach: state },
            data_type: type,
        };
    }
}
