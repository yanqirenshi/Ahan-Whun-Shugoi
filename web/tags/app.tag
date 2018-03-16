<app>
    <network-graph nodes={this.nodes()} edges={this.links()}></network-graph>

    <script>
     window.addEventListener('resize', function (event) {
         this.update();
     }.bind(this));

     this.nodes = function () {
         let out = []

         if (STORE.state().aws) {
             let aws = STORE.state().aws;
             out.push({
                 _id: aws._id,
                 name: aws.code,
                 description: aws.description,
                 x: 0,
                 y: 0
             });
         }

         for (var i in STORE.state().commands) {
             let command = STORE.state().commands[i]
             out.push({
                 _id: command._id,
                 name: command.code,
                 description: command.description,
                 x: 0,
                 y: 0
             });
         }

         for (var i in STORE.state().options) {
             let options = STORE.state().options[i]
             out.push({
                 _id: options._id,
                 name: options.code,
                 description: '',
                 x: 0,
                 y: 0
             });
         }

         return out;
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
             'FETCHED-AWS_OPTIONS'
         ].find(function (v) { return v==action.type; }) ;
         if (update)
             this.update();
     }.bind(this))
    </script>
</app>
