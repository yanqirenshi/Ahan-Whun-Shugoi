<network-graph ref="self">
    <svg ref="svg"></svg>

    <style>
     network-graph {
         width: 100%;
         height: 100%;
         display: block;
         background: rgba(252, 226, 196, 0.33);
     }
    </style>

    <script>
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
    </script>
</network-graph>
