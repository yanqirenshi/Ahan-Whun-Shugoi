class Actions extends Simple_Redux_Actions {
    movePage (data) {
        return {
            type: 'MOVE-PAGE',
            data: data
        };
    }

    fetchAws (from) {
        let self = this;
        API.get('/vertex/aws', function (response) {
            STORE.dispatch(self.fetchedAws(response, from));
        });
    }
    fetchedAws (response, from) {
        let state = STORE.state();

        let aws = response.AWS;
        let commands = GraphUtil.marge2(state.commands,
                                        response.COMMANDS.NODES);
        let options = GraphUtil.marge2(state.options,
                                       response.OPTIONS.NODES);

        let aws_state = { ht: {}, list: [aws]};
        aws_state[aws._id] = aws;
        let r = GraphUtil.marge2(state.r,
                                 [].concat(
                                     GraphUtil.setEdgesDisplay(response.COMMANDS.RELATIONSHIPS, aws_state, commands),
                                     GraphUtil.setEdgesDisplay(response.OPTIONS.RELATIONSHIPS, aws_state, options)));

        return {
            from: from,
            type: 'FETCHED-AWS',
            data: {
                aws: aws,
                commands: commands,
                options: options,
                r: r
            }
        };
    }

    /*
     * fetch all
     */
    fetchCommands (from) {
        let self = this;
        API.get('/vertex/commands', function (response) {
            STORE.dispatch(self.fetchedCommands(response, from));
        });
    }
    fetchedCommands (response, from) {
        let state = STORE.state();
        let commands = GraphUtil.marge2(state.commands,
                                        response.nodes);
        let subcommands = GraphUtil.marge2(state.subcommands,
                                           response.RELATIONSHIPS.NODES);
        let r = GraphUtil.marge2(state.r,
                                 GraphUtil.setEdgesDisplay(response.RELATIONSHIPS.EDGES,
                                                           commands,
                                                           subcommands));
        return {
            from: from,
            type: 'FETCHED-COMMANDS',
            data: {
                commands: commands,
                subcommands: subcommands,
                r: r
            }
        };
    }
    fetchSubcommands (from) {
        let self = this;
        API.get('/vertex/subcommands', function (response) {
            STORE.dispatch(self.fetchedSubcommands(response, from));
        });
    }
    fetchedSubcommands (response, from) {
        let state = STORE.state();
        let subcommands = GraphUtil.marge2(state.subcommands,
                                           response.nodes);
        let options = GraphUtil.marge2(state.options,
                                       response.RELATIONSHIPS.NODES);
        let r = GraphUtil.marge2(state.r,
                                 GraphUtil.setEdgesDisplay(response.RELATIONSHIPS.EDGES,
                                                           subcommands,
                                                           options));
        return {
            from: from,
            type: 'FETCHED-SUBCOMMANDS',
            data: {
                subcommands: subcommands,
                options: options,
                r: r
            }
        };
    }

    /*
     * selector
     */
    switchSelector (data) {
        let state = STORE.state().selector;
        let display = state.display;
        if (data) {
            if (display) {
                if (state.element._class==data._class)
                    display = false;
                else
                    display = true;
            } else {
                display = true;
            }
        } else {
            display = false;
        }

        if (display && data._class=='COMMAND')
            this.fetchCommand4selector(data);

        return {
            type: 'SWITCH-SELECTOR',
            data: {
                selector: {
                    display: display,
                    element: display ? data : {_class:null}
                }
            }
        };
    }
    switchSelectorTab (data) {
        let tabs = STORE.state().selector.tabs;
        for (var i in tabs)
            tabs[i].display = (tabs[i].code == data);

        return {
            type: 'SWITCH-SELECTOR-TAB',
            data: {
                selector: { tabs: tabs }
            }
        };
    }
    /*
     * fetchCommand4selector
     */
    fetchCommand4selector (data) {
        let self = this;
        API.get('/vertex/commands/' + data._id, function (response) {
            STORE.dispatch(self.fetchedCommand4selector(response));
        });
    }
    fetchedCommand4selector (response) {
        let state = STORE.state();
        return {
            type: 'FETCHED-COMMAND-4-SELECTOR',
            data: {
                subcommands: GraphUtil.marge2(state.subcommands,
                                              response.RELATIONSHIPS.NODES),
                r: GraphUtil.marge2(state.r,
                                    response.RELATIONSHIPS.EDGES)
            }
        };
    }

    /*
     * changeNodeDisplay
     */
    changeNodeDisplay (node_class, _id, value) {
        if (node_class=='COMMAND')
            this.updateCommandDisplay(_id, value);
        if (node_class=='SUBCOMMAND')
            this.updateSubcommandDisplay(_id, value);
    }

    /*
     * updateCommandXXX
     */
    updateCommandDisplay(_id, value) {
        let self = this;
        API.get('/commands/' +_id + '/display/' + value, function (response) {
            STORE.dispatch(self.updatedCommandDisplay(response));
        });
    }
    updatedCommandDisplay(response) {
        let state = STORE.state();

        let child_node = response.NODE;
        let parent_node = response.RELASHONSHIP.NODE;
        let to_parent_edge = response.RELASHONSHIP.EDGE;

        GraphUtil.setObjectValues(child_node, state.commands.ht[child_node._id]);
        GraphUtil.setEdgeDisplay(state.r.ht[to_parent_edge._id],
                                 state.aws,
                                 state.commands.ht[child_node._id]);

        return {
            type: 'UPDATED-COMMAND-DISPLAY',
            data: {
                commands: state.commands,
                r: state.r
            }
        };
    }

    updateSubcommandDisplay(_id, value) {
        let self = this;
        API.get('/subcommands/' +_id + '/display/' + value, function (response) {
            STORE.dispatch(self.updatedSubcommandDisplay(response));
        });
    }
    updatedSubcommandDisplay(response) {
        let state = STORE.state();

        let child_node = response.NODE;
        let parent_node = response.RELASHONSHIP.NODE;
        let to_parent_edge = response.RELASHONSHIP.EDGE;

        GraphUtil.setObjectValues(child_node, state.subcommands.ht[child_node._id]);
        GraphUtil.setEdgeDisplay(state.r.ht[to_parent_edge._id],
                                 state.commands.ht[parent_node._id],
                                 state.subcommands.ht[child_node._id]);

        return {
            type: 'UPDATED-SUBCOMMAND-DISPLAY',
            data: {
                subcommands: state.subcommands,
                r: state.r
            }
        };
    }

    updateCommandLocation(_id, location) {
        let self = this;
        let data = {
            X: location.X,
            Y: location.Y,
            Z: location.Z
        };
        API.post('/commands/' +_id + '/location', data ,
                 function (response) {
                     STORE.dispatch(self.updatedCommandLocation(response));
                 });
    }
    updatedCommandLocation(response) {
        let state = STORE.state();

        let new_command = response;
        let to_node = state.commands.ht[new_command._id];

        GraphUtil.setCommandValues(new_command, to_node);

        return {
            type: 'UPDATED-COMMAND-LOCATION',
            data: {
                commands: state.commands
            }
        };
    }

    updateSubcommandLocation(_id, location) {
        let self = this;
        let data = {
            X: location.X,
            Y: location.Y,
            Z: location.Z
        };
        API.post('/subcommands/' +_id + '/location', data ,
                 function (response) {
                     STORE.dispatch(self.updatedSubcommandLocation(response));
                 });
    }
    updatedSubcommandLocation(response) {
        let state = STORE.state();

        let new_subcommand = response;
        let to_node = state.subcommands.ht[new_subcommand._id];

        GraphUtil.setObjectValues(new_subcommand, to_node);

        return {
            type: 'UPDATED-SUBCOMMAND-LOCATION',
            data: {
                commands: state.commands
            }
        };
    }
}
