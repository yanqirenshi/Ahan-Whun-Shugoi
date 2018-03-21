<selector class="{state().display ? '' : 'hide'}">
    <div class="panel">
        <p class="panel-heading">
            {state().title}
        </p>
        <div class="panel-block">
            <p class="control has-icons-left">
                <input class="input is-small" type="text" placeholder="search">
                <span class="icon is-small is-left">
                    <i class="fas fa-search"></i>
                </span>
            </p>
        </div>

        <p class="panel-tabs">
            <a class="is-active">{this.elementsLabel()}</a>
            <a>Options</a>
            <a>Basic</a>
        </p>

        <label each={this.elements()}
               class="panel-block">
            <input type="checkbox"
                   checked={display ? 'checked' : ''}
                   onchange={changeDisplay}
                   _class={_class}
                   _id={_id}>
            {code}
        </label>
    </div>

    <style>
     selector.hide { display: none; }
     selector {
         display: block;
         padding: 5px;
         position: fixed;
         left: 0;
         top: 0;
     }
     selector > div.panel {
         background: #ffffff;
     }
    </style>

    <script>
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
     STORE.subscribe(function (action) {
         if (!(action.type=='SWITCH-SELECTOR' ||
               action.type=='FETCHED-COMMAND-4-SELECTOR'))
             return;

         this.update();
     }.bind(this));
    </script>
</selector>
