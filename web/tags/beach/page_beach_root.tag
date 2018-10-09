<page_beach_root>
    <svg id="beach-graph"></svg>

    <script>
     this.d3svg = null;
     this.simulator = new D3Simulator().make();


     this.on('mount', () => {
         this.d3svg = this.makeD3Svg();

         let rules = new D3Ruler().makeRules(8000, 500);

         this.draw(this.d3svg, {ht:{}, list:[]}, {ht:{}, list:[]}, rules);
     });

     refreshSvgSize () {
         let tag = this.refs.svg;

         tag.setAttribute('width',window.innerWidth);
         tag.setAttribute('height',window.innerHeight);
     }

     this.makeD3Svg = () => {
         let w = window.innerWidth;
         let h = window.innerHeight;

         let svg_tag = document.getElementById('beach-graph');
         svg_tag.setAttribute('height',h);
         svg_tag.setAttribute('width',w);

         let d3svg = new D3Svg({
             d3: d3,
             svg: d3.select("#beach-graph"),
             x: 0,
             y: 0,
             w: w,
             h: h,
             scale: 1
         });

         return d3svg;
     };


     this.draw = (d3svg, nodes, edges, rules) => {
         if (!d3svg)
             return;

         new D3Base().draw(d3svg);

         new D3Ruler().draw(d3svg, rules);

         new D3Nodes().draw(d3svg,
                            nodes,
                            this.simulator,
                            (type, data) => { return; });

         new D3Edges().draw(d3svg, edges, this.simulator);
     };
    </script>
</page_beach_root>
