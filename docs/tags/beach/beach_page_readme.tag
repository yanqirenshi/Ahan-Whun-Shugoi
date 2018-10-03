<beach_page_readme>
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
            <div class="contents">
                <p><pre>
(collect :refresh t :thread t)</pre>
                </p>
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
</beach_page_readme>
