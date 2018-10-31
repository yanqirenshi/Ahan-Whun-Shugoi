class Store extends Vanilla_Redux_Store {
    constructor(reducer) {
        super(reducer, Immutable.Map({}));
    }
    makePageStage (data) {
        let val = (obj, key, default_val) => {
            if (!obj || !key || !obj[key]) return default_val;

            return obj[key];
        };

        return {
            code: data.code,
            menu_label: val(data, 'menu_label', '???'),
            active_section: val(data, 'active_section', 'root'),
            home_section: (data, 'home_section', 'root'),
            sections: data.sections,
            stye: (data, 'stye', {
                color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
            })
        };
    }
    makePages () {
        return [
            this.makePageStage({
                code: "beach", menu_label: '砂浜',
                sections: [
                    { code: 'root', tag: 'page_beach_root' },
                ]
            }),
            this.makePageStage({
                code: "help", menu_label: 'Help',
                sections: [
                    { code: 'root', tag: 'help_page_root' },
                ]
            }),
            this.makePageStage({
                code: "page02", menu_label: 'P2',
                sections: [
                    { code: 'root', tag: 'page02-sec_root' }
                ],
            }),
            this.makePageStage({
                code: "page03", menu_label: 'P3',
                sections: [
                    { code: 'root', tag: 'page03-sec_root' }
                ],
            })
        ];
    }
    init () {
        let data = {
            site: {
                active_page: 'beach',
                home_page: 'beach',
                pages: this.makePages()
            },
            beach: {
                aws:         { list: [], ht: {} },
                commands:    { list: [], ht: {} },
                subcommands: { list: [], ht: {} },
                options:     { list: [], ht: {} },
                r:           { list: [], ht: {} }
            }
        };

        for (var i in data.site.pages) {
            let page = data.site.pages[i];
            for (var k in page.sections) {
                let section = page.sections[k];
                let hash = '#' + page.code;

                if (section.code!='root')
                    hash += '/' + section.code;

                section.hash = hash;
            }
        }


        this._contents = Immutable.Map(data);
        return this;
    }
}
