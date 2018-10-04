<class-list>
    <table class="table">
        <thead>
            <tr>
                <th>Name</th>
                <th>Description</th>
                <th>Parent</th>
            </tr>
        </thead>
        <tbody>
            <tr each={opts.classes}>
                <td>{name}</td>
                <td>{description}</td>
                <td>{precedences}</td>
            </tr>
        </tbody>
    </table>
</class-list>
