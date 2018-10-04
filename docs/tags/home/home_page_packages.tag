<home_page_packages>
    <section class="section" style="padding-top: 0px; padding-bottom: 0px;">
        <div class="container">
            <div class="contents">
                <p>構成するパッケージについて説明します。</p>
            </div>
        </div>
    </section>

    <home_page_packages_important packages={packages}></home_page_packages_important>
    <home_page_packages_command packages={packages}></home_page_packages_command>
    <home_page_packages_beach packages={packages}></home_page_packages_beach>
    <home_page_packages_api packages={packages}></home_page_packages_api>

    <script>
     this.packages = {
         important: [
             { name: 'ahan-whun-shugoi',       description: '' },
             { name: 'ahan-whun-shugoi.cmd',   description: '未実装。現在は ahan-whun-shugoi に含まれる。' },
             { name: 'ahan-whun-shugoi.db',    description: '' },
             { name: 'ahan-whun-shugoi.api',   description: '' },
             { name: 'ahan-whun-shugoi.beach', description: '' },
             { name: 'ahan-whun-shugoi.help',  description: '' },
         ],
         command: [
             { name: 'ahan-whun-shugoi.cli.option', description: '' },
             { name: 'ahan-whun-shugoi.cli.command', description: '' },
             { name: 'ahan-whun-shugoi.cli.config', description: '' },
         ],
         api: [
             { name: 'ahan-whun-shugoi-api-test', description: '' },
             { name: 'ahan-whun-shugoi-api.cosmos', description: '' },
             { name: 'ahan-whun-shugoi-api.app', description: '' },
             { name: 'ahan-whun-shugoi-api.render', description: '' },
             { name: 'ahan-whun-shugoi-api.controller', description: '' },
             { name: 'ahan-whun-shugoi-api.config', description: '' },
             { name: 'ahan-whun-shugoi-api.cosmos', description: '' },
             { name: 'ahan-whun-shugoi-api.router', description: '' },
             { name: 'ahan-whun-shugoi-api.api-v1', description: '' },
             { name: 'ahan-whun-shugoi-api.beach', description: '' },
         ],
         beach: [
             { name: 'ahan-whun-shugoi-beach-test', description: '' },
             { name: 'ahan-whun-shugoi-beach.db', description: '' },
             { name: 'ahan-whun-shugoi-beach.util.html', description: '' },
             { name: 'ahan-whun-shugoi-beach.util.uri', description: '' },
             { name: 'ahan-whun-shugoi-beach.util', description: '' },
             { name: 'ahan-whun-shugoi-beach.util.lock', description: '' },
         ],
     }
    </script>
</home_page_packages>
