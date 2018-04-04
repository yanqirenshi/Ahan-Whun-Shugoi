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

     this.getSelectedFinder = () => {
         let state = STORE.state().beach.finders;
         return state.list.find((f) => {
             return f.code == state.select;
         });
     };

     this.graph.setCallbacks({
         moveEndSvg: (look_at) => {
             ACTIONS.updateFinderLookAt(this.getSelectedFinder(), look_at);
         },
         zoomSvg: (scale) => {
             ACTIONS.updateFinderScale(this.getSelectedFinder(), scale);
         },
         clickSvg: () => {
             STORE.dispatch(ACTIONS.switchSelector(null));
         },
         saveNodePosition: (data) => {
             if (data._class=='COMMAND')
                 ACTIONS.updateCommandLocation(data._id, data.location);
             if (data._class=='SUBCOMMAND')
                 ACTIONS.updateSubcommandLocation(data._id, data.location);
             if (data._class=='OPTION')
                 ACTIONS.updateOptionLocation(data._id, data.location);
         },
         clickNode: (data) => {
             STORE.dispatch(ACTIONS.switchSelector(data));
             STORE.dispatch(ACTIONS.switchSelectorTab(null));
             d3.event.stopPropagation();
         },
         doubleClickNode: (data) => {
             d3.event.stopPropagation();
         }
     })

     this.on('mount', function () {
         let svg_d3 = d3.select("network-graph svg");

         if (!svg_d3) return;

         GraphUtil.drawFirst (this.graph,
                              svg_d3,
                              this.refs.svg,
                              this.refs.self,
                              this.opts.nodes,
                              this.opts.edges);
     }.bind(this));

     this.on('update', function () {
         GraphUtil.draw(this.graph,
                        this.opts.nodes,
                        this.opts.edges);
     }.bind(this));

     STORE.subscribe((action) => {
         if ((action.type=='FETCHED-FINDERS' && action.from=='APP') ||
             action.type=='CLICK-FINDER') {
             let state = STORE.state().beach.finders;
             let finder = state.list.find((finder) => {
                 return finder.code == state.select;
             });
             this.graph.setLookAt({
                 _x: finder['look-at'].X,
                 _y: finder['look-at'].Y,
                 _z: finder['look-at'].Z
             });
             this.graph.setScale(finder.scale);
             this.graph.refreshViewBox();

             return this.update();
         }
     })

    </script>
</network-graph>
