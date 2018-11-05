<beach-sand-stroke>
    <section class="section">
        <div class="container">
            <h1 class="title is-{opts.lev}">Stroke</h1>
            <div class="contents">
                <table class="table">
                    <tbody>
                        <tr><th>R</th> <td>{val('_core.stroke.COLOR.R')}</td></tr>
                        <tr><th>G</th> <td>{val('_core.stroke.COLOR.G')}</td></tr>
                        <tr><th>B</th> <td>{val('_core.stroke.COLOR.B')}</td></tr>
                        <tr><th>A</th> <td>{val('_core.stroke.COLOR.A')}</td></tr>
                        <tr><th>Width</th> <td>{val('_core.stroke.WIDTH')}</td></tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <script>
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
</beach-sand-stroke>
