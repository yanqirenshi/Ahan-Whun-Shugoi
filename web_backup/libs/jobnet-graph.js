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
        this.callbacks = {};
    }
    setSize (w,h) {
        this.w = w ? w : 0;
        this.h = h ? h : 0;
    }
    /**
     * svg_tag の viewBox を (0,0) を中心としたものに移動する。
     */
    initViewBox(svg_tag) {
         let h = svg_tag.clientHeight;
         let w = svg_tag.clientWidth;
        this.x = Math.floor(w/2 * -1);
        this.y = Math.floor(h/2 * -1);
        this.refreshViewBox();
    }
    /**
     * svt_tag と d3 的な w と h を変更する。
     */
    resizeSvg(svg_tag, w, h) {
        this.setSize(w, h);

         svg_tag.setAttribute('height', h + 'px');
         svg_tag.setAttribute('width',  w  + 'px');
    }
    /**
     * なんやったか忘れる。setSvgからコールされているので viewBox の初期設定的なものか？
     */
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
    /**
     * callbacks を一括で設定する。連想配列を渡す感じ。個別に追加出来るように回収しても良いね。
     */
    setCallbacks (callbacks) {
        if (this.callbacks)
            this.callbacks = callbacks;
        else
            this.callbacks = {};
    }
    /**
     * こんな感じで使うよ。 setSvg(d3.select("network-graph svg"));
     */
    setSvg (svg) {
        let self = this;
        this.svg = svg;
        this.svg.call(d3.drag()
                      .on('start', function () { self.setSvgGrabMoveStart(d3.event); })
                      .on("drag",  function (d, i) { self.setSvgGrabMoveDrag(d3.event); })
                      .on('end',   function (d, i) { self.setSvgGrabMoveEnd(); }));

        this.svg.call(d3.zoom().on("zoom", function () { self.setSvgGrabZoom(d3.event); }));
    }
    setSvgGrabMoveStart (event) {
        this.drag = {
            x: event.x,
            y: event.y
        };
    }
    setSvgGrabMoveDrag (event) {
        var startX = this.drag.x,
            startY = this.drag.y;
        var x = event.x,
            y = event.y;

        this.x -= (x - startX);
        this.y -= (y - startY);
        this.drag.x = x;
        this.drag.y = y;

        this.refreshViewBox();
    }
    setSvgGrabMoveEnd () {
        this.drag = null;
    }
    setSvgGrabZoom (event) {
        let transform = event.transform;
        this.scale = transform.k;
        this.refreshViewBox();
    }
    /**
     * 単純な setter
     */
    setNodes (data) { this.nodes=data; }
    /**
     * 単純な setter
     */
    setEdges (data) { this.edges=data; }
    /**
     * _id で node を取得する。
     */
    getNode (id) {
        for (var i in this.nodes)
            if (this.nodes[i]._id == id)
                return this.nodes[i];
        return null;
    }
    /**
     * node を移動する処理だったと思う。
     */
    moveNode (node) {
        d3.select(node).attr("transform", function(d,i){
            return 'translate(' + [ d.x,d.y ] + ')';
        });
        this.moveNode_redrawEd();
    }
    moveNode_redrawEd () {
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
    /**
     * Edge の描画しとる。 Node のは無いのな。
     */
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
    draw() {
        this.drawEdges(this.svg);
        this.drawNods(this.svg);
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

        svg.selectAll('g.node').on("dblclick", function(node_data) {
            if (self.callbacks.doubleClickNode)
                self.callbacks.doubleClickNode(node_data);
        });
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
                let type = d['edge-type'] ? ':' + d['edge-type'] : '';
                let relation = d['relation'] ? d['relation'] : '';
                let sep = (type.length > 0 && relation.length > 0) ? ', ' : '';
                return type + sep + relation;
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
