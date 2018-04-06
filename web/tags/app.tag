<app>
    <beach nodes={this.nodes()} edges={this.links()}></beach>
    <selector></selector>

    <cosmos></cosmos>

    <menu></menu>

    <script>
     window.addEventListener('resize', (event) => {
         this.update();
     });

     this.nodes = function () {
         let state = STORE.state().beach;
         let aws = state.aws ? [state.aws] : [];
         /*
          * 1. options は edge で display をコントロールする。
          * 2. edge で display==true のものを抽出する。
          * 3. edge から node のデータを作り出す。
          * 4. それを concat して渡す。
          */
         return aws.concat(GraphUtil.filterElements(state.options.list))
                   .concat(GraphUtil.filterElements(state.commands.list))
                   .concat(GraphUtil.filterElements(state.subcommands.list));
     }

     this.links = function () {
         let state = STORE.state().beach;
         return GraphUtil.filterElements(state.r.list);
     };

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-AWS')
             this.update();
     });

     // LOAD FIRST
     ACTIONS.fetchFinders('APP');
     ACTIONS.fetchAws('APP');

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-AWS' && action.from=='APP')
             return ACTIONS.fetchCommands('APP');

         if (action.type=='FETCHED-COMMANDS' && action.from=='APP')
             return ACTIONS.fetchSubcommands('APP');
     });
     STORE.subscribe((action) => {
         let update = [
             'FETCHED-SUBCOMMANDS',
             'UPDATED-COMMAND-DISPLAY',
             'UPDATED-SUBCOMMAND-DISPLAY',
             'UPDATED-OPTION-DISPLAY'
         ].find(function (v) { return v==action.type; }) ;
         if (update)
             this.update();
     });
    </script>
</app>
