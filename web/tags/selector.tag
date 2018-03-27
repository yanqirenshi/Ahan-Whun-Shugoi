<selector class="{state().display ? '' : 'hide'}">
    <div class="panel">
        <p class="panel-heading" style="border-color: rgba(217, 51, 63, 0.3);">
            {title()}
        </p>

        <div class="panel-block">
            <p class="control has-icons-left">
                <input class="input is-small"
                       type="text"
                       placeholder="search"
                       ref="search_keyword">
                <span class="icon is-small is-left">
                    <i class="fas fa-search"></i>
                </span>
            </p>
        </div>

        <p class="panel-tabs">
            <a each={tabs()}
               class="{display ? 'is-active' : ''}"
               code={code}
               onclick={clickTab}>{code}</a>
        </p>

        <div class="panel-block {STORE.state().selector.tabs[0].display ? '' : 'hidden'}">
            <selector-elements data={this.elements()}
                               change-display={changeDisplay}></selector-elements>
        </div>

        <div class="panel-block {STORE.state().selector.tabs[1].display ? '' : 'hidden'}">
            <selector-options data={this.options()}>
            </selector-options>
        </div>

        <div class="panel-block {STORE.state().selector.tabs[2].display ? '' : 'hidden'}">
            <selector-info>
            </selector-info>
        </div>
    </div>

    <style>
     selector.hide { display: none; }
     selector {
         display: block;
         padding: 8px;
         position: fixed;
         left: 0;
         top: 0;
     }
     selector div.panel {
         background: #ffffff;
     }
     selector div.panel-block {
         display: block;
     }
     selector div.panel-block.hidden {
         display: none;
     }
     selector p.panel-heading {
         background: rgba(217, 51, 63, 0.6);
         border-color: rgba(217, 51, 63, 0.3);
         color: #fff;
         font-weight: bold;
     }
     selector .panel-tabs a {
         color: #888;
         border-bottom-color: rgba(217, 51, 63, 0.3);
     }
     selector .panel-tabs a.is-active {
         font-weight: bold;
         border-bottom-color: rgba(217, 51, 63, 1);
     }
     selector div.panel,
     selector div.panel-block,
     selector div.panel-block input,
     selector p.panel-tabs,
     selector label.panel-block { border-color: rgba(217, 51, 63, 0.3); }
    </style>

    <script>
     this.on('mount', () => {
         this.refs.search_keyword.oninput = function (e) {
             STORE.dispatch(ACTIONS.updateSelectorSerchWorkd4Commands(e.target.value));
         };
     })
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
     this.title = () => {
         let element = this.state().element;
         let code = element.code ? element.code : '???';
         let _class = element._class ? element._class : '???';
         return code + ' (' + _class + ')'
     };
     this.clickTab = function (e) {
         STORE.dispatch(ACTIONS.switchSelectorTab(e.target.getAttribute('code')));
     };
     this.state = function () {
         return STORE.state().selector;
     };
     this.changeDisplay = function (e) {
         ACTIONS.changeNodeDisplay(e.target.getAttribute('_class'),
                                   e.target.getAttribute('_id'),
                                   e.target.checked);
     };
     this.elementsLabel = function () {
         if (!STORE.state().selector.display)
             return '';

         if (STORE.state().selector.element._class == "AWS")
             return 'Commands';
         if (STORE.state().selector.element._class == "COMMAND")
             return 'Subcommands';

         return '';
     };
     this.elements = () => {
         if (!STORE.state().selector.display)
             return [];

         let node = STORE.state().selector.element;

         if (node._class == "AWS")
             return STORE.state().commands.list;

         if (node._class == "COMMAND") {
             let r_list = STORE.state().r.list;
             let subommands = STORE.state().subcommands.ht;
             let out = [];
             for (var i in r_list) {
                 let r = r_list[i]
                 if (r['from-id']==node._id)
                     out.push(subommands[r['to-id']])
             }
             return out;
         }
         return [];
     };
     this.options = () => {
         if (!STORE.state().selector.display)
             return [];
         let findOptions = function (r_list, options) {
             let out = [];
             for (var i in r_list) {
                 let r = r_list[i]
                 if (r['from-id']==node._id) {
                     let node = options[r['to-id']];
                     if (node)
                         out.push(node)
                 }
             }
             return out;
         }

         let node = STORE.state().selector.element;

         if (node._class == "AWS")
             return findOptions(STORE.state().r.list, STORE.state().options.ht)

         if (node._class == "COMMAND")
             return [];

         if (node._class == "SUBCOMMAND")
             return findOptions(STORE.state().r.list, STORE.state().options.ht)

         return [];
     }
     STORE.subscribe(function (action) {
         if (!(action.type=='SWITCH-SELECTOR' ||
               action.type=='FETCHED-COMMAND-4-SELECTOR' ||
               action.type=='SWITCH-SELECTOR-TAB' ||
               action.type=='UPDATE-SELECTOR-SERCH-WORKD-4-COMMANDS'))
             return;

         this.update();
     }.bind(this));
    </script>
</selector>
