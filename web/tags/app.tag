<app>
    <beach class="{STORE.state().beach.display ? '' : 'hide'}" nodes={this.nodes()} edges={this.links()}></beach>
    <selector></selector>

    <cosmos class="{STORE.state().cosmos.display ? '' : 'hide'}"></cosmos>

    <menu></menu>

    <style>
     app > .hide { display:none; }
    </style>

    <script>
     window.addEventListener('resize', (event) => {
         this.update();
     });

     this.nodes = function () {
         let state = STORE.state().beach;
         let aws = state.aws ? [state.aws] : [];
         return aws.concat(GraphUtil.filterElements(state.options.list))
                   .concat(GraphUtil.filterElements(state.commands.list))
                   .concat(GraphUtil.filterElements(state.subcommands.list));
     }

     this.links = function () {
         let state = STORE.state().beach;
         return GraphUtil.filterElements(state.r.list);
     };

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-AWS')
             this.update();
     });

     // LOAD FIRST
     ACTIONS.fetchFinders('APP');
     ACTIONS.fetchAws('APP');

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-AWS' && action.from=='APP')
             return ACTIONS.fetchCommands('APP');

         if (action.type=='FETCHED-COMMANDS' && action.from=='APP')
             return ACTIONS.fetchSubcommands('APP');
     });
     STORE.subscribe((action) => {
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
    </script>
</app>
