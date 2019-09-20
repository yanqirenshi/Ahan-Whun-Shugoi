const AWS_STRUCTURES_OPERATORS = [
    { _id: 1, package: 'AHAN-WHUN-SHUGOI.CLI', type: 'FUNCTION', name: 'AWS',                    description: '' },
    { _id: 2, package: 'AHAN-WHUN-SHUGOI.DB',  type: 'FUNCTION', name: 'START',                  description: '' },
    { _id: 3, package: 'AHAN-WHUN-SHUGOI.DB',  type: 'FUNCTION', name: 'STOP',                   description: '' },
    { _id: 6, package: 'AHAN-WHUN-SHUGOI.CLI', type: 'FUNCTION', name: '*PRINT-COMMAND-STREAM*', description: '' },
];

class AWS_STRUCTURES_CLASS {
    nodes () {
        return AWS_STRUCTURES_OPERATORS.map((d)=>{
            return Object.assign({},d);
        });
    }
    build () {
        return {
            nodes: this.nodes(),
            edges: [],
        };
    }
};

const AWS_STRUCTURES = new AWS_STRUCTURES_CLASS().build();
