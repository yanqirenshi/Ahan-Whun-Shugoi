class D3Simulator {
    constructor(reducer) {}
    make() {
        let simulation = d3.forceSimulation()
            .force("link", d3.forceLink().id(function(d) { return d._id; }))
            .force("charge", d3.forceManyBody())
            //.force("center", d3.forceCenter(0, 0))
            .alphaMin(0.001)
            .alphaTarget(0.002)
            .force("collide", d3.forceCollide(88));

        simulation.force("charge")
            .strength(function() { return -0.8; });

        return simulation;

    }
}
