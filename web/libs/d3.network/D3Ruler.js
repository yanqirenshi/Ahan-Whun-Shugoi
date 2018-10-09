class D3Ruler {
    constructor() {}
    makeRules (length, pitch) {
        let start = length * -1;
        let end   = length;

        let x_data = [];
        let y_data = [];
        let _id = -1000;

        let axis = [
            { _id: _id--, x1: start, x2: end, y1: 0, y2: 0},
            { _id: _id--, x1: 0, x2: 0, y1: start, y2: end},
        ];

        for (var i=start ; i < end ; i+=pitch)
            x_data.push({ _id: _id--,
                          x1:i,
                          y1:start,
                          x2:i,
                          y2: end});

        for (var i=start ; i < end ; i+=pitch)
            y_data.push({ _id: _id--,
                          x1:start,
                          y1:i,
                          x2:end,
                          y2: i});

        return { axis: axis, roules: [].concat(x_data).concat(y_data) };
    };

    draw (d3svg, data) {

        let svg = d3svg.Svg();
        let background = svg.selectAll('g.data-group.rules');

        background.selectAll('line.grid')
            .data(data.roules, (d) => { return d._id; })
            .enter()
            .append('line')
            .attr('class', 'grid')
            .attr('x1', (d) => { return d.x1;})
            .attr('y1', (d) => { return d.y1;})
            .attr('x2', (d) => { return d.x2;})
            .attr('y2', (d) => { return d.y2;})
            .attr('stroke', '#888888')
            .attr('stroke-width', 0.3)
            .attr('stroke-dasharray', 3);

        background.selectAll('line.axis')
            .data(data.axis, (d) => { return d._id; })
            .enter()
            .append('line')
            .attr('class', 'axis')
            .attr('x1', (d) => { return d.x1;})
            .attr('y1', (d) => { return d.y1;})
            .attr('x2', (d) => { return d.x2;})
            .attr('y2', (d) => { return d.y2;})
            .attr('stroke', '#333333')
            .attr('stroke-width', 3);
    }
}
