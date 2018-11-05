<beach-sand-location>
    <section class="section">
        <div class="container">
            <h1 class="title is-{opts.lev}">Location</h1>
            <div class="contents">
                <table class="table">
                    <tbody>
                        <tr><th>X</th> <td>{val('x')}</td></tr>
                        <tr><th>Y</th> <td>{val('y')}</td></tr>
                        <tr><th>X(固定)</th> <td>{val('_core.location.X')}</td></tr>
                        <tr><th>Y(固定)</th> <td>{val('_core.location.Y')}</td></tr>
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
</beach-sand-location>
