<beach_page_classes>
    <section class="section">
        <div class="container">
            <h1 class="title">Classes</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
                <class-list classes={classes}>
            </div>
        </div>
    </section>

    <script>
     this.classes = [
         { name:'node',                  description: 'Vertex のルートクラス',                     parent: 'shin' },
         { name:'sand',                  description: 'AWSからインポートするデータのルートクラス', parent: 'node' },
         { name:'aws',                   description: '',                                          parent: 'sand' },
         { name:'option',                description: '',                                          parent: 'sand' },
         { name:'command',               description: '',                                          parent: 'sand' },
         { name:'subcommand',            description: '',                                          parent: 'sand' },
         { name:'r-aws2commands',        description: '',                                          parent: 'ra' },
         { name:'r-aws2options',         description: '',                                          parent: 'ra' },
         { name:'r-command2subcommands', description: '',                                          parent: 'ra' },
         { name:'r-subcommand2options',  description: '',                                          parent: 'ra' },
         { name:'finder',                description: '',                                          parent: 'shin' },
     ];
    </script>
</beach_page_classes>
