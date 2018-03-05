class Reducer extends Simple_Redux_Reducer {
    isMergeActionTypes (action_type) {
        return ['MOVE-PAGE'].find(function (v) {
                    return v==action_type;
                }) ;
    }
    put (state, action) {
        return this.isMergeActionTypes(action.type) ?
            this.merge(state, action.data) : state;
    }
}
