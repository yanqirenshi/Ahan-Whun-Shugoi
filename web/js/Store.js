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
                code: 'finder',
                type: 'group',
                icon: 'fas fa-binoculars',
                open: false,
                children: [
                    { code: 'add-finder',    type: 'item', icon: 'fas fa-plus' },
                    { code: 'update-finder', type: 'item', icon: 'fas fa-cog' },
                    { code: 'delete-finder', type: 'item', icon: 'fas fa-minus' },
                ]
            },
            {
                code: 'move',
                type: 'group',
                icon: 'fas fa-paper-plane',
                open: false,
                children: [
                    { code: 'move-to-beach',  type: 'item', icon: 'fab fa-servicestack' },
                    { code: 'move-to-cosmos', type: 'item', icon: 'fas fa-star' }
                ]
            },
            {
                code: 'account',
                type: 'group',
                icon: 'fas fa-user',
                open: false,
                children: [
                    { code: 'move-to-Setting',  type: 'item', icon: 'fas fa-cogs' },
                    { code: 'move-to-Sign Out', type: 'item', icon: 'fas fa-sign-out-alt' }
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
                display: false,
                finders: this.initGraphfinders(),
                r: this.initGraphElements()
            }
        };
        return this;
    }
}
