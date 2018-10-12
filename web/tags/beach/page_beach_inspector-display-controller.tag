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
                    <td><a class="button is-small">{cmd._core.display}</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</page_beach_inspector-display-controller>
