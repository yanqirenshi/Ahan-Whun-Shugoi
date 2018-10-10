class Actions extends Vanilla_Redux_Actions {
    movePage (data) {
        return {
            type: 'MOVE-PAGE',
            data: data
        };
    }
    fetchAws (from) {
        let self = this;
        API.get('/aws', function (response) {
            STORE.dispatch(self.fetchedAws(response, from));
        });
    }
    fetchedAws (response, from) {
        let GraphUtil = new GraphUtility();

        let state = STORE.get('beach');

        let aws      = GraphUtil.mergeNodes([response.AWS],          state.aws);
        let commands = GraphUtil.mergeNodes(response.COMMANDS.NODES, state.commands);
        let options  = GraphUtil.mergeNodes(response.OPTIONS.NODES,  state.options);

        // let aws_state = { ht: {}, list: [aws]};
        // aws_state.ht[aws._id] = aws;
        // let r = GraphUtil.marge2(state.r,
        //                          [].concat(
        //                              GraphUtil.setEdgesDisplay(response.COMMANDS.RELATIONSHIPS, aws_state, commands),
        //                              GraphUtil.setEdgesDisplay(response.OPTIONS.RELATIONSHIPS, aws_state, options)));

        return {
            from: from,
            type: 'FETCHED-AWS',
            data: {
                beach: {
                    aws:      aws,
                    commands: commands,
                    options:  options,
                    // r: r
                }
            }
        };
    }
    fetchedAws_bk (response, from) {
        let GraphUtil = new GraphUtility();

        let state = STORE.get('beach');

        let aws = response.AWS;

        let commands = GraphUtil.marge2(state.commands,
                                        response.COMMANDS.NODES);
        let options = GraphUtil.marge2(state.options,
                                       response.OPTIONS.NODES);

        let aws_state = { ht: {}, list: [aws]};
        aws_state.ht[aws._id] = aws;
        let r = GraphUtil.marge2(state.r,
                                 [].concat(
                                     GraphUtil.setEdgesDisplay(response.COMMANDS.RELATIONSHIPS, aws_state, commands),
                                     GraphUtil.setEdgesDisplay(response.OPTIONS.RELATIONSHIPS, aws_state, options)));

        return {
            from: from,
            type: 'FETCHED-AWS',
            data: {
                beach: {
                    aws: aws,
                    commands: commands,
                    options: options,
                    r: r
                }
            }
        };
    }
}
