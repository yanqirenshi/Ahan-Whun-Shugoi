<page_beach_inspector-option>
    <div class="flex-parent">

        <div class="flex-item" style="margin-bottom: 11px;g">
            <h1 class="title" style="margin-bottom: 0px;">
                {opts.object ? opts.object._core.code : '???'}
            </h1>
        </div>

        <page-tabs core={page_tabs} callback={clickTab} style="margin-bottom:22px;"></page-tabs>

        <div class="flex-item" style="flex-grow: 1; overflow: auto;">
            <page_beach_inspector-option-basic class="hide"></page_beach_inspector-option-basic>
            <page_beach_inspector-option-manual class="hide"
                                                source={opts.object}></page_beach_inspector-option-manual>
        </div>
    </div>

    <style>
     page_beach_inspector-command > .flex-parent {
         display: flex;
         flex-direction: column;
         align-content: flex-start;
         height: 100%;
     }
    </style>

    <script>
     this.page_tabs = new PageTabs([
         {code: 'basid',  label: 'Basic',  tag: 'page_beach_inspector-option-basic' },
         {code: 'manual', label: 'Manual', tag: 'page_beach_inspector-option-manual' },
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
</page_beach_inspector-option>
