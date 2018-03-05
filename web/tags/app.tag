<app>
    <network-graph nodes={_NODES} edges={_LINKS}></network-graph>

    <script>
     window.addEventListener('resize', function (event) {
         this.update();
     }.bind(this));
    </script>
</app>
