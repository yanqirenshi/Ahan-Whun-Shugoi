<selector2  class="{state().display ? '' : 'hide'}">
    <div class="panel">
        <selector2-header data={state().element}></selector2-header>

        <selector2-tabs tabs={tabs()} click-tab={clickTab}></selector2-tabs>

        <selector2-commands data={commands()} change-display={changeDisplay}></selector2-commands>
        <selector2-subcommands data={subcommands()} style="display:none;"></selector2-subcommands>
        <selector2-options style="display:none;"></selector2-options>
    </div>

    <style>
     selector2 {
         position: fixed;
         top: 0px;
         left: 0px;
         padding: 22px;
     }
     selector2.hide {
         display: none;
     }
     selector2, selector2 .panel {
         height: 100%;
     }
     selector2 .panel {
         display:flex;
         flex-direction: column;
         border-color: rgba(217, 51, 63, 0.3);
         background: #ffffff;
         box-shadow: 0px 0px 22px 3px rgba(217, 51, 63, 0.1);
     }
    </style>

    <script>
     this.state = () => {
         return STORE.state().selector;
     };
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
     this.commands = () => {
         let node = this.state().element;
         if (STORE.state().selector.display && node._class == "AWS")
             return STORE.state().commands.list;
         return [];
     }
     this.subcommands = () => {
         let node = this.state().element;
         if (STORE.state().selector.display && node._class == "COMMAND")
             return STORE.state().subcommands.list;
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
               action.type=='UPDATE-SELECTOR-SERCH-WORKD-4-COMMANDS'))
             return;

         this.update();
     }.bind(this));
    </script>
</selector2>
