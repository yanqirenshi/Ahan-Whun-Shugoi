<selector  class="{state().display ? '' : 'hide'}">
    <div class="panel box-shadow">
        <selector-header data={state().element}></selector-header>

        <selector-tabs tabs={tabs()} click-tab={clickTab}></selector-tabs>

        <selector-elements class="{contentsDisplay(0)}"
                           data={commands()}
                           searchKeyword={state().tabs[0].search}
                           change-display={changeDisplay}></selector-elements>

        <selector-elements class="{contentsDisplay(1)}"
                           data={subcommands()}
                           searchKeyword={state().tabs[1].search}
                           change-display={changeDisplay}></selector-elements>

        <selector-elements class="{this.contentsDisplay(2)}"
                           data={options()}
                           searchKeyword={state().tabs[2].search}
                           change-display={changeDisplay}></selector-elements>

        <selector-info class="{this.contentsDisplay(3)}"
                       data={state().element}></selector-info>
    </div>

    <style>
     selector {
         position: fixed;
         top: 0px;
         left: 0px;
         padding: 22px;
     }
     selector.hide,
     selector .hide {
         display: none;
     }
     selector, selector .panel {
         height: 100%;
     }
     selector .panel {
         display:flex;
         flex-direction: column;
         border-color: rgba(217, 51, 63, 0.3);
         background: #ffffff;
     }
    </style>

    <script>
     this.state = () => { return STORE.state().beach.selector; };
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
         if (STORE.state().beach.selector.display && node._class == "AWS")
             return this.filterData(tab.search, STORE.state().beach.commands.list);
         return [];
     }
     this.subcommands = () => {
         let state = this.state();
         let node = state.element;
         let tab = state.tabs[1];
         if (STORE.state().beach.selector.display && node._class == "COMMAND")
             return this.filterData(tab.search, ACTIONS.findCommandSubcommands(node));
         return [];
     }
     this.options = () => {
         let state = this.state();
         let node = state.element;
         let tab = state.tabs[2];
         if (STORE.state().beach.selector.display &&
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
    </script>
</selector>
