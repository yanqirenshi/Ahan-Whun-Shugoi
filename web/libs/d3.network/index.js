class Main {
    constructor (d3svg) {
        this.d3svg = d3svg;
        this.simulator = new D3Simulator().make();
    }
    refreshSvgSize () {
        let tag = this.refs.svg;

        tag.setAttribute('width',window.innerWidth);
        tag.setAttribute('height',window.innerHeight);
    }
    draw (nodes, edges, rules) {
        if (!this.d3svg)
            return;

        let d3svg = this.d3svg;

        new D3Base().draw(d3svg);
        new D3Nodes().draw(d3svg,
                           nodes,
                           this.simulator,
                           (type, data) => { return; });
        new D3Edges().draw(d3svg, edges, this.simulator);
    }
}

function makeNode (id) {
    return {
        x: Math.floor(Math.random() * Math.floor(500)),
        y: Math.floor(Math.random() * Math.floor(500)),
        label: {
            text: 'XYZ-'+id,
            font: {
                size: 12
            }
        },
        circle: {
            r: 33,
            fill: '#eeeeee',
            stroke: {
                color: '#888888',
                width: 1
            }
        },
        _id: id,
        _class: 'XXX'
    };
}
function makeNodes (n) {
    let nodes = [];
    for (let i=1 ; i<n ; i++)
        nodes.push(makeNode(i));
    return nodes;
}

function makeEdge () {
    return {
        source: Math.floor(Math.random() * Math.floor(332)) + 1,
        target: Math.floor(Math.random() * Math.floor(332)) + 1
    };
}
function makeEdges (n) {
    let edges = [];
    for (let i=1 ; i<n ;i++)
        edges.push(makeEdge());
    return edges;
}

new Main(makeD3Svg())
    .draw({list: makeNodes(333)},
          {list: makeEdges(222)},
          null);
