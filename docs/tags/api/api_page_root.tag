<api_page_root>
    <section-header title="Api"></section-header>

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
         { name: 'start', description: '', type: 'Function', package: '' },
         { name: 'stop',  description: '', type: 'Function', package: '' },
     ];
    </script>
</api_page_root>
