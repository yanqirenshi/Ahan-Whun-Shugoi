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
    initMenus () {
        return [
            {
                code: 'finder', type: 'group', icon: 'fas fa-binoculars',
                children: [
                    { code: 'add',    type: 'item', icon: 'fas fa-plus' },
                    { code: 'update', type: 'item', icon: 'fas fa-cog' },
                    { code: 'delete', type: 'item', icon: 'fas fa-minus' },
                ]
            },
            {
                code: 'move', type: 'group', icon: 'fas fa-paper-plane',
                children: [
                    { code: 'beach',  type: 'item', icon: 'fab fa-servicestack' },
                    { code: 'cosmos', type: 'item', icon: 'fas fa-star' }
                ]
            },
            {
                code: 'account', type: 'group', icon: 'fas fa-user',
                children: [
                    { code: 'Setting',  type: 'item', icon: 'fas fa-cogs' },
                    { code: 'Sign Out', type: 'item', icon: 'fas fa-sign-out-alt' }
                ]
            }
        ];
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
                selector: this.initSelector(),
                menus: this.initMenus()
            },
            cosmos: {
                display: true,
                finders: this.initGraphfinders(),
                r: this.initGraphElements()
            }
        };
        return this;
    }
}
