class NetworkGraphEdge {
    drawGtags (svg, edges) {
        return svg
            .selectAll('g.edge')
            .data(edges)
            .enter()
            .append('g')
            .attr('class', 'edge');
    }
    drawDefs (svg) {
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
        return this;
    }
    drawLine (g, getNode) {
        g.append('line')
            .attr('class','edge')
            .attr('x1', function (d) { return getNode(d['from-id']).x; })
            .attr('x2', function (d) { return getNode(d['to-id']).x; })
            .attr('y1', function (d) { return getNode(d['from-id']).y; })
            .attr('y2', function (d) { return getNode(d['to-id']).y; })
            .attr('stroke', function (d) {
                let color = d.stroke.COLOR;
                return "rgba(" + color.R +", "+color.G+", "+color.B+", "+color.A+")";
            })
            .attr('stroke-width', function (d) { return d.stroke.WIDTH; })
            .attr('stroke-dasharray', function (d) {
                var x1 = getNode(d['from-id']).x;
                var y1 = getNode(d['from-id']).y;
                var x2 = getNode(d['to-id']).x;
                var y2 =getNode(d['to-id']).y;
                var r = 35;
                var v = Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
                return '0, ' + r + ', ' + (Math.floor(v) - r*2) + ', ' + r;
            })
            .attr('stroke-dashoffset', 0)
            .attr('marker-end', "url(#arrowhead)");

        return this;
    }
    drawText (g, getNode){
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
        return this;
    }
}
