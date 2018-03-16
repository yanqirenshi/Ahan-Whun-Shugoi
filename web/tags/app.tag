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

         return out;
     }

     this.links = function () {
         return [];
     };

     ACTIONS.fetchAws();

     STORE.subscribe(function (action) {
         if (action.type=='FETCHED-AWS')
             this.update();
     }.bind(this));
    </script>
</app>
