<page_beach_inspector-aws-commands>
    <page_beach_inspector-display-controller objects={opts.commands}
                                             callback={opts.callback}></page_beach_inspector-display-controller>

    <script>
     STORE.subscribe((action) => {
         if (action.type=='SWITCHED-DISPLAY' && action.data_type=='COMMAND') {
             this.update();
             return;
         }
     });
    </script>
</page_beach_inspector-aws-commands>
