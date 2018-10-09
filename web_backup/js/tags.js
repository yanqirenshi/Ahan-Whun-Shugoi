riot.tag2('app', '<beach class="{display(\'beach\')}" nodes="{this.nodes()}" edges="{this.links()}"></beach> <selector></selector> <cosmos class="{display(\'cosmos\')}"></cosmos> <menu></menu>', 'app > .hide { display:none; }', '', function(opts) {
     window.addEventListener('resize', (event) => {
         this.update();
     });
     this.display = function (code) {
         let state = STORE.state().toJS();
         return state[code].display ? '' : 'hide';
     };

     this.makeData = (data) => {
         if(!data || !data.list)
             return [];

         return GraphUtil.filterElements(data.list);
     };
     this.nodes = function () {
         let state = STORE.state().toJS().beach;
         let aws = state.aws ? [state.aws] : [];
         return aws.concat(this.makeData(state.options))
                   .concat(this.makeData(state.commands))
                   .concat(this.makeData(state.subcommands));
     }

     this.links = function () {
         let state = STORE.state().toJS().beach;
         return this.makeData(state.r);
     };

     ACTIONS.fetchFinders('APP');

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-FINDERS' && action.from=='APP')
             return ACTIONS.fetchAws('APP');

         if (action.type=='FETCHED-AWS' && action.from=='APP')
             return ACTIONS.fetchCommands('APP');

         if (action.type=='FETCHED-COMMANDS' && action.from=='APP')
             return ACTIONS.fetchSubcommands('APP');

         let update = [
             'MOVE-PAGE',
             'FETCHED-SUBCOMMANDS',
             'UPDATED-COMMAND-DISPLAY',
             'UPDATED-SUBCOMMAND-DISPLAY',
             'UPDATED-OPTION-DISPLAY'
         ].find(function (v) { return v==action.type; }) ;
         if (update)
             this.update();
     });

     ACTIONS.loadEc2Instances();
});

riot.tag2('beach', '<svg ref="svg"></svg>', 'beach { width: 100%; height: 100%; display: block; background: rgba(252, 226, 196, 0.33); }', 'ref="self"', function(opts) {
     this.graph = new NetworkGraph();

     this.getSelectedFinder = () => {
         let state = STORE.state().toJS().beach.finders;
         return state.list.find((f) => {
             return f.code == state.select;
         });
     };

     this.graph.setCallbacks({
         moveEndSvg: (look_at) => {
             ACTIONS.updateFinderLookAt(this.getSelectedFinder(), look_at);
         },
         zoomSvg: (scale) => {
             ACTIONS.updateFinderScale(this.getSelectedFinder(), scale);
         },
         clickSvg: () => {
             STORE.dispatch(ACTIONS.switchSelector(null));
         },
         saveNodePosition: (data) => {
             if (data._class=='COMMAND')
                 ACTIONS.updateCommandLocation(data._id, data.location);
             if (data._class=='SUBCOMMAND')
                 ACTIONS.updateSubcommandLocation(data._id, data.location);
             if (data._class=='OPTION')
                 ACTIONS.updateOptionLocation(data._id, data.location);
         },
         clickNode: (data) => {
             STORE.dispatch(ACTIONS.switchSelector(data));
             STORE.dispatch(ACTIONS.switchSelectorTab(null));
             d3.event.stopPropagation();
         },
         doubleClickNode: (data) => {
             d3.event.stopPropagation();
         }
     })

     this.on('mount', function () {
         let svg_d3 = d3.select("beach svg");

         if (!svg_d3) return;

         GraphUtil.drawFirst (this.graph,
                              svg_d3,
                              this.refs.svg,
                              this.refs.self,
                              this.opts.nodes,
                              this.opts.edges);
     }.bind(this));

     this.on('update', function () {
         GraphUtil.draw(this.graph,
                        this.opts.nodes,
                        this.opts.edges);
     }.bind(this));

     STORE.subscribe((action) => {
         if ((action.type=='FETCHED-FINDERS' && action.from=='APP') ||
             action.type=='CLICK-FINDER') {
             let state = STORE.state().toJS().beach.finders;
             let finder = state.list.find((finder) => {
                 return finder.code == state.select;
             });

             this.graph.setLookAt({
                 _x: finder['look-at'].X,
                 _y: finder['look-at'].Y,
                 _z: finder['look-at'].Z
             });
             this.graph.setScale(finder.scale);
             this.graph.refreshViewBox();

             return this.update();
         }
     })

});

riot.tag2('cosmos', '<svg></svg>', 'cosmos { width: 100%; height: 100%; display: block; background: rgba(0,0,0,0.9); }', 'ref="self"', function(opts) {
     this.on('mount', () => {
         let base_tag = this.refs.self;
         this.d3svg = new D3Svg({
             svg: d3.select("cosmos svg"),
             x: 0,
             y: 0,
             w: base_tag.clientWidth,
             h: base_tag.clientHeight,
             scale: 1
         });
     })

     this.on('update', () => {
         let base_tag = this.refs.self;
         let width = this.refs.self.clientWidth;
         let height = this.refs.self.clientHeight;

         this.d3svg.setSize(width, height);

         var svg = this.d3svg._svg;

     });
});

riot.tag2('menu-finder', '<p code="{opts.code}" type="{opts.type}" title="{opts.code}"> {finderCode(opts.code)} </p>', 'menu-finder { display:block; margin: 3px 5px; padding: 11px; background: #fff; width: 44px; height: 44px; border-radius: 44px; text-align: center; border: 1px solid rgba(217, 51, 63, 0.3); } menu-finder[select=selected] { background: rgba(217, 51, 63, 0.8); color: #fff; font-weight: bold; }', 'class="box-shadow" select="{select()}" onclick="{opts.clickFinder}"', function(opts) {
     this.select = () => {
         return (this.opts.selectCode == this.opts.code) ? 'selected' : '';
     };
     this.finderCode = (code) => {
         let len = code.length;
         return (code.substring(0,1) + code.substring(len-1)).toUpperCase();
     };
});

riot.tag2('menu-finders', '<menu-finder each="{opts.finders}" code="{code}" type="{type}" select-code="{parent.opts.selectCode}" click-finder="{parent.opts.clickFinder}"> </menu-finder>', 'menu-finders { display: flex; flex-direction: row-reverse; flex-wrap: nowrap; } menu-finders > menu-finder{ align-items: flex-start; }', '', function(opts) {
});

riot.tag2('menu-group', '<menu-item data="{opts.data}" select="{false}" display="{true}" parent-code="{null}" click-item="{opts.clickGroup}"></menu-item> <menu-item each="{data in opts.data.children}" data="{data}" display="{displayChild()}" select="{false}" parent-code="{parentCode()}" click-item="{childrenClickItem()}"></menu-item>', 'menu-group { display: flex; flex-direction: column-reverse; flex-wrap: nowrap; } menu-group > menu-item { align-items: flex-start; }', '', function(opts) {
     this.displayChild = () => {
         return this.opts.data.open;
     };
     this.childrenClickItem = () => {
         return this.opts.clickItem;
     };
     this.parentCode = () => {
         return this.opts.data.code;
     };
});

riot.tag2('menu-item', '<p style="position: absolute;"> {finderCode(opts.data.code)} <i class="{opts.data.icon}"></i> </p>', 'menu-item { display:block; margin: 3px 5px; padding: 11px; background: #fff; width: 44px; height: 44px; border-radius: 44px; text-align: center; border: 1px solid rgba(217, 51, 63, 0.3); } menu-item.hide { display: none; } menu-item.selected { background: rgba(217, 51, 63, 0.8); color: #fff; font-weight: bold; } menu-item p{ position: absolute; color: rgba(8, 8, 8, 0.2); } menu-item svg.svg-inline--fa{ position: absolute; top: 0; left: 0; width: inherit; height: inherit; color: rgba(217, 51, 63, 0.6); font-size: 20px; }', 'class="box-shadow {display()} {select()} " code="{opts.data.code}" type="{opts.data.type}" title="{opts.data.code}" action="{opts.data.action}" onclick="{opts.clickItem}"', function(opts) {
     this.display = () => {
         return this.opts.display ? '' : 'hide';
     };
     this.select = () => {
         return (this.opts.select == this.opts.data.code) ? 'selected' : '';
     };
     this.finderCode = (code) => {
         let len = code.length;
         return (code.substring(0,1) + code.substring(len-1)).toUpperCase();
     };
});

riot.tag2('menu', '<menu-finders finders="{finders()}" select-code="{STORE.state().toJS().beach.finders.select}" click-finder="{clickFinder}"></menu-finders> <menu-group each="{data in menuGroups()}" data="{data}" click-group="{clickMenuGroup}" click-item="{clickMenuItem}"></menu-group>', 'menu { position: fixed; bottom: 0; right: 0; margin-right: 16px; display: flex; flex-direction: row; flex-wrap: nowrap; } menu > menu-finders, menu > menu-group { align-items: flex-end; }', '', function(opts) {
     this.state = () => { return STORE.state().toJS().beach; };
     this.findParentTag = (tagName, tag) => {
         if (tag.tagName.toUpperCase() == tagName.toUpperCase())
             return tag;
         return this.findParentTag (tagName, tag.parentNode)
     };
     this.clickFinder = (e) => {
         let code = e.target.getAttribute('code');

         STORE.dispatch(ACTIONS.clickFinder(code));
     }
     this.clickMenuGroup = (e) => {
         let tag = this.findParentTag('menu-item',e.target);
         let code = tag.getAttribute('code');

         STORE.dispatch(ACTIONS.clickMenuGroupItem(code));
     }
     this.clickMenuItem = (e) => {
         let tag = this.findParentTag('menu-item',e.target);
         let code = tag.getAttribute('code');
         let parent_code = tag.getAttribute('parent-code');
         let action = tag.getAttribute('action');

         if (action=='move-page')
             STORE.dispatch(ACTIONS.movePage(code));

         STORE.dispatch(ACTIONS.clickMenuItem(code, parent_code));
     }
     this.finders = () => {
         let finders = this.state().finders.list;
         return finders.map((finder) => {
             return {
                 code: finder.code,
                 type: 'finder'
             }
         });
     };
     this.menuGroups = () => {
         return this.state().menus;
     };
     STORE.subscribe((action) => {
         if (action.type=='CLICK-FINDER' ||
             action.type=='CLICK-MENU-GROUP-ITEM' ||
             action.type=='CLICK-MENU-ITEM') {
             this.update();
         }
     });
});

riot.tag2('network-graph', '<svg ref="svg"></svg>', 'network-graph { width: 100%; height: 100%; display: block; background: rgba(252, 226, 196, 0.33); }', 'ref="self"', function(opts) {
     this.graph = new NetworkGraph();

     this.getSelectedFinder = () => {
         let state = STORE.state().beach.finders;
         return state.list.find((f) => {
             return f.code == state.select;
         });
     };

     this.graph.setCallbacks({
         moveEndSvg: (look_at) => {
             ACTIONS.updateFinderLookAt(this.getSelectedFinder(), look_at);
         },
         zoomSvg: (scale) => {
             ACTIONS.updateFinderScale(this.getSelectedFinder(), scale);
         },
         clickSvg: () => {
             STORE.dispatch(ACTIONS.switchSelector(null));
         },
         saveNodePosition: (data) => {
             if (data._class=='COMMAND')
                 ACTIONS.updateCommandLocation(data._id, data.location);
             if (data._class=='SUBCOMMAND')
                 ACTIONS.updateSubcommandLocation(data._id, data.location);
             if (data._class=='OPTION')
                 ACTIONS.updateOptionLocation(data._id, data.location);
         },
         clickNode: (data) => {
             STORE.dispatch(ACTIONS.switchSelector(data));
             STORE.dispatch(ACTIONS.switchSelectorTab(null));
             d3.event.stopPropagation();
         },
         doubleClickNode: (data) => {
             d3.event.stopPropagation();
         }
     })

     this.on('mount', function () {
         let svg_d3 = d3.select("network-graph svg");

         if (!svg_d3) return;

         GraphUtil.drawFirst (this.graph,
                              svg_d3,
                              this.refs.svg,
                              this.refs.self,
                              this.opts.nodes,
                              this.opts.edges);
     }.bind(this));

     this.on('update', function () {
         GraphUtil.draw(this.graph,
                        this.opts.nodes,
                        this.opts.edges);
     }.bind(this));

     STORE.subscribe((action) => {
         if ((action.type=='FETCHED-FINDERS' && action.from=='APP') ||
             action.type=='CLICK-FINDER') {
             let state = STORE.state().beach.finders;
             let finder = state.list.find((finder) => {
                 return finder.code == state.select;
             });
             this.graph.setLookAt({
                 _x: finder['look-at'].X,
                 _y: finder['look-at'].Y,
                 _z: finder['look-at'].Z
             });
             this.graph.setScale(finder.scale);
             this.graph.refreshViewBox();

             return this.update();
         }
     })

});

riot.tag2('selector-elements', '<div class="panel-block" style="display:block;"> <p class="control has-icons-left"> <input class="input is-small" type="text" placeholder="search" ref="searchKeyword" oninput="{this.onInput}" riot-value="{opts.searchKeyword}"> <span class="icon is-small is-left"> <i class="fas fa-search"></i> </span> </p> </div> <div class="contents panel-block"> <div each="{opts.data}" style="width:100%"> <input type="checkbox" checked="{display ? \'checked\' : \'\'}" onchange="{opts.changeDisplay}" _class="{_class}" _id="{_id}"> {code} </div> </div> <div class="tail panel-block" style="align-items:flex-end;"> </div>', 'selector-elements { align-items: stretch; flex-grow: 1; display: flex; flex-direction: column; padding: 0px; background: #ffffff; border-left: solid 1px rgba(217, 51, 63, 0.3); border-right: solid 1px rgba(217, 51, 63, 0.3); } selector-elements > div.panel-block, selector-elements > div.panel-block:first-child { border-top:none; border-left:none; border-right:none; border-color: rgba(217, 51, 63, 0.3); } selector-elements > div.panel-block:last-child { border-bottom:none; } selector-elements .contents { flex-direction: column; overflow: auto; overflow-x: hidden; flex-grow: 1; } selector-elements .tail { background: rgba(217, 51, 63, 0.6); color: #fff; }', '', function(opts) {
     this.onInput = (e) => {
         let tabs = STORE.state().beach.selector.tabs;
         let tab_code = tabs.find((tab)=>{ return tab.select; }).code
         STORE.dispatch(ACTIONS.updateSelectorElementKeword(tab_code, e.target.value));
     }
});

riot.tag2('selector-header', '<p> {title()} </p>', 'selector-header.panel-heading { background: rgba(217, 51, 63, 0.6); color: #fff; font-weight: bold; align-items:flex-start; } selector-header.panel-heading, selector-header.panel-heading:first-child { border-color: rgba(217, 51, 63, 0.3); }', 'class="panel-heading"', function(opts) {
     this.title = () => {
         let element = this.opts.data;
         let code = element.code ? element.code : '???';
         let _class = element._class ? element._class : '???';
         return code + ' (' + _class + ')'
     };
});

riot.tag2('selector-info', '<div class="contents panel-block"> <div> <h3 class="title is-4">Description</h3> <p ref="description"></p> </div> <div> <h3 class="title is-4">Synopsis</h3> <p ref="synopsis"></p> </div> <div> <h3 class="title is-4">Uri</h3> <div class="section"> <a href="{this.opts.data.uri}">{this.opts.data.uri}</a> </div> </div> <div> <h3 class="title is-4">Location</h3> <div class="section"> <table class="table"> <thead><tr><th>x</th><th>y</th><th>z</th></tr></thead> <tbody><tr> <td>{location(\'X\')}</td> <td>{location(\'Y\')}</td> <td>{location(\'Z\')}</td> </tr></tbody> </table> </div> </div> </div> <div class="tail panel-block" style="align-items:flex-end;"> </div>', 'selector-info { width: 50vw; align-items: stretch; flex-grow: 1; display: flex; flex-direction: column; padding: 0px; background: #ffffff; border-left: solid 1px rgba(217, 51, 63, 0.3); border-right: solid 1px rgba(217, 51, 63, 0.3); } selector-info > .contents { flex-direction: column; overflow: auto; overflow-x: hidden; flex-grow: 1; } selector-info > .contents > div{ width: 100%; } selector-info > .contents .section { padding: 1rem 2rem; } selector-info > div.panel-block, selector-info > div.panel-block:first-child { border-top:none; border-left:none; border-right:none; border-color: rgba(217, 51, 63, 0.3); } selector-info > div.panel-block:last-child { border-bottom:none; } selector-info > .tail { background: rgba(217, 51, 63, 0.6); color: #fff; }', '', function(opts) {
     this.on('update', () => {
         this.refs.description.innerHTML = this.opts.data.description;
         this.refs.synopsis.innerHTML = this.opts.data.synopsis;
     });

     this.location = function (key) {
         if (!this.opts.data || !this.opts.data.location)
             return '?'

         return this.opts.data.location[key];
     }.bind(this);
});

riot.tag2('selector-tabs', '<div> <a each="{opts.tabs}" class="{select ? \'is-active\' : \'\'} {display ? \'\' : \'hide\'}" code="{code}" onclick="{opts.clickTab}">{code}</a> </div>', 'selector-tabs .hide { display: none; } selector-tabs.panel-tabs { align-items: flex-start; border-color: rgba(217, 51, 63, 0.3); display: block; } selector-tabs.panel-tabs > div { display: flex; flex-direction: row; padding: 0px 0px 11px 0px; } selector-tabs.panel-tabs a { border-color: rgba(217, 51, 63, 0.1); justify-content: space-around; flex-grow: 1; text-align: center; } selector-tabs.panel-tabs a.is-active { border-color: rgba(217, 51, 63, 1); }', 'class="panel-tabs"', function(opts) {
});

riot.tag2('selector', '<div class="panel box-shadow"> <selector-header data="{state().element}"></selector-header> <selector-tabs tabs="{tabs()}" click-tab="{clickTab}"></selector-tabs> <selector-elements class="{contentsDisplay(0)}" data="{commands()}" searchkeyword="{state().tabs[0].search}" change-display="{changeDisplay}"></selector-elements> <selector-elements class="{contentsDisplay(1)}" data="{subcommands()}" searchkeyword="{state().tabs[1].search}" change-display="{changeDisplay}"></selector-elements> <selector-elements class="{this.contentsDisplay(2)}" data="{options()}" searchkeyword="{state().tabs[2].search}" change-display="{changeDisplay}"></selector-elements> <selector-info class="{this.contentsDisplay(3)}" data="{state().element}"></selector-info> </div>', 'selector { position: fixed; top: 0px; left: 0px; padding: 22px; } selector.hide, selector .hide { display: none; } selector, selector .panel { height: 100%; } selector .panel { display:flex; flex-direction: column; border-color: rgba(217, 51, 63, 0.3); background: #ffffff; }', 'class="{state().display ? \'\' : \'hide\'}"', function(opts) {
     this.state = () => { return STORE.state().toJS().beach.selector; };
     this.contentsDisplay = (i) => { return this.state().tabs[i].select ? '' : 'hide'; }
     this.tabs = () => {
         let tabs = this.state().tabs;
         let _class = this.state().element._class;
         let out = [];

         for (var i in tabs) {
             let tab = tabs[i];
             if (_class=='COMMAND' && tab.code=='options')
                 continue;
             if (_class=='SUBCOMMAND' && tab.code=='elements')
                 continue;
             out.push(tabs[i]);
         }
         return out;
     };
     this.filterData = (keyword, data) => {
         let out = [];
         let search_keyword = keyword ? keyword.trim().toUpperCase() : '';
         for (var i in data)
             if (data[i].code.toUpperCase().indexOf(search_keyword)>=0)
                 out.push(data[i]);
         return out;
     }
     this.commands = () => {
         let state = this.state();
         let node = state.element;
         let tab = state.tabs[0];
         if (state.display && node._class == "AWS")
             return this.filterData(tab.search, STORE.state().beach.commands.list);
         return [];
     }
     this.subcommands = () => {
         let state = this.state();
         let node = state.element;
         let tab = state.tabs[1];
         if (state.display && node._class == "COMMAND")
             return this.filterData(tab.search, ACTIONS.findCommandSubcommands(node));
         return [];
     }
     this.options = () => {
         let state = this.state();
         let node = state.element;
         let tab = state.tabs[2];
         if (state.display &&
             (node._class == "AWS" || node._class == "SUBCOMMAND"))
             return this.filterData(tab.search, ACTIONS.findNodeOptions(node));

         return [];
     }
     this.clickTab = (e) => {
         STORE.dispatch(ACTIONS.switchSelectorTab(e.target.getAttribute('code')));
     };
     this.changeDisplay = (e) => {
         ACTIONS.changeNodeDisplay(e.target.getAttribute('_class'),
                                   e.target.getAttribute('_id'),
                                   e.target.checked);
     };
     STORE.subscribe(function (action) {
         if (!(action.type=='SWITCH-SELECTOR' ||
               action.type=='FETCHED-COMMAND-4-SELECTOR' ||
               action.type=='SWITCH-SELECTOR-TAB' ||
               action.type=='UPDATE-SELECTOR-SERCH-WORKD-4-COMMANDS' ||
               action.type=='UPDATE-SELECTOR-ELEMENT-KEWORD'))
             return;

         this.update();
     }.bind(this));
});
