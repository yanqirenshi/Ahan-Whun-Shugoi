<app>
    <network-graph nodes={this.nodes()} edges={this.links()}></network-graph>
    <selector></selector>

    <script>
     window.addEventListener('resize', function (event) {
         this.update();
     }.bind(this));

     this.nodes = function () {
         let aws = STORE.state().aws ? [STORE.state().aws] : [];
         return aws.concat(STORE.state().options)
                   .concat(STORE.state().commands)
                   .concat(STORE.state().subcommands);
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
