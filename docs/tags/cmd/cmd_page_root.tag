<page-cmd>
    <section-header title="Command"></section-header>

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

    <section-footer></section-footer>

    <script>
     this.operators = [
         { name: 'aws',                    description: '', type: '???', package: '' },
         { name: 'start',                  description: '', type: '???', package: '' },
         { name: 'stop',                   description: '', type: '???', package: '' },
         { name: 'graph-data-stor',        description: '', type: '???', package: '' },
         { name: 'name',                   description: '', type: '???', package: '' },
         { name: '*print-command-stream*', description: '', type: '???', package: '' },
     ];
    </script>
</page-cmd>
