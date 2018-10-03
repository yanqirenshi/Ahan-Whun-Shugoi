<operator-list>
    <table class="table">
        <thead>
            <tr>
                <th>Name</th>
                <th>Type</th>
                <th>Description</th>
                <th>Package</th>
            </tr>
        </thead>
        <tbody>
            <tr each={opts.operators}>
                <td>{name}</td>
                <td>{type}</td>
                <td>{description}</td>
                <td>{package}</td>
            </tr>
        </tbody>
    </table>
</operator-list>
