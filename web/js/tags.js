riot.tag2('app', '<network-graph></network-graph>', '', '', function(opts) {
     window.addEventListener('resize', function (event) {
         this.update();
     }.bind(this));
});

riot.tag2('network-graph', '<svg ref="svg"></svg>', 'network-graph { width: 100%; height: 100%; display: block; background: rgba(252, 226, 196, 0.33); }', 'ref="self"', function(opts) {
     this.resizeSvg = function () {
         let self = this.refs.self;
         let svg = this.refs.svg;

         svg.setAttribute('height', self.clientHeight + 'px');
         svg.setAttribute('width',  self.clientWidth  + 'px');
     };

     this.on('update', function () { this.resizeSvg() }.bind(this));
     this.on('mount', function () { this.resizeSvg() }.bind(this));
});
