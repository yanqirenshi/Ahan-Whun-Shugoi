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
                        code: "home",
                        menu_label: '家',
                        active_section: 'root', home_section: 'root',
                        sections: [
                            { code: 'root', tag: 'home_page_root', title: 'Section: root', description: '' },
                        ],
                        stye: {
                            color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                        }
                    },
                    {
                        code: "aws",
                        menu_label: 'AWS',
                        active_section: 'root', home_section: 'root',
                        sections: [{ code: 'root', tag: 'aws_page_root', title: 'Home', description: '' }],
                        stye: {
                            color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                        }
                    },
                    {
                        code: "cmd",
                        menu_label: 'Cmd',
                        active_section: 'root', home_section: 'root',
                        sections: [{ code: 'root', tag: 'cmd_page_root', title: 'Home', description: '' }],
                        stye: {
                            color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                        }
                    },
                    {
                        code: "beach",
                        menu_label: '砂浜',
                        active_section: 'root', home_section: 'root',
                        sections: [{ code: 'root', tag: 'beach_page_root', title: 'Home', description: '' }],
                        stye: {
                            color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                        }
                    },
                    {
                        code: "api",
                        menu_label: 'Api',
                        active_section: 'root', home_section: 'root',
                        sections: [{ code: 'root', tag: 'api_page_root', title: 'Home', description: '' }],
                        stye: {
                            color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                        }
                    },
                    {
                        code: "web",
                        menu_label: 'Web',
                        active_section: 'root', home_section: 'root',
                        sections: [{ code: 'root', tag: 'web_page_root', title: 'Home', description: '' }],
                        stye: {
                            color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                        }
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
