<help_page_root>
    <section class="section">
        <div class="container">
            <h1 class="title">Sitemap</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Path</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr each={getSitemap()}>
                            <td><a href={href}>{href}</a></td>
                            <td>{description}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <script>
     this.getSitemap = () => {
         return this.sitemap.filter((d) => { return d.implementation; });
     };
     this.sitemap = [
         { href: '#beach',                                                    description: '', implementation: true },
         { href: '#beach/aws',                                                description: '', implementation: false },
         { href: '#beach/aws/options',                                        description: '', implementation: false },
         { href: '#beach/aws/options/:code',                                  description: '', implementation: false },
         { href: '#beach/aws/commands',                                       description: '', implementation: false },
         { href: '#beach/aws/commands/:code',                                 description: '', implementation: false },
         { href: '#beach/aws/commands/:code/subcommands/:code',               description: '', implementation: false },
         { href: '#beach/aws/commands/:code/subcommands/:code/options/:code', description: '', implementation: false },
         { href: '#beach/commands',                                           description: '', implementation: false },
         { href: '#beach/commands/:code',                                     description: '', implementation: false },
         { href: '#beach/commands/:code/subcommands/:code',                   description: '', implementation: false },
         { href: '#beach/commands/:code/subcommands/:code/options/:code',     description: '', implementation: false },
         { href: '#beach/subcommands',                                        description: '', implementation: false },
         { href: '#beach/subcommands/:code',                                  description: '', implementation: false },
         { href: '#beach/subcommands/:code/options/:code',                    description: '', implementation: false },
         { href: '#beach/options',                                            description: '', implementation: false },
         { href: '#beach/options/:code',                                      description: '', implementation: false },
         { href: '#help',                                                     description: '', implementation: true },
     ];
    </script>
</help_page_root>
