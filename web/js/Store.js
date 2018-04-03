class Store extends Simple_Redux_Store {
    constructor(reducer) {
        super(reducer, {});
    }
    initGraphfinders () {
        return {
            select: 'DEFAULT',
            list: []
        };
    }
    initGraphElements () {
        return { list: [], ht: {}};
    }
    initSelector () {
        return {
            display: false,
            element: {code: null, _class: null},
            title: 'Selector',
            tabs: [
                {code: 'commands',    select: true,  display: false, label: '', search: ''},
                {code: 'subcommands', select: false, display: false, label: '', search: ''},
                {code: 'options',     select: false, display: false, label: '', search: ''},
                {code: 'basic',       select: false, display: false, label: ''}
            ]
        };
    }
    init () {
        this._contents = {
            beach: {
                display: true,
                finders: this.initGraphfinders(),
                aws: null,
                commands: this.initGraphElements(),
                subcommands: this.initGraphElements(),
                options: this.initGraphElements(),
                r: this.initGraphElements(),
                selector: this.initSelector()
            },
            cosmos: {
                display: true,
                finders: this.initGraphfinders(),
                r: this.initGraphElements()
            },
            /* ********** *
             *    OLD
             * ********** */
            finders: this.initGraphfinders(),
            aws: null,
            commands: this.initGraphElements(),
            subcommands: this.initGraphElements(),
            options: this.initGraphElements(),
            r: this.initGraphElements(),
            selector: this.initSelector()
        };
        return this;
    }
}
