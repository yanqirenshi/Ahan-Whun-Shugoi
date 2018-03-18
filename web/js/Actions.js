class Actions extends Simple_Redux_Actions {
    movePage (data) {
        return {
            type: 'MOVE-PAGE',
            data: data
        };
    }

    fetchAws () {
        let self = this;
        API.get('/vertex/aws', function (response) {
            STORE.dispatch(self.fetchedAws(response));
        });
    }
    fetchedAws (response) {
        return {
            type: 'FETCHED-AWS',
            data: {
                aws: response
            }
        };
    }

    fetchCommand (_id) {
        let self = this;
        API.get('/vertex/commands/' + _id, function (response) {
            STORE.dispatch(self.fetchedCommand(response));
        });
    }
    fetchedCommand (response) {
        let new_commands = STORE.state().commands.concat();
        new_commands.push(response);
        return {
            type: 'FETCHED-COMMAND',
            data: {
                commands: new_commands
            }
        };
    }

    fetchSubcommand (_id) {
        let self = this;
        API.get('/vertex/subcommands/' + _id, function (response) {
            STORE.dispatch(self.fetchedSubcommand(response));
        });
    }
    fetchedSubcommand (response) {
        let new_subcommands = STORE.state().subcommands.concat();
        new_subcommands.push(response);
        return {
            type: 'FETCHED-SUBCOMMAND',
            data: {
                subcommands: new_subcommands
            }
        };
    }

    fetchOption (_id) {
        let self = this;
        API.get('/vertex/options/' + _id, function (response) {
            STORE.dispatch(self.fetchedOption(response));
        });
    }
    fetchedOption (response) {
        let new_options = STORE.state().options.concat();
        new_options.push(response);
        return {
            type: 'FETCHED-OPTION',
            data: {
                options: new_options
            }
        };
    }

    fetchAws_options (aws) {
        let self = this;
        API.get('/aws/options', function (response) {
            // STORE.dispatch(self.fetchedAws_options(response));
        });
    }
    fetchedAws_options (response) {
        return {
            type: 'FETCHED-AWS_OPTIONS',
            data: {
                options: GraphUtil.marge(STORE.state().options, response.NODES),
                r: GraphUtil.marge(STORE.state().r, response.RELATIONSHIPS)
            }
        };
    }
    fetchAws_commands (aws) {
        let self = this;
        API.get('/aws/commands', function (response) {
            STORE.dispatch(self.fetchedAws_commands(response, aws));
        });
    }
    fetchedAws_commands (response, aws) {
        return {
            type: 'FETCHED-AWS_OPTIONS',
            data: {
                commands: GraphUtil.marge(STORE.state().commands,
                                          GraphUtil.initCommans(aws, response.NODES)),
                r: GraphUtil.marge(STORE.state().r, response.RELATIONSHIPS)
            }
        };
    }
    fetchCommand_subcommands (command) {
        let self = this;
        API.get('/commands/' + command._id + '/subcommands', function (response) {
            STORE.dispatch(self.fetchedCommand_subcommands(response, command));
        });
    }
    fetchedCommand_subcommands (response, command) {
        return {
            type: 'FETCHED-COMMAND_SUBCOMMANDS',
            data: {
                subcommands: GraphUtil.marge(STORE.state().subcommands,
                                             GraphUtil.initSubcommands(command, response.NODES)),
                r: GraphUtil.marge(STORE.state().r, response.RELATIONSHIPS)
            }
        };
    }
    fetchSubcommand_options (subcommand_id) {}
    fetchedSubcommand_options (response) {}
}
