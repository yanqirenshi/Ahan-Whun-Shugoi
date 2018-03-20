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
        let vec = {x: command.x - aws.x, y:command.y - aws.y};
        return subcommands.map(function (node) {
            if (node.x==0) node.x = vec.x + command.x;
            if (node.y==0) node.y = vec.y + command.y;
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
                        if (!(k=='x' || k=='y' || k=='z'))
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
}
