riot.tag2('api', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('api_page_root', '<section-header title="API"></section-header> <section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Operators</h1> <h2 class="subtitle"></h2> <div class="contents"> <table class="table"> <thead> <tr> <th>Method</th> <th>Path</th> <th>Description</th> </tr> </thead> <tbody> <tr each="{apis}"> <td>{method.toUpperCase()}</td> <td>{path.toLowerCase()}</td> <td>{description}</td> </tr> </tbody> </table> </div> </div> </section> <section-footer></section-footer>', '', '', function(opts) {
     this.apis = [

         { method: 'get',  path: '/vertex/aws',                      description: 'AWSを取得します。' },
         { method: 'get',  path: '/vertex/commands',                 description: 'コマンドを全て取得します。' },
         { method: 'get',  path: '/vertex/commands/:_id',            description: 'コマンドを取得します。IDで指定したコマンドを取得します。' },
         { method: 'get',  path: '/vertex/subcommands',              description: 'サブコマンドを全て取得します。' },
         { method: 'get',  path: '/vertex/subcommands/:_id',         description: 'サブコマンドを取得します。IDで指定したサブコマンドを取得します。' },
         { method: 'get',  path: '/vertex/options/:_id',             description: 'コマンドの一覧を取得します。' },

         { method: 'get',  path: '/aws',                             description: 'AWSを取得します。' },
         { method: 'get',  path: '/aws/options',                     description: 'AWSのオプションを全て取得します。' },
         { method: 'get',  path: '/aws/commands',                    description: 'AWSのコマンドを全て取得します。 GET /vertex/commands と被っていますね。。' },
         { method: 'get',  path: '/commands/:_id/subcommands',       description: '' },
         { method: 'get',  path: '/commands/:_id/display/:value',    description: '' },
         { method: 'post', path: '/commands/:_id/location',          description: '' },
         { method: 'get',  path: '/subcommands/:_id/options',        description: '' },
         { method: 'get',  path: '/subcommands/:_id/display/:value', description: '' },
         { method: 'post', path: '/subcommands/:_id/location',       description: '' },
         { method: 'get',  path: '/options/:_id/display/:value',     description: '' },
         { method: 'post', path: '/options/:_id/location',           description: '' },

         { method: 'get',  path: '/finders',                         description: '登録されている Finder を全て返します。' },
         { method: 'post', path: '/finders/:code/look-at',           description: 'Finder の位置を保管します。' },
         { method: 'post', path: '/finders/:code/scale',             description: 'Finder の拡大設定を保管します。' },
     ];
});

riot.tag2('app-page-area', '', '', '', function(opts) {
     this.draw = () => {
         if (this.opts.route)
             ROUTER.draw(this, STORE.get('site.pages'), this.opts.route);
     }
     this.on('mount', () => {
         this.draw();
     });
     this.on('update', () => {
         this.draw();
     });
});

riot.tag2('app', '<menu-bar brand="{{label:\'RT\'}}" site="{site()}" moves="{[]}"></menu-bar> <app-page-area></app-page-area> <div ref="page-area"></div>', '', '', function(opts) {
     this.site = () => {
         return STORE.state().get('site');
     };
     this.impure = () => {
         return STORE.get('purging.impure');
     }
     this.updateMenuBar = () => {
         if (this.tags['menu-bar'])
             this.tags['menu-bar'].update();
     }

     STORE.subscribe((action)=>{
         if (action.type=='MOVE-PAGE') {
             this.updateMenuBar();

             this.tags['app-page-area'].update({ opts: { route: action.route }});
         }

         if (action.type=='FETCHED-IMPURE-PURGING')
             this.tags['popup-working-action'].update();
     })

     window.addEventListener('resize', (event) => {
         this.update();
     });

     this.on('mount', () => {
         let hash = location.hash.split('/');
         hash[0] = hash[0].substring(1)

         ACTIONS.movePage({ route: hash });
     });
});

riot.tag2('page-aws', '<section-header title="Aws"></section-header> <section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> <p>これ何やったっけ。。。。</p> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Usage</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Operators</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section-footer></section-footer>', '', '', function(opts) {
});

riot.tag2('page-beach', '<section-header title="Beach"></section-header> <page-tabs tabs="{tabs}" active_tag="{active_tag}" click-tab="{clickTab}"></page-tabs> <div> <page-beach_readme class="hide"></page-beach_readme> <page-beach_functions class="hide"></page-beach_functions> <page-beach_datamodels class="hide"></page-beach_datamodels> <page-beach_operators class="hide"></page-beach_operators> <page-beach_classes class="hide"></page-beach_classes> </div> <section-footer></section-footer>', '', '', function(opts) {
     this.default_tag = 'readme';
     this.active_tag = null;
     this.tabs = [
         { code: 'readme',     label: 'README',      tag: 'page-beach_readme' },
         { code: 'functions',  label: 'Functions',   tag: 'page-beach_functions' },
         { code: 'datamodels', label: 'Data Models', tag: 'page-beach_datamodels' },
         { code: 'classes',    label: 'Classes',     tag: 'page-beach_classes' },
         { code: 'operators',  label: 'Operators',   tag: 'page-beach_operators' },
     ];
     this.clickTab = (e) => {
         this.switchTab(e.target.getAttribute('code'));
     };
     this.on('mount', () => {
         this.switchTab(this.default_tag);
     });
     this.switchTab = (code) => {
         if (this.active_tag == code) return;

         this.active_tag = code;

         let tag = null;
         for (var i in this.tabs) {
             let tab = this.tabs[i];
             this.tags[tab.tag].root.classList.add('hide');
             if (tab.code==code)
                 tag = tab.tag;
         }

         this.tags[tag].root.classList.remove('hide');

         this.update();
     };
});

riot.tag2('page-beach_classes', '<section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">グラフ構造</h1> <h2 class="subtitle"></h2> <div class="contents"> </div> <section class="section"> <div class="container"> <h1 class="title is-4">コマンド</h1> <h2 class="subtitle"></h2> <div class="contents"> <p><pre>\n   aws -----(1)-----> Command -----(2)-----> subcommand\n             :                      :\n             :                      :\n             :                      +- - - - - -> r-command2subcommands\n             :\n             +- - - - - -> r-aws2commands</pre></p> <table class="table" style="margin-top: 11px;"> <thead></thead> <tbody></tbody> </table> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-4">コマンド・オプション</h1> <h2 class="subtitle"></h2> <div class="contents"> <p><pre>\n        aws -----(1)-----> option\n                  :\n                  +- - - - - -> r-aws2options\n\n subcommand -----(1)-----> option\n                  :\n                  +- - - - - -> r-subcommand2options</pre></p> <table class="table" style="margin-top: 11px;"> <thead></thead> <tbody></tbody> </table> </div> </div> </section> </div> </section> <section class="section"> <div class="container"> <h1 class="title">クラス図</h1> <h2 class="subtitle"></h2> <div class="contents"> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">クラス一覧</h1> <h2 class="subtitle"></h2> <div class="contents"> <class-list classes="{classes}"> </div> </div> </section>', '', '', function(opts) {
     this.classes = [
         { name:'node',                  description: 'Vertex のルートクラス',                     precedences: 'SHINRABANSHOU:SHIN' },
         { name:'sand',                  description: 'AWSからインポートするデータのルートクラス', precedences: 'node' },
         { name:'aws',                   description: '',                                          precedences: 'sand' },
         { name:'option',                description: '',                                          precedences: 'sand' },
         { name:'command',               description: '',                                          precedences: 'sand' },
         { name:'subcommand',            description: '',                                          precedences: 'sand' },
         { name:'r-aws2commands',        description: '',                                          precedences: 'SHINRABANSHOU:RA' },
         { name:'r-aws2options',         description: '',                                          precedences: 'SHINRABANSHOU:RA' },
         { name:'r-command2subcommands', description: '',                                          precedences: 'SHINRABANSHOU:RA' },
         { name:'r-subcommand2options',  description: '',                                          precedences: 'SHINRABANSHOU:RA' },
         { name:'finder',                description: '',                                          precedences: 'SHINRABANSHOU:SHIN' },
     ];
});

riot.tag2('page-beach_datamodels', '<section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">グラフ構造</h1> <h2 class="subtitle"></h2> <div class="contents"> </div> <section class="section"> <div class="container"> <h1 class="title is-4">コマンド</h1> <h2 class="subtitle"></h2> <div class="contents"> <p><pre>\n   AWS -------:r--------> COMMAND -----:r------> SUBCOMMAND\n (unique)    (1:n)                    (1:n)</pre></p> <table class="table" style="margin-top: 11px;"> <thead> <tr><th>Name</th> <th>Description</th></tr> </thead> <tbody> <tr><th>AWS</th> <td></td></tr> <tr><th>COMMAND</th> <td></td></tr> <tr><th>SUBCOMMAND</th> <td></td></tr> </tbody> </table> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-4">コマンド・オプション</h1> <h2 class="subtitle"></h2> <div class="contents"> <p><pre>\n        AWS -----:r------> OPTION\n                (1:n)\n\n SUBCOMMAND -----:r------> OPTION\n                (1:n)</pre></p> <table class="table" style="margin-top: 11px;"> <thead> <tr><th>Name</th> <th>Description</th></tr> </thead> <tbody> <tr><th>OPTION</th> <td></td></tr> </tbody> </table> </div> </div> </section> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-beach_functions', '<section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> <p>以下のようなことができます。</p> <p>(1) AWS Cli のマニュアルからインポートする。</p> <p>(2) インポートしたものにアクセスする。</p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-beach_operators', '<section class="section"> <div class="container"> <h1 class="title">Operators</h1> <h2 class="subtitle"></h2> <div class="contents"> <operator-list operators="{operators.important}"></operator-list> </div> </div> </section>', '', '', function(opts) {
     this.operators = {
         important: [
             { name: 'collect',                  description: '', type: '???', package: '' },
         ],
         aws: [
             { name: 'get-aws',                  description: '', type: '???', package: '' },
         ],
         command: [
             { name: 'find-commands',            description: '', type: '???', package: '' },
             { name: 'get-command',              description: '', type: '???', package: '' },
         ],
         subcommand: [
             { name: 'get-command-subcommand',   description: '', type: '???', package: '' },
             { name: 'find-command-subcommands', description: '', type: '???', package: '' },
             { name: 'find-subcommand-options',  description: '', type: '???', package: '' },
             { name: 'get-subcommand',           description: '', type: '???', package: '' },
         ],
         options: [
             { name: 'find-aws-options',         description: '', type: '???', package: '' },
             { name: 'options-values',           description: '', type: '???', package: '' },
         ],
         edges: [
             { name: 'r-aws2commands',           description: '', type: '???', package: '' },
             { name: 'r-aws2options',            description: '', type: '???', package: '' },
             { name: 'r-command2subcommands',    description: '', type: '???', package: '' },
             { name: 'r-subcommand2options',     description: '', type: '???', package: '' },
         ],
         others: [
             { name: 'command',                  description: '', type: '???', package: '' },
             { name: 'display',                  description: '', type: '???', package: '' },
             { name: 'find-finder',              description: '', type: '???', package: '' },
             { name: 'get-finder',               description: '', type: '???', package: '' },
             { name: 'lock-p',                   description: '', type: '???', package: '' },
         ]
     };
});

riot.tag2('page-beach_readme', '<section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> <p>Under the paving stone the beach というスローガン(?)がパッケージ名の由来です。</p> <p>AWS Cli のWEB上のマニュアルを全て読み込んでローカルDBに保管します。</p> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Usage</h1> <h2 class="subtitle"></h2> <div class="contents"> <p><pre>\n(collect :refresh t :thread t)</pre> </p> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Others</h1> <h2 class="subtitle"></h2> <section class="section"> <div class="container"> <h1 class="title is-4">collect が上手くいかない AWSコマンド</h1> <h2 class="subtitle"></h2> <div class="contents"> <p>2018-10-03 (Wed) ですが、 AWS のマニュアルに問題があり、正常にインポート出来ないマニュアルがあります。</p> <p>これらのコマンドは、オプションが正しく取得できていません。</p> <p><pre>\nWARNING: 0  = 8  ⇒ NIL : CREATE-SUBSCRIPTION\nWARNING: 0  = 8  ⇒ NIL : UPDATE-SUBSCRIPTION\nWARNING: 0  = 1  ⇒ NIL : GET\nWARNING: 0  = 2  ⇒ NIL : SET\nWARNING: 32 = 34 ⇒ NIL : CREATE-CLUSTER</pre> </p> </div> </div> </section> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-cmd', '<section-header title="Command"></section-header> <section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Usage</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Operators</h1> <h2 class="subtitle"></h2> <div class="contents"> <operator-list operators="{operators}"></operator-list> </div> </div> </section> <section-footer></section-footer>', '', '', function(opts) {
     this.operators = [
         { name: 'aws',                    description: '', type: '???', package: '' },
         { name: 'start',                  description: '', type: '???', package: '' },
         { name: 'stop',                   description: '', type: '???', package: '' },
         { name: 'graph-data-stor',        description: '', type: '???', package: '' },
         { name: 'name',                   description: '', type: '???', package: '' },
         { name: '*print-command-stream*', description: '', type: '???', package: '' },
     ];
});

riot.tag2('menu-bar', '<aside class="menu"> <p ref="brand" class="menu-label" onclick="{clickBrand}"> {opts.brand.label} </p> <ul class="menu-list"> <li each="{opts.site.pages}"> <a class="{opts.site.active_page==code ? \'is-active\' : \'\'}" href="{\'#\' + code}"> {menu_label} </a> </li> </ul> </aside> <div class="move-page-menu hide" ref="move-panel"> <p each="{moves()}"> <a href="{href}">{label}</a> </p> </div>', 'menu-bar .move-page-menu { z-index: 666665; background: #ffffff; position: fixed; left: 55px; top: 0px; min-width: 111px; height: 100vh; box-shadow: 2px 0px 8px 0px #e0e0e0; padding: 22px 55px 22px 22px; } menu-bar .move-page-menu.hide { display: none; } menu-bar .move-page-menu > p { margin-bottom: 11px; } menu-bar > .menu { z-index: 666666; height: 100vh; width: 55px; padding: 11px 0px 11px 11px; position: fixed; left: 0px; top: 0px; background: #FF9901; } menu-bar .menu-label, menu-bar .menu-list a { padding: 0; width: 33px; height: 33px; text-align: center; margin-top: 8px; border-radius: 3px; background: none; color: #ffffff; font-weight: bold; padding-top: 7px; font-size: 14px; } menu-bar .menu-label,[data-is="menu-bar"] .menu-label{ background: #FF9901; color: #23303E; } menu-bar .menu-label.open,[data-is="menu-bar"] .menu-label.open{ background: #ffffff; color: #23303E; width: 44px; border-radius: 3px 0px 0px 3px; text-shadow: 0px 0px 1px #eee; padding-right: 11px; } menu-bar .menu-list a.is-active { width: 33px; border-radius: 3px; background: #ffffff; color: #333333; }', '', function(opts) {
     this.moves = () => {
         let moves = [
         ]
         return moves.filter((d)=>{
             return d.code != this.opts.current;
         });
     };

     this.brandStatus = (status) => {
         let brand = this.refs['brand'];
         let classes = brand.getAttribute('class').trim().split(' ');

         if (status=='open') {
             if (classes.find((d)=>{ return d!='open'; }))
                 classes.push('open')
         } else {
             if (classes.find((d)=>{ return d=='open'; }))
                 classes = classes.filter((d)=>{ return d!='open'; });
         }
         brand.setAttribute('class', classes.join(' '));
     }

     this.clickBrand = () => {
         let panel = this.refs['move-panel'];
         let classes = panel.getAttribute('class').trim().split(' ');

         if (classes.find((d)=>{ return d=='hide'; })) {
             classes = classes.filter((d)=>{ return d!='hide'; });
             this.brandStatus('open');
         } else {
             classes.push('hide');
             this.brandStatus('close');
         }
         panel.setAttribute('class', classes.join(' '));
     };
});

riot.tag2('section-breadcrumb', '<section-container data="{path()}"> <nav class="breadcrumb" aria-label="breadcrumbs"> <ul> <li each="{opts.data}"> <a class="{active ? \'is-active\' : \'\'}" href="{href}" aria-current="page">{label}</a> </li> </ul> </nav> </section-container>', 'section-breadcrumb section-container > .section,[data-is="section-breadcrumb"] section-container > .section{ padding-top: 3px; }', '', function(opts) {
     this.path = () => {
         let hash = location.hash;
         let path = hash.split('/');

         if (path[0] && path[0].substr(0,1)=='#')
             path[0] = path[0].substr(1);

         let out = [];
         let len = path.length;
         let href = null;
         for (var i in path) {
             href = href ? href + '/' + path[i] : '#' + path[i];

             if (i==len-1)
                 out.push({
                     label: path[i],
                     href: hash,
                     active: true
                 });

             else
                 out.push({
                     label: path[i],
                     href: href,
                     active: false
                 });
         }
         return out;
     }
});

riot.tag2('section-container', '<section class="section"> <div class="container"> <h1 class="title is-{opts.no ? opts.no : 3}"> {opts.title} </h1> <h2 class="subtitle">{opts.subtitle}</h2> <yield></yield> </div> </section>', '', '', function(opts) {
});

riot.tag2('section-contents', '<section class="section"> <div class="container"> <h1 class="title is-{opts.no ? opts.no : 3}"> {opts.title} </h1> <h2 class="subtitle">{opts.subtitle}</h2> <div class="contents"> <yield></yield> </div> </div> </section>', 'section-contents > section.section { padding: 0.0rem 1.5rem 2.0rem 1.5rem; }', '', function(opts) {
});

riot.tag2('section-footer', '<footer class="footer"> <div class="container"> <div class="content has-text-centered"> <p> </p> </div> </div> </footer>', 'section-footer > .footer { padding-top: 13px; padding-bottom: 13px; margin-bottom: 33px; height: 66px; background: #23303E; color: #ffffff; }', '', function(opts) {
});

riot.tag2('section-header-with-breadcrumb', '<section-header title="{opts.title}"></section-header> <section-breadcrumb></section-breadcrumb>', 'section-header-with-breadcrumb section-header > .section,[data-is="section-header-with-breadcrumb"] section-header > .section{ margin-bottom: 3px; }', '', function(opts) {
});

riot.tag2('section-header', '<section class="section"> <div class="container"> <h1 class="title is-{opts.no ? opts.no : 2}"> {opts.title} </h1> <h2 class="subtitle">{opts.subtitle}</h2> <yield></yield> </div> </section>', 'section-header > .section { background: #23303E; margin-bottom: 33px; } section-header .title, section-header .subtitle { color: #ffffff; }', '', function(opts) {
});

riot.tag2('section-list', '<table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <tr> <th>機能</th> <th>概要</th> </tr> </thead> <tbody> <tr each="{data()}"> <td><a href="{hash}">{title}</a></td> <td>{description}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.data = () => {
         return opts.data.filter((d) => {
             if (d.code=='root') return false;

             let len = d.code.length;
             let suffix = d.code.substr(len-5);
             if (suffix=='_root' || suffix=='-root')
                 return false;

             return true;
         });
     };
});

riot.tag2('class-list', '<table class="table"> <thead> <tr> <th>Name</th> <th>Description</th> <th>Parent</th> </tr> </thead> <tbody> <tr each="{opts.classes}"> <td>{name}</td> <td>{description}</td> <td>{precedences}</td> </tr> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('operator-list', '<table class="table"> <thead> <tr> <th>Name</th> <th>Type</th> <th>Description</th> <th>Package</th> </tr> </thead> <tbody> <tr each="{opts.operators}"> <td>{name}</td> <td>{type}</td> <td>{description}</td> <td>{package}</td> </tr> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('page-tabs', '<section class="section" style="padding-top: 0px; padding-bottom: 33px;"> <div class="container"> <div class="tabs"> <ul> <li each="{opts.tabs}" class="{opts.active_tag==code ? \'is-active\' : \'\'}"> <a code="{code}" onclick="{opts.clickTab}">{label}</a> </li> </ul> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('pakage-list', '<table class="table"> <thead> <tr><th>Name</th><th>Description</th></tr> </thead> <tbody> <tr each="{opts.packages}"> <th>{name}</th> <td>{description}</td> </tr> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('sections-list', '<table class="table"> <tbody> <tr each="{opts.data}"> <td><a href="{hash}">{title}</a></td> </tr> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('home_functions', '<section class="section"> <div class="container"> <h1 class="title">Functions</h1> <div class="contents"> <p>以下のような事ができます。</p> </div> <section class="section" style="padding-top: 11px; padding-bottom: 0px;"> <div class="container"> <h1 class="title is-4">1. AWS Cli マニュアルのインポート</h1> <div class="contents" style="padding-left: 33px;"> <p>collect コマンドでWEB上にあるマニュアルをインポートできます。</p> <p>実行を禁止できます。</p> </div> </div> </section> <section class="section" style="padding-top: 11px; padding-bottom: 0px;"> <div class="container"> <h1 class="title is-4">2. AWS Cli のコマンドのWEBビューアー</h1> <div class="contents" style="padding-left: 33px;"> <p>インポートしたマニュアルのをWEBブラウザで照会できます。</p> </div> </div> </section> <section class="section" style="padding-top: 11px; padding-bottom: 0px;"> <div class="container"> <h1 class="title is-4">3. AWS Cli のコマンド実行</h1> <div class="contents" style="padding-left: 33px;"> <p>Common Lisp から AWS Cli を実行できます。</p> <p>インポートしたマニュアルで実行パラメータの型チェックができます。</p> <p>インポートしたマニュアルで実行制限ができます。</p> </div> </div> </section> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_installation', '<section class="section"> <div class="container"> <div class="contents"> <h1 class="title">Installation</h1> <p><pre>\n(ql:quickload :ahan-whun-shugoi-beach)\n(ql:quickload :ahan-whun-shugoi)\n(ql:quickload :ahan-whun-shugoi-api)</pre> </p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-home_operators', '<section class="section" style="padding-top: 0px; padding-bottom: 0px;"> <div class="container"> <div class="contents"> <p>鋭意執筆中</p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-home_others', '<section class="section" style="padding-top: 0px; padding-bottom: 0px;"> <div class="container"> <div class="contents"> <p>鋭意執筆中</p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-home_packages', '<section class="section" style="padding-top: 0px; padding-bottom: 0px;"> <div class="container"> <div class="contents"> <p>構成するパッケージについて説明します。</p> </div> </div> </section> <page-home_packages_important packages="{packages}"></page-home_packages_important> <page-home_packages_cli packages="{packages}"></page-home_packages_cli> <page-home_packages_beach packages="{packages}"></page-home_packages_beach> <page-home_packages_api packages="{packages}"></page-home_packages_api>', '', '', function(opts) {
     this.packages = {
         important: [
             { name: 'ahan-whun-shugoi',       description: '' },
             { name: 'ahan-whun-shugoi.cli',   description: '未実装。現在は ahan-whun-shugoi に含まれる。' },
             { name: 'ahan-whun-shugoi.api',   description: '' },
             { name: 'ahan-whun-shugoi.beach', description: '' },
             { name: 'ahan-whun-shugoi.help',  description: '' },
         ],
         cli: [
             { name: 'ahan-whun-shugoi.cli.option', description: '' },
             { name: 'ahan-whun-shugoi.cli.command', description: '' },
             { name: 'ahan-whun-shugoi.cli.config', description: '' },
         ],
         api: [
             { name: 'ahan-whun-shugoi-api-test', description: '' },
             { name: 'ahan-whun-shugoi-api.cosmos', description: '' },
             { name: 'ahan-whun-shugoi-api.app', description: '' },
             { name: 'ahan-whun-shugoi-api.render', description: '' },
             { name: 'ahan-whun-shugoi-api.controller', description: '' },
             { name: 'ahan-whun-shugoi-api.config', description: '' },
             { name: 'ahan-whun-shugoi-api.cosmos', description: '' },
             { name: 'ahan-whun-shugoi-api.router', description: '' },
             { name: 'ahan-whun-shugoi-api.api-v1', description: '' },
             { name: 'ahan-whun-shugoi-api.beach', description: '' },
         ],
         beach: [
             { name: 'ahan-whun-shugoi-beach-test', description: '' },
             { name: 'ahan-whun-shugoi-beach.db', description: '' },
             { name: 'ahan-whun-shugoi-beach.util.html', description: '' },
             { name: 'ahan-whun-shugoi-beach.util.uri', description: '' },
             { name: 'ahan-whun-shugoi-beach.util', description: '' },
             { name: 'ahan-whun-shugoi-beach.util.lock', description: '' },
         ],
     }
});

riot.tag2('page-home_packages_api', '<section class="section"> <div class="container"> <h1 class="title">List</h1> <h2 class="subtitle"></h2> <div class="contents"> <pakage-list packages="{opts.packages.api}"></pakage-list> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-home_packages_beach', '<section class="section"> <div class="container"> <h1 class="title">List</h1> <h2 class="subtitle"></h2> <div class="contents"> <pakage-list packages="{opts.packages.beach}"></pakage-list> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-home_packages_cli', '<section class="section"> <div class="container"> <h1 class="title">List</h1> <h2 class="subtitle"></h2> <div class="contents"> <pakage-list packages="{opts.packages.cli}"></pakage-list> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-home_packages_important', '<section class="section"> <div class="container"> <h1 class="title">List</h1> <h2 class="subtitle"></h2> <div class="contents"> <pakage-list packages="{opts.packages.important}"></pakage-list> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-home_readme', '<section class="section" style="padding-top: 0px; padding-bottom: 0px;"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle">AWS Cli ラッパー、 マニュアルを添えて。</h2> <div class="contents"> <p>AWS Cli を Common Lisp 上から、なるだけ安全に実行するためのライブラリです。</p> <p>コマンドでのパラメータの値の型チェック、実行制限が出来ます。</p> </div> </section> <home_functions></home_functions> <home_installation></home_installation> <section class="section"> <div class="container"> <div class="contents"> <h1 class="title">Author</h1> <p>Satoshi Iwasaki (yanqirenshi@gmail.com)</p> </div> </div> </section> <section class="section"> <div class="container"> <div class="contents"> <h1 class="title">Copyright</h1> <p>Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)</p> </div> </div> </section> <section class="section"> <div class="container"> <div class="contents"> <h1 class="title">License</h1> <p>Licensed under the MIT License.</p> </div> </div> </section> <section-footer></section-footer>', '', '', function(opts) {
});

riot.tag2('page-home_root', '<section-header title="AHAN-WHUN-SHUGOI" subtitle="AWS Cli wrapper with Manuals"></section-header> <page-tabs tabs="{tabs}" active_tag="{active_tag}" click-tab="{clickTab}"></page-tabs> <div> <page-home_readme class="hide"></page-home_readme> <page-home_packages class="hide"></page-home_packages> <page-home_operators class="hide"></page-home_operators> <page-home_others class="hide"></page-home_others> </div>', '', '', function(opts) {
     this.default_tag = 'readme';
     this.active_tag = null;
     this.tabs = [
         { code: 'readme',    label: 'README',    tag: 'page-home_readme' },
         { code: 'packages',  label: 'Packages',  tag: 'page-home_packages' },
         { code: 'operators', label: 'Operators', tag: 'page-home_operators' },
         { code: 'others',    label: 'Others',    tag: 'page-home_others' },
     ];
     this.clickTab = (e) => {
         this.switchTab(e.target.getAttribute('code'));
     };
     this.on('mount', () => {
         this.switchTab(this.default_tag);
     });
     this.switchTab = (code) => {
         if (this.active_tag == code) return;

         this.active_tag = code;

         let tag = null;
         for (var i in this.tabs) {
             let tab = this.tabs[i];
             this.tags[tab.tag].root.classList.add('hide');
             if (tab.code==code)
                 tag = tab.tag;
         }

         this.tags[tag].root.classList.remove('hide');

         this.update();
     };
});

riot.tag2('function-001', '<section-header title="Function: AWS" subtitle=""></section-header>', '', '', function(opts) {
});

riot.tag2('function-001', '', '', '', function(opts) {
});

riot.tag2('page-usage', '<section-header title="Usage" subtitle=""></section-header> <page-tabs tabs="{tabs}" active_tag="{active_tag}" click-tab="{clickTab}"></page-tabs> <div> <page-usage_readme class="hide"></page-usage_readme> <page-usage_setting-lisp class="hide"></page-usage_setting-lisp> <page-usage_import-manual class="hide"></page-usage_import-manual> </div> <section-footer></section-footer>', '', '', function(opts) {
     this.default_tag = 'readme';
     this.active_tag = null;
     this.tabs = [
         { code: 'readme',        label: 'README',        tag: 'page-usage_readme' },
         { code: 'setting-lisp',  label: 'Setting Lisp',  tag: 'page-usage_setting-lisp' },
         { code: 'import-manual', label: 'Import Manual', tag: 'page-usage_import-manual' },
     ];
     this.clickTab = (e) => {
         this.switchTab(e.target.getAttribute('code'));
     };
     this.on('mount', () => {
         this.switchTab(this.default_tag);
     });
     this.switchTab = (code) => {
         if (this.active_tag == code) return;

         this.active_tag = code;

         let tag = null;
         for (var i in this.tabs) {
             let tab = this.tabs[i];
             this.tags[tab.tag].root.classList.add('hide');
             if (tab.code==code)
                 tag = tab.tag;
         }

         this.tags[tag].root.classList.remove('hide');

         this.update();
     };
});

riot.tag2('page-usage_import-manual', '<section class="section"> <div class="container"> <div class="contents"> <h1 class="title"></h1> <div class="contents"> <p> <pre>\n(aws:collect :refresh t :thread t)\n\n    or\n\n(shugoi:collect :refresh t :thread t)</pre> </p> </div> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-usage_readme', '<section class="section"> <div class="container"> <div class="contents"> <h1 class="title"></h1> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-usage_setting-lisp', '<section class="section"> <div class="container"> <div class="contents"> <h1 class="title"></h1> <div class="contents"> <p> <pre>\n(aws.beach.db:start)\n(aws.db:start)</pre> </p> </div> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-web', '<section-header title="Web"></section-header> <page-tabs tabs="{tabs}" active_tag="{active_tag}" click-tab="{clickTab}"></page-tabs> <div> <page-web_tab-sitemap class="hide"></page-web_tab-sitemap> <page-web_tab_readme class="hide"></page-web_tab_readme> <page-web_tab_beach class="hide"></page-web_tab_beach> </div> <section-footer></section-footer>', '', '', function(opts) {
     this.default_tag = 'readme';
     this.active_tag = null;
     this.tabs = [
         { code: 'readme',  label: 'README',  tag: 'page-web_tab_readme' },
         { code: 'sitemap', label: 'Sitemap', tag: 'page-web_tab-sitemap' },
         { code: 'beach',   label: 'Beach',   tag: 'page-web_tab_beach' },
     ];
     this.clickTab = (e) => {
         this.switchTab(e.target.getAttribute('code'));
     };
     this.on('mount', () => {
         this.switchTab(this.default_tag);
     });
     this.switchTab = (code) => {
         if (this.active_tag == code) return;

         this.active_tag = code;

         let tag = null;
         for (var i in this.tabs) {
             let tab = this.tabs[i];

             this.tags[tab.tag].root.classList.add('hide');
             if (tab.code==code)
                 tag = tab.tag;
         }

         this.tags[tag].root.classList.remove('hide');

         this.update();
     };
});

riot.tag2('page-web_readme', '<section-header title="Web"></section-header> <page-tabs tabs="{tabs}" active_tag="{active_tag}" click-tab="{clickTab}"></page-tabs> <div> <page-web_sitemap class="hide"></page-web_sitemap> </div> <section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Usage</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Operators</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section-footer></section-footer>', '', '', function(opts) {
});

riot.tag2('page-web_tab_beach', '', '', '', function(opts) {
});

riot.tag2('page-web_tab_readme', '<div> <page-web_sitemap class="hide"></page-web_sitemap> </div> <section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> <p>インポートしたAWSコマンドのビューアーです。</p> <p>グラフ構造で表示されます。</p> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Usage</h1> <h2 class="subtitle"></h2> <div class="contents"></div> <section class="section"> <div class="container"> <h1 class="title is-4">Nginx</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-4">Common Lisp</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> </div> </section>', '', '', function(opts) {
});

riot.tag2('page-web_tab-sitemap', '<section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"> </h2> <div> 現時点では /beach のみです。 </div> </div> </section>', '', '', function(opts) {
});
