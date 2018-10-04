<beach_page_classes>
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
            <h1 class="title">グラフ構造</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
            </div>
            <section class="section">
                <div class="container">
                    <h1 class="title is-4">コマンド</h1>
                    <h2 class="subtitle"></h2>
                    <div class="contents">
                        <p><pre>
   aws -----(1)-----> Command -----(2)-----> subcommand
             :                      :
             :                      :
             :                      +- - - - - -> r-command2subcommands
             :
             +- - - - - -> r-aws2commands</pre></p>

                        <table class="table" style="margin-top: 11px;">
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </section>
            <section class="section">
                <div class="container">
                    <h1 class="title is-4">コマンド・オプション</h1>
                    <h2 class="subtitle"></h2>
                    <div class="contents">
                        <p><pre>
        aws -----(1)-----> option
                  :
                  +- - - - - -> r-aws2options

 subcommand -----(1)-----> option
                  :
                  +- - - - - -> r-subcommand2options</pre></p>
                        <table class="table" style="margin-top: 11px;">
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </section>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title">クラス図</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title">クラス一覧</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
                <class-list classes={classes}>
            </div>
        </div>
    </section>

    <script>
     this.classes = [
         { name:'node',                  description: 'Vertex のルートクラス',                     precedences: 'SHINRABANSHOU:SHIN' },
         { name:'sand',                  description: 'AWSからインポートするデータのルートクラス', precedences: 'node' },
         { name:'aws',                   description: '',                                          precedences: 'sand' },
         { name:'option',                description: '',                                          precedences: 'sand' },
         { name:'command',               description: '',                                          precedences: 'sand' },
         { name:'subcommand',            description: '',                                          precedences: 'sand' },
         { name:'r-aws2commands',        description: '',                                          precedences: 'SHINRABANSHOU:RA' },
         { name:'r-aws2options',         description: '',                                          precedences: 'SHINRABANSHOU:RA' },
         { name:'r-command2subcommands', description: '',                                          precedences: 'SHINRABANSHOU:RA' },
         { name:'r-subcommand2options',  description: '',                                          precedences: 'SHINRABANSHOU:RA' },
         { name:'finder',                description: '',                                          precedences: 'SHINRABANSHOU:SHIN' },
     ];
    </script>
</beach_page_classes>
