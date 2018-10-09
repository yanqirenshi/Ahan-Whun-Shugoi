<api_page_root>
    <section-header title="API"></section-header>

    <section class="section">
        <div class="container">
            <h1 class="title">Description</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title">Operators</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Method</th>
                            <th>Path</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr each={apis}>
                            <td>{method.toUpperCase()}</td>
                            <td>{path.toLowerCase()}</td>
                            <td>{description}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <section-footer></section-footer>

    <script>
     this.apis = [
         // ここは利用していないかも。
         { method: 'get',  path: '/vertex/aws',                      description: 'AWSを取得します。' },
         { method: 'get',  path: '/vertex/commands',                 description: 'コマンドを全て取得します。' },
         { method: 'get',  path: '/vertex/commands/:_id',            description: 'コマンドを取得します。IDで指定したコマンドを取得します。' },
         { method: 'get',  path: '/vertex/subcommands',              description: 'サブコマンドを全て取得します。' },
         { method: 'get',  path: '/vertex/subcommands/:_id',         description: 'サブコマンドを取得します。IDで指定したサブコマンドを取得します。' },
         { method: 'get',  path: '/vertex/options/:_id',             description: 'コマンドの一覧を取得します。' },
         // 以下を利用してそう。
         { method: 'get',  path: '/aws',                             description: 'AWSを取得します。' },
         { method: 'get',  path: '/aws/options',                     description: 'AWSのオプションを全て取得します。' },
         { method: 'get',  path: '/aws/commands',                    description: 'AWSのコマンドを全て取得します。 GET /vertex/commands と被っていますね。。' },
         { method: 'get',  path: '/commands/:_id/subcommands',       description: '' },
         { method: 'get',  path: '/commands/:_id/display/:value',    description: '' },
         { method: 'post', path: '/commands/:_id/location',          description: '' },
         { method: 'get',  path: '/subcommands/:_id/options',        description: '' },
         { method: 'get',  path: '/subcommands/:_id/display/:value', description: '' },
         { method: 'post', path: '/subcommands/:_id/location',       description: '' },
         { method: 'get',  path: '/options/:_id/display/:value',     description: '' },
         { method: 'post', path: '/options/:_id/location',           description: '' },
         // finder は複数登録できる。
         { method: 'get',  path: '/finders',                         description: '登録されている Finder を全て返します。' },
         { method: 'post', path: '/finders/:code/look-at',           description: 'Finder の位置を保管します。' },
         { method: 'post', path: '/finders/:code/scale',             description: 'Finder の拡大設定を保管します。' },
     ];
    </script>
</api_page_root>
