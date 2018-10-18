<page_beach_root>
    <svg id="beach-graph"></svg>

    <page_beach_inspector object={selectedObject}></page_beach_inspector>

    <script>
     this.gutil = new GraphUtility();

     this.d3svg = null;
     this.simulator = new D3Simulator().make();

     this.selectedObject = null;

     this.clickSvg = () => {
         this.selectedObject = null;
         this.tags['page_beach_inspector'].update();
     };

     this.clickNode = (data, e, action) => {
         if ('click-circle'!=action) return;

         this.selectedObject = data;

         this.tags['page_beach_inspector'].update();
     };

     this.on('mount', () => {
         this.d3svg = this.gutil.makeD3Svg('beach-graph', {
             clickSvg: this.clickSvg,
         });

         this.gutil.drawBase(this.d3svg);

         ACTIONS.fetchAws();
     });

     STORE.subscribe((action) => {
         if (action.type=='SWITCHED-DISPLAY') {
             this.tags['page_beach_inspector'].update();
             this.draw(this.d3svg);
             return;
         }


         if (action.type=='FETCHED-AWS') {
             ACTIONS.fetchCommandsAtDisplayed();
             return;
         }

         if (action.type=='FETCHED-COMMANDS-AT-DISPLAYED') {
             ACTIONS.fetchSubcommandsAtDisplayed();
             return;
         }

         if (action.type=='FETCHED-SUBCOMMANDS-AT-DISPLAYED') {
             this.draw(this.d3svg);
             return;
         }

         if (action.type=='FETCHED-OPTIONS-AT-DISPLAYED') {
             this.draw(this.d3svg);
             return;
         }
     });

     this.draw = (d3svg) => {
         if (!d3svg)
             return;

         let state = STORE.get('beach')

         // 表示するノードのみに絞る。
         let nodes = { ht: {}, list: [] };
         new GraphNode().filterDisplay(nodes, state.aws.list);
         new GraphNode().filterDisplay(nodes, state.commands.list);

         // 表示していないノードのエッジは除外する。
         let edges = { ht: {}, list: [] };
         new GraphEdge().filterDisplay(edges, nodes, state.r.list);

         new D3Nodes().draw(d3svg, nodes, this.simulator, this.clickNode);
         new D3Edges().draw(d3svg, edges, this.simulator);
     };
    </script>
</page_beach_root>
