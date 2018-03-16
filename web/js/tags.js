riot.tag2('app', '<network-graph nodes="{this.nodes()}" edges="{this.links()}"></network-graph>', '', '', function(opts) {
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
});

riot.tag2('network-graph', '<svg ref="svg"></svg>', 'network-graph { width: 100%; height: 100%; display: block; background: rgba(252, 226, 196, 0.33); }', 'ref="self"', function(opts) {
     this.resizeSvg = function () {
         let self = this.refs.self;
         let svg = this.refs.svg;

         this.graph.setSize(self.clientWidth, self.clientHeight);

         svg.setAttribute('height', self.clientHeight + 'px');
         svg.setAttribute('width',  self.clientWidth  + 'px');
     };

     this.graph = new NetworkGraph();
     this.graph.setCallbacks({
         saveNodePosition: function () {
             dump('move!');
         },
         doubleClickNode: function (data) {
             ACTIONS.fetchAws_options(data._id);
             ACTIONS.fetchAws_commands(data._id);
             d3.event.stopPropagation();
         }
     })

     this.on('mount', function () {
         var svg = d3.select("network-graph svg");
         if (!svg) return;

         this.graph.setSvg(svg);
         this.resizeSvg();

         if ((!this.opts.nodes || this.opts.nodes.length==0) &&
             !this.opts.edges || this.opts.edges.length==0)
             return;

         this.graph.setNodes(this.opts.nodes);
         this.graph.setEdges(this.opts.edges);
         this.graph.draw();

     }.bind(this));

     this.on('update', function () {
         this.graph.setNodes(this.opts.nodes);
         this.graph.setEdges(this.opts.edges);
         this.graph.draw();
     }.bind(this));
});
