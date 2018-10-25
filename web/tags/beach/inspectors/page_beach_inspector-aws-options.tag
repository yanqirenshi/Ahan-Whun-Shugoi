<page_beach_inspector-aws-options>
    <page_beach_inspector-display-controller objects={objects()}
                                             callback={opts.callback}></page_beach_inspector-display-controller>


    <script>
     this.objects = () => {
         if (!this.opts.options) return [];

         return this.opts.options.map((option) => {
             return {
                 _CLASS: option._core._class,
                 _ID: option._id,
                 _DISPLAY: option._core.display,
                 CODE: option._core.code,
             }
         });
     };
    </script>
</page_beach_inspector-aws-options>
