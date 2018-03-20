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
         let _id = e.target.getAttribute('_id');
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
     this.elements = function () {
         if (!STORE.state().selector.display)
             return [];

         if (STORE.state().selector.element._class == "AWS")
             return STORE.state().commands.list;

         return [];
     };
     STORE.subscribe(function (action) {
         if (action.type!='SWITCH-SELECTOR')
             return;

         this.update();
     }.bind(this));
    </script>
</selector>
