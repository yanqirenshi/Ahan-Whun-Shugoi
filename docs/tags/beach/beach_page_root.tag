<beach_page_root>
    <section-header title="Beach"></section-header>

    <section class="section">
        <div class="container">
            <h1 class="title">Description</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
                <p>Under the paving stone the beach というスローガン(?)がパッケージ名の由来です。</p>
                <p>AWS Cli のWEB上のマニュアルを全て読み込んでローカルDBに保管します。</p>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title">Usage</h1>
            <h2 class="subtitle"></h2>
            <div class="contents"></div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title">Operators</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
                <operator-list operators={operators}></operator-list>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title">Others</h1>
            <h2 class="subtitle"></h2>
            <section class="section">
                <div class="container">
                    <h1 class="title is-4">collect が上手くいかない AWSコマンド</h1>
                    <h2 class="subtitle"></h2>
                    <div class="contents">
                        <p>2018-10-03 (Wed) ですが、 AWS のマニュアルに問題があり、正常にインポート出来ないマニュアルがあります。</p>
                        <p>これらのコマンドは、オプションが正しく取得できていません。</p>
                        <p><pre>
WARNING: 0  = 8  ⇒ NIL : CREATE-SUBSCRIPTION
WARNING: 0  = 8  ⇒ NIL : UPDATE-SUBSCRIPTION
WARNING: 0  = 1  ⇒ NIL : GET
WARNING: 0  = 2  ⇒ NIL : SET
WARNING: 32 = 34 ⇒ NIL : CREATE-CLUSTER</pre>
                        </p>
                    </div>
                </div>
            </section>
        </div>
    </section>


    <section-footer></section-footer>

    <script>
     this.operators = [
         { name: 'get-aws',                  description: '', type: '???', package: '' },
         { name: 'find-aws-options',         description: '', type: '???', package: '' },
         { name: 'find-commands',            description: '', type: '???', package: '' },
         { name: 'get-command',              description: '', type: '???', package: '' },
         { name: 'get-command-subcommand',   description: '', type: '???', package: '' },
         { name: 'find-command-subcommands', description: '', type: '???', package: '' },
         { name: 'find-subcommand-options',  description: '', type: '???', package: '' },
         { name: 'get-subcommand',           description: '', type: '???', package: '' },
         { name: 'collect',                  description: '', type: '???', package: '' },
         { name: 'command',                  description: '', type: '???', package: '' },
         { name: 'display',                  description: '', type: '???', package: '' },
         { name: 'r-aws2commands',           description: '', type: '???', package: '' },
         { name: 'r-aws2options',            description: '', type: '???', package: '' },
         { name: 'r-command2subcommands',    description: '', type: '???', package: '' },
         { name: 'r-subcommand2options',     description: '', type: '???', package: '' },
         { name: 'options-values',           description: '', type: '???', package: '' },
         { name: 'find-finder',              description: '', type: '???', package: '' },
         { name: 'get-finder',               description: '', type: '???', package: '' },
         { name: 'lock-p',                   description: '', type: '???', package: '' },
     ];
    </script>
</beach_page_root>
