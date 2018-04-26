<cosmos ref="self">
    <svg></svg>

    <style>
     cosmos {
         width: 100%;
         height: 100%;
         display: block;
         background: rgba(0,0,0,0.9);
     }
    </style>

    <script>
     this.on('mount', () => {
         let base_tag = this.refs.self;
         this.d3svg = new D3Svg({
             svg: d3.select("cosmos svg"),
             x: 0,
             y: 0,
             w: base_tag.clientWidth,
             h: base_tag.clientHeight,
             scale: 1
         });
     })

     this.on('update', () => {
         let base_tag = this.refs.self;
         let width = this.refs.self.clientWidth;
         let height = this.refs.self.clientHeight;

         this.d3svg.setSize(width, height);

         var svg = this.d3svg._svg;

         /* make node data */
         /* let d3force = new D3Force({
          *     node_padding: 2.5 * 10
          * });*/

         /* draw elements */
         /* let node_data = STORE.state().cosmos.ec2.instances.list;
          * let graph = d3force.makeNodeDatas(node_data);
          * let nodes = d3force.drawNodes(svg, graph);
          * d3force.setNodesCallbacks(nodes);*/

         /* sumilation */
         /* d3force.makeSimulation(width, height);
          * d3force.makeCollide();
          * d3force.start(graph, nodes);*/
     });
    </script>
</cosmos>
