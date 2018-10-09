class D3Base {
    constructor(reducer) {}
    draw(d3svg) {
        let gropus = [
            {_id:-1, name: 'rules'},
            {_id:-2, name: 'edges'},
            {_id:-3, name: 'nodes'}
        ];

        d3svg.Svg()
            .selectAll('g.data-group')
            .data(gropus, this._id)
            .enter()
            .append('g')
            .attr('class', (d)=>{
                return 'data-group ' + d.name;
            });
    }
}
