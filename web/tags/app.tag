<app>
    <network-graph nodes={this.nodes()} edges={this.links()}></network-graph>
    <selector></selector>

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
             'FETCHED-COMMAND_SUBCOMMANDS',
             'UPDATED-COMMAND-DISPLAY'
         ].find(function (v) { return v==action.type; }) ;
         if (update)
             this.update();
     }.bind(this))
    </script>
</app>
