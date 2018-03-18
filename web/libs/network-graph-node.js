class NetworkGraphNode {
    drawGtags (svg, nodes) {
        return svg
            .selectAll('g.node') // <g class="node"> なタグ全部を取得する。
            .data(
                // 取得した g タグにデータをバインドします。
                // ここではまだタグは出来てないよ。
                // d3 上に空オブジェクトを作るだけ。
                nodes, function (data) {
                    return data._id;
                })
            .enter() // d3オブジェクトを作成する。
            .append('g') // g タグ と データをバインドする。ここで初めて g タグが描画される。
            .attr('class', 'node')
            .attr("transform", this.moveNode);
    }
    drawCircle (g) {
        g.append('circle')
            .attr('r', function (d) {return 30;})
            .attr('fill', '#fff')
            .attr("stroke-width", function (data) {
                return data.stroke.WIDTH;
            })
            .attr("stroke", function (data) {
                let color = data.stroke.COLOR;
                return "rgba(" + color.R +", "+color.G+", "+color.B+", "+color.A+")";
            });
        return this;
    }
    drawText (g) {
        g.append('text')
            .text(function (d) {
                return d._id + ': ' + d.name;
            })
            .attr('text-anchor', "middle")
            .attr('dy', '.35em')
            .attr('fill', 'black');
        return this;
    }
    settingDblClick (g, callbacks) {
        g.on("dblclick", function(node_data) {
            if (callbacks.doubleClickNode)
                callbacks.doubleClickNode(node_data);
        });
        return this;
    }
    settingGrabMoveNode (g, callbacks) {
        var self = this;
        g.call(d3.drag()
               .on("drag", function (d, i) {
                   d.x += d3.event.dx;
                   d.y += d3.event.dy;
                   callbacks.moveNode(this);
               })
               .on('start', function () {
               })
               .on('end', function (d, i) {
                   if (callbacks.saveNodePosition)
                       callbacks.saveNodePosition(d);
               }));
    }
    moveNode (data) {
        return "translate(" + data.x + "," + data.y + ")";
    }
}
