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
            <a class="is-active">Commands</a>
            <a>Options</a>
            <a>Basic</a>
        </p>

        <label class="panel-block">
            <input type="checkbox">
            Command - 1
        </label>
        <label class="panel-block">
            <input type="checkbox">
            Command - 1
        </label>
        <label class="panel-block">
            <input type="checkbox">
            Command - 1
        </label>
        <label class="panel-block">
            <input type="checkbox">
            Command - 1
        </label>
        <label class="panel-block">
            <input type="checkbox">
            Command - 1
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
     STORE.subscribe(function (action) {
         if (action.type=='FETCHED-COMMAND_SUBCOMMANDS',
             action.type=='SWITCH-SELECTOR')
             this.update();
     }.bind(this));
    </script>

</selector>
