<pakage-list>
    <table class="table">
        <thead>
            <tr><th>Name</th><th>Description</th></tr>
        </thead>
        <tbody>
            <tr each={opts.packages}>
                <th>{name}</th>
                <td>{description}</td>
            </tr>
        </tbody>
    </table>
</pakage-list>
