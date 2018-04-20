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
         dump(this.d3svg);
         this.d3svg.setSize(width, height);

         var svg = this.d3svg._svg;

         /* make node data */
         let d3force = new D3Force({
             node_padding: 2.5 * 10
         });

         /* draw elements */
         function makeD3fData (data) {
             function types(d) {
                 let sizeDivisor = 100;

                 d.gdp = +d.gdp;
                 d.size = +d.gdp / sizeDivisor;
                 d.size < 3 ? d.radius = 3 : d.radius = d.size;
                 return d;
             }
             return data.map(types)
                        .sort(function(a,b){ return b.size - a.size; });;
         }

         let graph = d3force.makeNodeDatas(makeD3fData(DATA));
         let nodes = d3force.drawNodes(svg, graph);
         d3force.setNodesCallbacks(nodes);

         /* sumilation */
         d3force.makeSimulation(width, height);
         d3force.makeCollide();
         d3force.start(graph, nodes);
     });
    </script>
</cosmos>
