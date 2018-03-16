<app>
    <network-graph nodes={_NODES} edges={_LINKS}></network-graph>

    <script>
     window.addEventListener('resize', function (event) {
         this.update();
     }.bind(this));

     ACTIONS.fetchAws();
     ACTIONS.fetchCommand(31);
     ACTIONS.fetchSubcommand(316);
     ACTIONS.fetchOption(312);
    </script>
</app>
