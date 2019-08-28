<page-beach_operators>
    <section class="section">
        <div class="container">
            <h1 class="title">Operators</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
                <operator-list operators={operators.important}></operator-list>
            </div>
        </div>
    </section>

    <script>
     this.operators = {
         important: [
             { name: 'collect',                  description: '', type: '???', package: '' },
         ],
         aws: [
             { name: 'get-aws',                  description: '', type: '???', package: '' },
         ],
         command: [
             { name: 'find-commands',            description: '', type: '???', package: '' },
             { name: 'get-command',              description: '', type: '???', package: '' },
         ],
         subcommand: [
             { name: 'get-command-subcommand',   description: '', type: '???', package: '' },
             { name: 'find-command-subcommands', description: '', type: '???', package: '' },
             { name: 'find-subcommand-options',  description: '', type: '???', package: '' },
             { name: 'get-subcommand',           description: '', type: '???', package: '' },
         ],
         options: [
             { name: 'find-aws-options',         description: '', type: '???', package: '' },
             { name: 'options-values',           description: '', type: '???', package: '' },
         ],
         edges: [
             { name: 'r-aws2commands',           description: '', type: '???', package: '' },
             { name: 'r-aws2options',            description: '', type: '???', package: '' },
             { name: 'r-command2subcommands',    description: '', type: '???', package: '' },
             { name: 'r-subcommand2options',     description: '', type: '???', package: '' },
         ],
         others: [
             { name: 'command',                  description: '', type: '???', package: '' },
             { name: 'display',                  description: '', type: '???', package: '' },
             { name: 'find-finder',              description: '', type: '???', package: '' },
             { name: 'get-finder',               description: '', type: '???', package: '' },
             { name: 'lock-p',                   description: '', type: '???', package: '' },
         ]
     };
    </script>
</page-beach_operators>
