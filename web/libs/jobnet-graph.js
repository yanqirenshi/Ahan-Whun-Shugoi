class NetworkGraph {
    constructor(x, y, w, h) {
        this.svg = null;
        this.nodes = [];
        this.edges = [];
        this.x = x ? x : 0;
        this.y = y ? y : 0;
        this.w = w ? w : 0;
        this.h = h ? h : 0;
        this.scale = 1;
        this.drag = null;
    }
    setSize (w,h) {
        this.w = w ? w : 0;
        this.h = h ? h : 0;
    }
    refreshViewBox () {
        var scale = this.scale;
        var x = this.x,
            y = this.y;
        var orgW = this.w,
            orgH = this.h;
        var w = Math.floor(orgW * scale),
            h = Math.floor(orgH * scale);

        var viewbox = ''
                + (x + Math.floor((orgW - w)/2)) + ' '
                + (y + Math.floor((orgH - h)/2)) + ' '
                + w + ' '
                + h;

        this.svg.attr('viewBox', viewbox);
    }
    setCallbacks (callbacks) {
        if (this.callbacks)
            this.callbacks = callbacks;
        else
            this.callbacks = {};
    }
    setSvg (svg) {
        this.svg = svg;

        this.svg.call(d3.drag()
                      .on('start', function () {
                          this.drag = {
                              x: d3.event.x,
                              y: d3.event.y
                          };
                      }.bind(this))
                      .on("drag", function (d, i) {
                          var startX = this.drag.x,
                              startY = this.drag.y;
                          var x = d3.event.x,
                              y = d3.event.y;

                          this.x -= (x - startX);
                          this.y -= (y - startY);
                          this.drag.x = x;
                          this.drag.y = y;

                          this.refreshViewBox();
                      }.bind(this))
                      .on('end', function (d, i) {
                          this.drag = null;
                      }.bind(this)));

        this.svg.call(d3.zoom().on("zoom", function () {
                var transform = d3.event.transform;
                this.scale = transform.k;
                this.refreshViewBox();
            }.bind(this)));
    }
    setNodes (data) { this.nodes=data; }
    setEdges (data) { this.edges=data; }
    draw() {
        this.drawEdges(this.svg);
        this.drawNods(this.svg);
    }
    getNode (id) {
        for (var i in this.nodes)
            if (this.nodes[i]._id == id)
                return this.nodes[i];
        return null;
    }
    moveNode (node) {
        d3.select(node).attr("transform", function(d,i){
            return 'translate(' + [ d.x,d.y ] + ')';
        });

        var self = this;
        d3.selectAll('line.edge')
            .attr('x1', function (d) { return self.getNode(d['from-id']).x; })
            .attr('x2', function (d) { return self.getNode(d['to-id']).x; })
            .attr('y1', function (d) { return self.getNode(d['from-id']).y; })
            .attr('y2', function (d) { return self.getNode(d['to-id']).y; })
            .attr('stroke-dasharray', function (d) {
                var x1 = self.getNode(d['from-id']).x;
                var y1 = self.getNode(d['from-id']).y;
                var x2 = self.getNode(d['to-id']).x;
                var y2 = self.getNode(d['to-id']).y;
                var r = 30;
                var v = Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
                return '0, ' + r + ', ' + (Math.floor(v) - r*2) + ', ' + r;
            });

        d3.selectAll('text.edge')
            .attr("transform", function (d) {
                var x1 = self.getNode(d['from-id']).x;
                var y1 = self.getNode(d['from-id']).y;
                var x2 = self.getNode(d['to-id']).x;
                var y2 = self.getNode(d['to-id']).y;
                var x = (x2 - x1)/2 + x1;
                var y = (y2 - y1)/2 + y1;
                return "translate(" + x + "," + y + ")";
            });
    }
    drawNods (svg) {
        var g = svg
                .selectAll('g.node')
                .data(this.nodes)
                .enter()
                .append('g')
                .attr('class', 'node')
                .attr("transform", function (d) {
                    return "translate(" + d.x + "," + d.y + ")";
                });

        g.append('circle')
            .attr('r', function (d) {return 30;})
            .attr('fill', '#fff')
            .attr("stroke-width", 5)
            .attr("stroke","#eee");

        g.append('text')
            .text(function (d) {
                return d._id + ': ' + d.name;
            })
            .attr('text-anchor', "middle")
            .attr('dy', '.35em')
            .attr('fill', 'black');

        var self = this;
        g.call(d3.drag()
               .on("drag", function (d, i) {
                   d.x += d3.event.dx;
                   d.y += d3.event.dy;
                   self.moveNode(this);
               })
               .on('start', function () {
               })
               .on('end', function (d, i) {
                   if (self.callbacks.saveNodePosition)
                       self.callbacks.saveNodePosition(d);
               }));
    }
    defEdgeMarker (svg) {
        var marker = svg.append("defs")
                .append("marker")
                .attr('id', "arrowhead")
                .attr('refX', 15)
                .attr('refY', 2)
                .attr('markerWidth', 8)
                .attr('markerHeight', 8)
                .attr('orient', 'auto');
        marker.append("path")
            .attr('d', "M 0,0 V 4 L4,2 Z")
            .attr('fill', "#bbb");
    }
    drawEdges (svg) {
        var getNode = function(id) {
            for (var i in this.nodes)
                if (this.nodes[i]._id == id)
                    return this.nodes[i];
            return null;
        }.bind(this);

        this.defEdgeMarker(svg);

        var g = svg
                .selectAll('g.edge')
                .data(this.edges)
                .enter()
                .append('g')
                .attr('class', 'edge');

        g.append('line')
            .attr('class','edge')
            .attr('x1', function (d) { return getNode(d['from-id']).x; })
            .attr('x2', function (d) { return getNode(d['to-id']).x; })
            .attr('y1', function (d) { return getNode(d['from-id']).y; })
            .attr('y2', function (d) { return getNode(d['to-id']).y; })
            .attr('stroke', '#ccc')
            .attr('stroke-width', '3')
            .attr('stroke-dasharray', function (d) {
                var x1 = getNode(d['from-id']).x;
                var y1 = getNode(d['from-id']).y;
                var x2 = getNode(d['to-id']).x;
                var y2 =getNode(d['to-id']).y;
                var r = 30;
                var v = Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
                return '0, ' + r + ', ' + (Math.floor(v) - r*2) + ', ' + r;
            })
            .attr('stroke-dashoffset', 0)
            .attr('marker-end', "url(#arrowhead)");

        g.append('text')
            .text(function (d) {
                return ':' + d['edge-type'] + ', ' + d['relation'];
            })
            .attr('class','edge')
            .attr('text-anchor', "middle")
            .attr('dy', '.35em')
            .attr('fill', '#333')
            .attr("transform", function (d) {
                var x1 = getNode(d['from-id']).x;
                var y1 = getNode(d['from-id']).y;
                var x2 = getNode(d['to-id']).x;
                var y2 =getNode(d['to-id']).y;
                var x = (x2 - x1)/2 + x1;
                var y = (y2 - y1)/2 + y1;
                return "translate(" + x + "," + y + ")";
            });
    }
}
