class Store extends Simple_Redux_Store {
    constructor(reducer) {
        super(reducer, {});
    }
    init () {
        this._contents = {
            aws: null,
            commands: { list: [], ht: {}},
            subcommands: { list: [], ht: {}},
            options: { list: [], ht: {}},
            r: { list: [], ht: {}},
            selector: {
                display: false,
                title: 'Selector'
            }
        };
        return this;
    }
}
