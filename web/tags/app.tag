<app>
    <network-graph nodes={this.nodes()} edges={this.links()}></network-graph>

    <script>
     window.addEventListener('resize', function (event) {
         this.update();
     }.bind(this));

     this.nodes = function () {
         return GraphUtil.makeNodeDataAWS(STORE.state().aws)
                         .concat(GraphUtil.makeNodeDataOptions(STORE.state().options))
                         .concat(GraphUtil.makeNodeDataCommands(STORE.state().commands))
                         .concat(GraphUtil.makeNodeDataSubcommands(STORE.state().subcommands));
     }

     this.links = function () {
         return STORE.state().r;
     };

     ACTIONS.fetchAws();

     STORE.subscribe(function (action) {
         if (action.type=='FETCHED-AWS')
             this.update();
     }.bind(this));

     STORE.subscribe(function (action) {
         let update = [
             'FETCHED-SUBCOMMAND',
             'FETCHED-COMMAND',
             'FETCHED-AWS',
             'FETCHED-OPTION',
             'FETCHED-AWS_OPTIONS',
             'FETCHED-COMMAND_SUBCOMMANDS'
         ].find(function (v) { return v==action.type; }) ;
         if (update)
             this.update();
     }.bind(this))
    </script>
</app>
