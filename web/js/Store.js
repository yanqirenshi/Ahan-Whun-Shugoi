class Store extends Simple_Redux_Store {
    constructor(reducer) {
        super(reducer, {});
    }
    init () {
        this._contents = {
            finders: {
                select: 'DEFAULT',
                list: []
            },
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
                    {code: 'commands',    select: true,  display: false, label: '', search: ''},
                    {code: 'subcommands', select: false, display: false, label: '', search: ''},
                    {code: 'options',     select: false, display: false, label: '', search: ''},
                    {code: 'basic',       select: false, display: false, label: ''}
                ]
            }
        };
        return this;
    }
}
