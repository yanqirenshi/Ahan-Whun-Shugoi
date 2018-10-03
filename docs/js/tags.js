riot.tag2('api', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('api_page_root', '<section-header title="Api"></section-header> <section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Usage</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Operators</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section-footer></section-footer>', '', '', function(opts) {
});

riot.tag2('app', '<menu-bar brand="{{label:\'RT\'}}" site="{site()}" moves="{[]}"></menu-bar> <div ref="page-area"></div>', 'app > .page { width: 100vw; overflow: hidden; display: block; } app .hide,[data-is="app"] .hide{ display: none; }', '', function(opts) {
     this.site = () => {
         return STORE.state().get('site');
     };

     STORE.subscribe((action)=>{
         if (action.type!='MOVE-PAGE')
             return;

         let tags= this.tags;

         tags['menu-bar'].update();
         ROUTER.switchPage(this, this.refs['page-area'], this.site());
     })

     window.addEventListener('resize', (event) => {
         this.update();
     });

     if (location.hash=='')
         location.hash='#home'
});

riot.tag2('beach', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('beach_page_root', '<section-header title="Beach"></section-header> <section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> <p>Under the paving stone the beach というスローガン(?)がパッケージ名の由来です。</p> <p>AWS Cli のWEB上のマニュアルを全て読み込んでローカルDBに保管します。</p> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Usage</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Operators</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Others</h1> <h2 class="subtitle"></h2> <section class="section"> <div class="container"> <h1 class="title is-4">collect が上手くいかない AWSコマンド</h1> <h2 class="subtitle"></h2> <div class="contents"> <p>2018-10-03 (Wed) ですが、 AWS のマニュアルに問題があり、正常にインポート出来ないマニュアルがあります。</p> <p>これらのコマンドは、オプションが正しく取得できていません。</p> <p><pre>\nWARNING: 0  = 8  ⇒ NIL : CREATE-SUBSCRIPTION\nWARNING: 0  = 8  ⇒ NIL : UPDATE-SUBSCRIPTION\nWARNING: 0  = 1  ⇒ NIL : GET\nWARNING: 0  = 2  ⇒ NIL : SET\nWARNING: 32 = 34 ⇒ NIL : CREATE-CLUSTER</pre> </p> </div> </div> </section> </div> </section> <section-footer></section-footer>', '', '', function(opts) {
     this.operators = [
         { name: 'get-aws',                  description: '', type: '???', package: '' },
         { name: 'find-aws-options',         description: '', type: '???', package: '' },
         { name: 'find-commands',            description: '', type: '???', package: '' },
         { name: 'get-command',              description: '', type: '???', package: '' },
         { name: 'get-command-subcommand',   description: '', type: '???', package: '' },
         { name: 'find-command-subcommands', description: '', type: '???', package: '' },
         { name: 'find-subcommand-options',  description: '', type: '???', package: '' },
         { name: 'get-subcommand',           description: '', type: '???', package: '' },
         { name: 'collect',                  description: '', type: '???', package: '' },
         { name: 'command',                  description: '', type: '???', package: '' },
         { name: 'display',                  description: '', type: '???', package: '' },
         { name: 'r-aws2commands',           description: '', type: '???', package: '' },
         { name: 'r-aws2options',            description: '', type: '???', package: '' },
         { name: 'r-command2subcommands',    description: '', type: '???', package: '' },
         { name: 'r-subcommand2options',     description: '', type: '???', package: '' },
         { name: 'options-values',           description: '', type: '???', package: '' },
         { name: 'find-finder',              description: '', type: '???', package: '' },
         { name: 'get-finder',               description: '', type: '???', package: '' },
         { name: 'lock-p',                   description: '', type: '???', package: '' },
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

riot.tag2('sections-list', '<table class="table"> <tbody> <tr each="{opts.data}"> <td><a href="{hash}">{title}</a></td> </tr> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('core', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('core_page_root', '<section-header title="Command"></section-header> <section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Usage</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Operators</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section-footer></section-footer>', '', '', function(opts) {
});

riot.tag2('home', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('home_functions', '<section class="section"> <div class="container"> <h1 class="title">Functions</h1> <div class="contents"> <p>以下のような事ができます。</p> </div> <section class="section" style="padding-top: 11px; padding-bottom: 0px;"> <div class="container"> <h1 class="title is-4">1. AWS Cli マニュアルのインポート</h1> <div class="contents" style="padding-left: 33px;"> <p>collect コマンドでWEB上にあるマニュアルをインポートできます。</p> <p>実行を禁止できます。</p> </div> </div> </section> <section class="section" style="padding-top: 11px; padding-bottom: 0px;"> <div class="container"> <h1 class="title is-4">2. AWS Cli のコマンドのWEBビューアー</h1> <div class="contents" style="padding-left: 33px;"> <p>インポートしたマニュアルのをWEBブラウザで照会できます。</p> </div> </div> </section> <section class="section" style="padding-top: 11px; padding-bottom: 0px;"> <div class="container"> <h1 class="title is-4">3. AWS Cli のコマンド実行</h1> <div class="contents" style="padding-left: 33px;"> <p>Common Lisp から AWS Cli を実行できます。</p> <p>インポートしたマニュアルで実行パラメータの型チェックができます。</p> <p>インポートしたマニュアルで実行制限ができます。</p> </div> </div> </section> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_installation', '<section class="section"> <div class="container"> <div class="contents"> <h1 class="title">Installation</h1> <p><pre>\n(ql:quickload :ahan-whun-shugoi-beach)\n(ql:quickload :ahan-whun-shugoi)\n(ql:quickload :ahan-whun-shugoi-api)</pre> </p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_page_operators', '<section class="section" style="padding-top: 0px; padding-bottom: 0px;"> <div class="container"> <div class="contents"> <p>鋭意執筆中</p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_page_others', '<section class="section" style="padding-top: 0px; padding-bottom: 0px;"> <div class="container"> <div class="contents"> <p>鋭意執筆中</p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_page_packages', '<section class="section" style="padding-top: 0px; padding-bottom: 0px;"> <div class="container"> <div class="contents"> <p>構成するパッケージについて説明します。</p> </div> </div> </section> <section class="section" style="padding-top: 33px; padding-bottom: 33px;"> <div class="container"> <div class="tabs"> <ul> <li class="is-active"><a>主要なパッケージ</a></li> <li><a>COMMAND(核)</a></li> <li><a>BEACH(砂浜)</a></li> <li><a>WEB API(Api)</a></li> </ul> </div> </div> </section> <div> <home_page_packages_important packages="{packages}"></home_page_packages_important> <home_page_packages_command packages="{packages}"></home_page_packages_command> <home_page_packages_beach packages="{packages}"></home_page_packages_beach> <home_page_packages_api packages="{packages}"></home_page_packages_api> </div>', '', '', function(opts) {
     this.packages = {
         important: [
             { name: 'ahan-whun-shugoi', description: '' },
             { name: 'ahan-whun-shugoi.db', description: '' },
             { name: 'ahan-whun-shugoi.api', description: '' },
             { name: 'ahan-whun-shugoi.beach', description: '' },
             { name: 'ahan-whun-shugoi.help', description: '' },
         ],
         command: [
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

riot.tag2('home_page_packages_api', '<section class="section"> <div class="container"> <h1 class="title">List</h1> <h2 class="subtitle"></h2> <div class="contents"> <pakage-list packages="{opts.packages.api}"></pakage-list> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_page_packages_beach', '<section class="section"> <div class="container"> <h1 class="title">List</h1> <h2 class="subtitle"></h2> <div class="contents"> <pakage-list packages="{opts.packages.beach}"></pakage-list> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_page_packages_command', '<section class="section"> <div class="container"> <h1 class="title">List</h1> <h2 class="subtitle"></h2> <div class="contents"> <pakage-list packages="{opts.packages.command}"></pakage-list> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_page_packages_important', '<section class="section"> <div class="container"> <h1 class="title">List</h1> <h2 class="subtitle"></h2> <div class="contents"> <pakage-list packages="{opts.packages.important}"></pakage-list> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_page_readme', '<section class="section" style="padding-top: 0px; padding-bottom: 0px;"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle">AWS Cli ラッパー、 マニュアルを添えて。</h2> <div class="contents"> <p>AWS Cli を Common Lisp 上から、なるだけ安全に実行するためのライブラリです。</p> <p>コマンドでのパラメータの値の型チェック、実行制限が出来ます。</p> </div> </section> <home_functions></home_functions> <home_usage></home_usage> <home_installation></home_installation> <section class="section"> <div class="container"> <div class="contents"> <h1 class="title">Author</h1> <p>Satoshi Iwasaki (yanqirenshi@gmail.com)</p> </div> </div> </section> <section class="section"> <div class="container"> <div class="contents"> <h1 class="title">Copyright</h1> <p>Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)</p> </div> </div> </section> <section class="section"> <div class="container"> <div class="contents"> <h1 class="title">License</h1> <p>Licensed under the MIT License.</p> </div> </div> </section> <section-footer></section-footer>', '', '', function(opts) {
});

riot.tag2('home_page_root', '<section-header title="AHAN-WHUN-SHUGOI" subtitle="AWS Cli wrapper with Manuals"></section-header> <section class="section" style="padding-top: 0px; padding-bottom: 33px;"> <div class="container"> <div class="tabs"> <ul> <li class="is-active"><a>README</a></li> <li><a>Packages</a></li> <li><a>Operators</a></li> <li><a>Others</a></li> </ul> </div> </div> </section> <div> <home_page_readme></home_page_readme> <home_page_packages></home_page_packages> <home_page_operators></home_page_operators> <home_page_others></home_page_others> </div>', '', '', function(opts) {
});

riot.tag2('home_usage', '<section class="section"> <div class="container"> <div class="contents"> <h1 class="title">Usage</h1> <p> <pre>\n(aws.beach.db:start)\n(aws.db:start)\n\n(aws.beach:collect)</pre> </p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('pakage-list', '<table class="table"> <thead> <tr><th>Name</th><th>Description</th></tr> </thead> <tbody> <tr each="{opts.packages}"> <th>{name}</th> <td>{description}</td> </tr> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('web', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('web_page_root', '<section-header title="Web"></section-header> <section class="section"> <div class="container"> <h1 class="title">Description</h1> <h2 class="subtitle"></h2> <div class="contents"> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Usage</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Operators</h1> <h2 class="subtitle"></h2> <div class="contents"></div> </div> </section> <section-footer></section-footer>', '', '', function(opts) {
});
