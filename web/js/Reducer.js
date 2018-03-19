class Reducer extends Simple_Redux_Reducer {
    isMergeActionTypes (action_type) {
        return [
            'MOVE-PAGE',
            'FETCHED-SUBCOMMAND',
            'FETCHED-COMMAND',
            'FETCHED-AWS',
            'FETCHED-OPTION',
            'FETCHED-AWS_OPTIONS',
            'FETCHED-COMMAND_SUBCOMMANDS',
            'SWITCH-SELECTOR'
        ].find(function (v) {
            return v==action_type;
        }) ;
    }
    put (state, action) {
        return this.isMergeActionTypes(action.type) ?
            this.merge(state, action.data) : state;
    }
}
