<page_beach_inspector-command-subcommands>
    <page_beach_inspector-display-controller
        objects={opts.subcommands}
        callback={opts.callback}></page_beach_inspector-display-controller>


    <script>
     this.on('update', () => {
         dump(this.opts)
     });
    </script>
</page_beach_inspector-command-subcommands>
