<page_beach_inspector-option-manual>
    <section class="section">
        <div class="container">
            <div class="contents" ref="description"></div>
        </div>
    </section>

    <script>
     this.on('update', () => {
         if (!this.opts.source) return;

         let source = this.opts.source._core;

         this.refs['description'].innerHTML = source.description;
     });
    </script>
</page_beach_inspector-option-manual>
