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
                element: {code: null, _class: null},
                title: 'Selector',
                tabs: [
                    {code: 'elements', display: true, label: ''},
                    {code: 'options',  display: false, label: ''},
                    {code: 'basic',    display: false, label: ''}
                ]
            }
        };
        return this;
    }
}
