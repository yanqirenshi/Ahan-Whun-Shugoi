<selector  class="{state().display ? '' : 'hide'}">
    <div class="panel">
        <selector-header data={state().element}></selector-header>

        <selector-tabs tabs={tabs()} click-tab={clickTab}></selector-tabs>

        <selector-elements class="{contentsDisplay(0)}"
                           data={commands()}
                           change-display={changeDisplay}></selector-elements>

        <selector-elements class="{contentsDisplay(1)}"
                           data={subcommands()}></selector-elements>

        <selector-elements class="{this.contentsDisplay(2)}"
                           data={options()}></selector-elements>
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
         box-shadow: 0px 0px 22px 3px rgba(217, 51, 63, 0.1);
     }
    </style>

    <script>
     this.state = () => { return STORE.state().selector; };
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
     this.commands = () => {
         let node = this.state().element;

         if (STORE.state().selector.display && node._class == "AWS")
             return STORE.state().commands.list;
         return [];
     }
     this.subcommands = () => {
         let node = this.state().element;
         if (STORE.state().selector.display && node._class == "COMMAND")
             return ACTIONS.findCommandSubcommands(node);
         return [];
     }
     this.options = () => {
         let node = this.state().element;

         if (STORE.state().selector.display &&
             (node._class == "AWS" || node._class == "COMMAND"))
             return ACTIONS.findAwsOptions(node);

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
</selector>
