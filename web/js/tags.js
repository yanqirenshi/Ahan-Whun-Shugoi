riot.tag2('app', '<network-graph nodes="{_NODES}" edges="{_LINKS}"></network-graph>', '', '', function(opts) {
     window.addEventListener('resize', function (event) {
         this.update();
     }.bind(this));

     ACTIONS.fetchAws();
     ACTIONS.fetchCommand(31);
     ACTIONS.fetchSubcommand(316);
     ACTIONS.fetchOption(312);
});

riot.tag2('network-graph', '<svg ref="svg"></svg>', 'network-graph { width: 100%; height: 100%; display: block; background: rgba(252, 226, 196, 0.33); }', 'ref="self"', function(opts) {
     this.resizeSvg = function () {
         let self = this.refs.self;
         let svg = this.refs.svg;

         svg.setAttribute('height', self.clientHeight + 'px');
         svg.setAttribute('width',  self.clientWidth  + 'px');
     };

     this.graph = new NetworkGraph();

     this.on('mount', function () {
         var svg = d3.select("network-graph svg");

         if (!svg) return;

         if ((!this.opts.nodes || this.opts.nodes.length==0) &&
             !this.opts.edges || this.opts.edges.length==0)
             return;

         this.graph.setSvg(svg);
         this.graph.setNodes(this.opts.nodes);
         this.graph.setEdges(this.opts.edges);
         this.graph.draw();

         this.resizeSvg();
     }.bind(this));
});
