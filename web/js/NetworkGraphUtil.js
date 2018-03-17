class NetworkGraphUtil {
    jiggle () {
        return Math.floor((Math.random() - 0.5) * 1000);
        // return (Math.random() - 0.5) * 1e-6 * 100;
    }
    makeNodeDataAWS (aws) {
        let out = [];
        if (aws) {
            out.push({
                _id: aws._id,
                name: aws.code,
                description: aws.description,
                x: 0,
                y: 0,
                _class: aws._class
            });
        }
        return out;
    }
    makeNodeDataCommands (commands) {
        let out = [];
        for (var i in commands) {
            let command = commands[i];
            out.push({
                _id: command._id,
                name: command.code,
                description: command.description,
                x: this.jiggle(),
                y: this.jiggle(),
                _class: command._class
            });
        }
        return out;
    }
    makeNodeDataSubcommands (subcommands) {
        let out = [];
        for (var i in subcommands) {
            let subcommand = subcommands[i];
            out.push({
                _id: subcommand._id,
                name: subcommand.code,
                description: subcommand.description,
                x: this.jiggle(),
                y: this.jiggle(),
                _class: subcommand._class
            });
        }
        return out;
    }
    makeNodeDataOptions (options) {
        let out = [];
        for (var i in options) {
            let option = options[i];
            out.push({
                _id: option._id,
                name: option.code,
                description: '',
                x: this.jiggle(),
                y: this.jiggle(),
                _class: options._class
            });
        }
        return out;
    }
    makeEdgeData (vertex) {
    }
    marge (old_list, new_list)  {
        let sorter = function (a, b) { return a._id < b._id; };
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
                    out.push(new_data);
                    out.push(old_data);
                    new_data = new_list_sorted.pop();
                    old_data = old_list_sorted.pop();
                } else if (old_data._id < new_data._id) {
                    out.push(new_data);
                    new_data = new_list_sorted.pop();
                } else if (old_data._id < new_data._id) {
                    out.push(old_data);
                    old_data = old_list_sorted.pop();
                }
            }
        } while(old_data || new_data);
        return out;
    }
}
