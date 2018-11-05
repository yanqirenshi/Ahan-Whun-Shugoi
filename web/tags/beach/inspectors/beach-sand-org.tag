<beach-sand-org>
    <section class="section">
        <div class="container">
            <h1 class="title is-{opts.lev}">Uri</h1>
            <div class="contents">
                <p><a href={val('_core.uri')} target="_blank">
                    AWS CLI: {val('_core.code')}
                </a></p>
            </div>
        </div>
    </section>

    <script>
     this.on('update', () => {
         dump(this.opts)
     });
     this.val = (keys_str) => {
         let keys = keys_str.split('.');
         let source = this.opts.source;

         if (!source) return '';

         let tmp = source;
         for (var i in keys) {
             let key = keys[i];

             if (typeof tmp[key] === "undefined") return '';

             tmp = tmp[key];
         }

         return tmp;
     };
    </script>
</beach-sand-org>
