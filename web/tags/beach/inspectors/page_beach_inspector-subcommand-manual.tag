<page_beach_inspector-subcommand-manual>
    <section class="section">
        <div class="container">
            <div class="contents" ref="description"></div>
        </div>
    </section>

    <style>
     page_beach_inspector-subcommand-manual .section {
         padding-top: 11px;
         padding-bottom: 3px;
     }

     page_beach_inspector-subcommand-manual .contents h2 {
         font-size: 22px;
         font-weight: bold;
         text-decoration: underline;
     }

     page_beach_inspector-subcommand-manual .contents h2 > a {
         display: none;
     }

     page_beach_inspector-subcommand-manual .contents h3 {
         font-size: 18px;
         font-weight: bold;
     }

     page_beach_inspector-subcommand-manual .contents h3 > a {
         display: none;
     }

     page_beach_inspector-subcommand-manual .contents > .section {
         padding: 0px;
     }
    </style>

    <script>
     this.on('update', () => {
         if (!this.opts.source) return;

         let source = this.opts.source._core;

         this.refs['description'].innerHTML = source.description;
     });
    </script>
</page_beach_inspector-subcommand-manual>
