class NetworkGraphUtil {
    jiggle () {
        return Math.floor((Math.random() - 0.5) * 1000);
        // return (Math.random() - 0.5) * 1e-6 * 100;
    }
    initCommans (aws, commands) {
        return commands.map(function (node) {
            node = this.setDefaultPoint(node);
            node._parent = aws;
            return node;
        }.bind(this));
    }
    initSubcommands (command, subcommands) {
        let aws = command._parent;
        let vec = {x: command.location.x - aws.location.x, y:command.location.y - aws.location.y};
        return subcommands.map(function (node) {
            if (node.x==0) node.location.x = vec.x + command.location.x;
            if (node.y==0) node.location.y = vec.y + command.location.y;
            node._parent = command;
            return node;
        }.bind(this));
    }
    setDefaultPoint (node) {
        if (node.x == 0 && node.y == 0 && node.z == 0) {
            node.x = this.jiggle();
            node.y = this.jiggle();
            node.z = this.jiggle();
        }
        return node;
    }
    marge2 (state, add_list) {
        let state_ht = state.ht;
        let state_list = state.list;
        for (var i in add_list) {
            let data = add_list[i];

            let state_data = state_ht[data._id];

            if (state_data) {
                this.setObjectValues(data, state_data);
            } else {
                state_ht[data._id] = data;
                state_list.push(data);
            }
        }
        return {
            ht: state_ht,
            list: state_list
        };
    }
    marge (old_list, new_list)  {
        let sorter = function (a, b) { return b._id - a._id; };
        let old_list_sorted = old_list.sort(sorter);
        let new_list_sorted = new_list.sort(sorter);

        let old_data = old_list_sorted.pop();
        let new_data = new_list_sorted.pop();
        let out = [];
        do {
            if (!old_data && new_data) {
                out.push(new_data);
                new_data = new_list_sorted.pop();
            } else if (old_data && !new_data) {
                out.push(old_data);
                old_data = old_list_sorted.pop();
            } else if (old_data && new_data) {
                if (old_data._id == new_data._id) {
                    for (var k in new_data)
                        old_data[k] = new_data[k];
                    out.push(old_data);
                    new_data = new_list_sorted.pop();
                    old_data = old_list_sorted.pop();
                } else if (old_data._id < new_data._id) {
                    out.push(new_data);
                    new_data = new_list_sorted.pop();
                } else if (old_data._id > new_data._id) {
                    out.push(old_data);
                    old_data = old_list_sorted.pop();
                }
            }
        } while(old_data || new_data);
        return out;
    }
    node_list2ht (list, ht) {
        for (var i in list) {
            let key = list[i]._id;
            ht[key] = list[i];
        }
        return ht;
    }
    edge_list2ht (parent_node, child_nodes_ht, edges, ht_r) {
        for (var i in edges) {
            let edge = edges[i];
            let child_node = child_nodes_ht[edge['to-id']];
            ht_r[edge._id] = edge;
            edge.display = parent_node.display && child_node.display;
        }
        return ht_r;
    }
    filterElements (elements) {
        return elements.filter(function (element) {
            return element.display;
        });
    }
    setEdgesDisplay (edges, fron_nodes, to_nodes) {
        for (var i in edges) {
            let edge = edges[i];
            let from_node = fron_nodes.ht[edge['from-id']];
            let to_node = to_nodes.ht[edge['to-id']];
            if (from_node && to_node)
                this.setEdgeDisplay(edge,from_node,to_node);
        }
        return edges;
    }
    setEdgeDisplay (edge, from_node, to_node) {
        edge.display = (from_node.display && to_node.display);
        return edge;
    }
    setObjectValues (from, target) {
        for (var key in from)
            target[key] = from[key];
        return target;
    }
    setCommandValues (from, target) {
        this.setObjectValues(from, target);
    }
    draw (graph, nodes, edges) {
         graph.setNodes(nodes);
         graph.setEdges(edges);
         graph.draw();
    }
    drawFirst (graph, svg_d3, svg_tag, base_tag, nodes, edges) {
         graph.setSvg(svg_d3);
         graph.resizeSvg(svg_tag,
                              base_tag.clientWidth,
                              base_tag.clientHeight);
         graph.initViewBox(svg_tag);

         if ((!nodes || nodes.length==0) &&
             !edges || edges.length==0)
             return;

        this.draw(nodes, edges);
    }
}
