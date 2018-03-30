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
        aws_state.ht[aws._id] = aws;
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
                if (state.element._class==data._class &&
                    state.element._id==data._id)
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
        // TODO: この関数きたないな。。。

        let selector = STORE.state().selector;

        // 一旦表示/非表示をセット
        let tabs = selector.tabs;
        for (var i in tabs)
            tabs[i].select = (tabs[i].code == data);

        // element._class で display を設定
        let _class = selector.element._class;
        let displays = {
            'AWS': [0,2,3],
            'COMMAND': [1,3],
            'SUBCOMMAND': [2,3],
            'OPTION': [3]
        };
        for (var i in tabs)
            tabs[i].display = displays[_class] && (displays[_class].indexOf(i*1) >= 0);

        // element._class で select を補正
        if (displays[_class]) {
            let selected = (function () {
                let targets = displays[_class];
                for (var i in targets) {
                    if (tabs[targets[i]].select)
                        return true;
                }
                return false;
            }());
            if (!selected)
                tabs[displays[_class][0]].select=true;
        }

        return {
            type: 'SWITCH-SELECTOR-TAB',
            data: {
                selector: { tabs: tabs }
            }
        };
    }
    updateSelectorSerchWorkd4Commands (search_keyword) {
        if (search_keyword && search_keyword.length==0)
            search_keyword = null;

        let tabs = STORE.state().selector.tabs;

        tabs[0].search = search_keyword;

        return {
            type: 'UPDATE-SELECTOR-SERCH-WORKD-4-COMMANDS',
            data: {
                selector: {
                    tabs: tabs
                }
            }

        };
    }
    updateSelectorElementKeword (tab_code, word) {
        let tabs = STORE.state().selector.tabs;
        for (var i in tabs){
            if(tabs[i].code==tab_code) {
                tabs[i].search = word;
            }
        }
        return {
            type: 'UPDATE-SELECTOR-ELEMENT-KEWORD',
            data: {
                selector: { tabs: tabs }
            }
        };
    }
    findNodeOptions (aws) {
        let state = STORE.state();
        let r = state.r.list;
        let options = state.options.ht;
        let out = [];

        if (!aws.code) return out;

        for (var i in r)
            if (r[i]['from-id']==aws._id && options[r[i]['to-id']])
                out.push(options[r[i]['to-id']]);

        return out;
    }
    findCommandSubcommands (command) {
        let state = STORE.state();
        let r = state.r.list;
        let subcommands = state.subcommands.ht;
        let out = [];

        if (!command.code) return out;

        for (var i in r)
            if (r[i]['from-id']==command._id && subcommands[r[i]['to-id']])
                out.push(subcommands[r[i]['to-id']]);

        return out;
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
        if (node_class=='OPTION')
            this.updateOptionDisplay(_id, value);
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

    updateOptionDisplay(_id, value) {
        let self = this;
        API.get('/options/' +_id + '/display/' + value, function (response) {
            STORE.dispatch(self.updatedOptionDisplay(response));
        });
    }
    updatedOptionDisplay(response) {
        let state = STORE.state();

        let child_node = response.NODE;
        let parent_node = response.RELASHONSHIP.NODE;
        let to_parent_edge = response.RELASHONSHIP.EDGE;

        GraphUtil.setObjectValues(child_node, state.options.ht[child_node._id]);

        // TODO: なんか変
        GraphUtil.setEdgeDisplay(state.r.ht[to_parent_edge._id],
                                 state.aws.ht[parent_node._id],
                                 state.options.ht[child_node._id]);

        GraphUtil.setEdgeDisplay(state.r.ht[to_parent_edge._id],
                                 state.subcommands.ht[parent_node._id],
                                 state.options.ht[child_node._id]);

        return {
            type: 'UPDATED-OPTION-DISPLAY',
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
                subcommands: state.subcommands
            }
        };
    }

    updateOptionLocation(_id, location) {
        let self = this;
        let data = {
            X: location.X,
            Y: location.Y,
            Z: location.Z
        };
        API.post('/options/' +_id + '/location', data ,
                 function (response) {
                     STORE.dispatch(self.updatedOptionLocation(response));
                 });
    }
    updatedOptionLocation(response) {
        let state = STORE.state();

        let new_option = response;
        let to_node = state.options.ht[new_option._id];

        GraphUtil.setObjectValues(new_option, to_node);

        return {
            type: 'UPDATED-OPTION-LOCATION',
            data: {
                options: state.options
            }
        };
    }
}
