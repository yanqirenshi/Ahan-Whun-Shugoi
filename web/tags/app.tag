<app>
    <beach nodes={this.nodes()} edges={this.links()}></beach>
    <selector></selector>

    <cosmos></cosmos>

    <menu></menu>

    <script>
     window.addEventListener('resize', (event) => {
         this.update();
     });

     this.nodes = function () {
         let aws = STORE.state().aws ? [STORE.state().aws] : [];
         return aws.concat(GraphUtil.filterElements(STORE.state().options.list))
                   .concat(GraphUtil.filterElements(STORE.state().commands.list))
                   .concat(GraphUtil.filterElements(STORE.state().subcommands.list));
     }

     this.links = function () {
         return GraphUtil.filterElements(STORE.state().r.list);
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

         if (action.type=='FETCHED-SUBCOMMANDS' && action.from=='APP')
             return;
     });
     STORE.subscribe((action) => {
         let update = [
             'UPDATED-COMMAND-DISPLAY',
             'UPDATED-SUBCOMMAND-DISPLAY'
         ].find(function (v) { return v==action.type; }) ;
         if (update)
             this.update();
     });
    </script>
</app>
