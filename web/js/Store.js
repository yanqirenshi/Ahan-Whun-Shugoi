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
                    {code: 'commands',    select: true,  display: false, label: '', search: null},
                    {code: 'subcommands', select: false, display: false, label: '', search: null},
                    {code: 'options',     select: false, display: false, label: '', search: null},
                    {code: 'basic',       select: false, display: false, label: ''}
                ]
            }
        };
        return this;
    }
}
