<page_beach_root>
    <svg id="beach-graph"></svg>

    <page_beach_inspector></page_beach_inspector>

    <script>
     this.gutil = new GraphUtility();

     this.d3svg = null;
     this.simulator = new D3Simulator().make();

     this.on('mount', () => {
         this.d3svg = this.gutil.makeD3Svg('beach-graph');

         this.gutil.drawBase(this.d3svg);

         ACTIONS.fetchAws();
     });

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-AWS')
             this.draw(this.d3svg);
     });

     this.draw = (d3svg) => {
         if (!d3svg)
             return;

         let state = STORE.get('beach')

         let nodes = {
             ht: Object.assign({}, state.aws.ht, state.commands.ht),
             list: [].concat(state.aws.list).concat(state.commands.list)
         }

         // 表示していないノードのエッジは除外する。
         let edges = { ht: {}, list: [] };
         let nodes_ht = nodes.ht;
         for (var i in state.r.list) {
             let r = state.r.list[i];

             if (!(nodes_ht[r.source] && nodes_ht[r.target]))
                 continue;

             edges.ht[r._id] = r;
             edges.list.push(r);
         }

         new D3Nodes().draw(d3svg, nodes, this.simulator, (type, data) => {
             return;
         });

         new D3Edges().draw(d3svg, edges, this.simulator);
     };
    </script>
</page_beach_root>
