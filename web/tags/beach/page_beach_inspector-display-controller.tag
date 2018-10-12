<page_beach_inspector-display-controller>
    <div class="contents">
        <table class="table" style="font-size: 12px;">
            <thead>
                <tr>
                    <th>Code</th>
                    <th>Display</th>
                </tr>
            </thead>
            <tbody>
                <tr each={cmd in this.opts.objects}>
                    <td style="padding: 12px;">{cmd._core.code}</td>
                    <td>
                        <a class="button is-small"
                           onclick={clickDisplayButton}
                           object_class={cmd._core._class}
                           object_id={cmd._id}
                           object_display={cmd._core.display ? 1 : -1}>
                            {cmd._core.display ? 'True' : 'False'}
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <script>
     this.clickDisplayButton = (e) => {
         let callback = this.opts.callback;

         if (!callback) return;

         let elm = e.target;
         let data = {
             class: elm.getAttribute('object_class'),
             _id: elm.getAttribute('object_id'),
             display: elm.getAttribute('object_display')=='1',
         };

         callback(e, 'click-display-button', data)
     };
    </script>
</page_beach_inspector-display-controller>
