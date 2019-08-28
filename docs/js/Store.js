class Store extends Vanilla_Redux_Store {
    constructor(reducer) {
        super(reducer, Immutable.Map({}));
    }
    init () {
        let data = {
            site: {
                active_page: 'home',
                home_page: 'home',
                pages: [
                    {
                        menu_label: '家',
                        code: "home",
                        tag: 'page-home_root',
                    },
                    {
                        menu_label: '使',
                        code: "usage",
                        tag: 'page-usage',
                    },
                    {
                        menu_label: 'AWS',
                        code: "aws",
                        tag: 'page-aws',
                    },
                    {
                        menu_label: 'Cmd',
                        code: "cmd",
                        tag: 'page-cmd',
                        children: [],
                    },
                    {
                        menu_label: '砂浜',
                        code: "beach",
                        tag: 'page-beach',
                    },
                    {
                        menu_label: 'Api',
                        code: "api",
                        tag: 'api_page_root',
                    },
                    {
                        menu_label: 'Web',
                        code: "web",
                        tag: 'page-web',
                    },
                ]
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
