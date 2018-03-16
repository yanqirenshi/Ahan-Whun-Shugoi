class Store extends Simple_Redux_Store {
    constructor(reducer) {
        super(reducer, {});
    }
    init () {
        this._contents = {
            aws: null,
            commands: [],
            subcommands: [],
            options: [],
            r: []
        };
        return this;
    }
}
