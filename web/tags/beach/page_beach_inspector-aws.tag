<page_beach_inspector-aws>
    <div class="flex-parent">
        <div class="flex-item" style="margin-bottom: 11px;g">
            <h1 class="title" style="margin-bottom: 0px;">AWS</h1>
        </div>

        <page-tabs core={page_tabs} callback={clickTab} style="margin-bottom:22px;"></page-tabs>

        <div class="flex-item" style="flex-grow: 1; overflow: auto;">
            <page_beach_inspector-aws-basic class="hide"></page_beach_inspector-aws-basic>
            <page_beach_inspector-display-controller class="hide" objects={getCommands()}></page_beach_inspector-display-controller>
        </div>
    </div>

    <style>
     page_beach_inspector-aws > .flex-parent {
         display: flex;
         flex-direction: column;
         align-content: flex-start;
         height: 100%;
     }
    </style>

    <script>
     this.getCommands = () => {
         // TODO: これは出来れば手繰りたい。
         return STORE.get('beach.commands.list').sort((a,b) => {
             return (a._core.code > b._core.code) ? 1 : -1;
         });
     };

     this.page_tabs = new PageTabs([
         {code: 'basid',   label: 'Basic',   tag: 'page_beach_inspector-aws-basic' },
         {code: 'display', label: 'Display', tag: 'page_beach_inspector-display-controller' },
     ]);

     this.on('mount', () => {
         this.page_tabs.switchTab(this.tags)
         this.update();
     });

     this.clickTab = (e, action, data) => {
         if (this.page_tabs.switchTab(this.tags, data.code))
             this.update();
     };
    </script>
</page_beach_inspector-aws>
