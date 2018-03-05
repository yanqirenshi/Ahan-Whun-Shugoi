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
     this.resizeSvg = function () {
         let self = this.refs.self;
         let svg = this.refs.svg;

         svg.setAttribute('height', self.clientHeight + 'px');
         svg.setAttribute('width',  self.clientWidth  + 'px');
     };

     this.on('update', function () { this.resizeSvg() }.bind(this));
     this.on('mount', function () { this.resizeSvg() }.bind(this));
    </script>
</network-graph>
