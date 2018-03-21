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
     this.graph = new NetworkGraph();
     this.graph.setCallbacks({
         saveNodePosition: function (data) {
             if (data._class=='COMMAND')
                 ACTIONS.updateCommandLocation(data._id, data.location);
         },
         clickNode: function (data) {
             STORE.dispatch(ACTIONS.switchSelector(data));
         },
         doubleClickNode: function (data) {
             d3.event.stopPropagation();
         }
     })

     this.on('mount', function () {
         var svg = d3.select("network-graph svg");

         if (!svg) return;

         this.graph.setSvg(svg);
         this.graph.resizeSvg(this.refs.svg,
                              this.refs.self.clientWidth,
                              this.refs.self.clientHeight)
         this.graph.initViewBox(this.refs.svg);

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
