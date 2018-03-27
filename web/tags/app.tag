<app>
    <network-graph nodes={this.nodes()} edges={this.links()}></network-graph>
    <selector2></selector2>

    <script>
     window.addEventListener('resize', function (event) {
         this.update();
     }.bind(this));

     this.nodes = function () {
         let aws = STORE.state().aws ? [STORE.state().aws] : [];
         return aws.concat(GraphUtil.filterElements(STORE.state().options.list))
                   .concat(GraphUtil.filterElements(STORE.state().commands.list))
                   .concat(GraphUtil.filterElements(STORE.state().subcommands.list));
     }

     this.links = function () {
         return GraphUtil.filterElements(STORE.state().r.list);
     };

     STORE.subscribe(function (action) {
         if (action.type=='FETCHED-AWS')
             this.update();
     }.bind(this));

     // LOAD FIRST
     ACTIONS.fetchAws('APP');
     STORE.subscribe(function (action) {
         if (action.type=='FETCHED-AWS' && action.from=='APP')
             return ACTIONS.fetchCommands('APP');

         if (action.type=='FETCHED-COMMANDS' && action.from=='APP')
             return ACTIONS.fetchSubcommands('APP');

         if (action.type=='FETCHED-SUBCOMMANDS' && action.from=='APP')
             return this.update();
     }.bind(this))

     STORE.subscribe(function (action) {
         let update = [
             'UPDATED-COMMAND-DISPLAY',
             'UPDATED-SUBCOMMAND-DISPLAY'
         ].find(function (v) { return v==action.type; }) ;
         if (update)
             this.update();
     }.bind(this));
    </script>
</app>
