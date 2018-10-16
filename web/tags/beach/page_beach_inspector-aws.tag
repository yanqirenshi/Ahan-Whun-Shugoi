<page_beach_inspector-aws>
    <div class="flex-parent">
        <div class="flex-item" style="margin-bottom: 11px;g">
            <h1 class="title" style="margin-bottom: 0px;">AWS</h1>
        </div>

        <page-tabs core={page_tabs} callback={clickTab} style="margin-bottom:22px;"></page-tabs>

        <div class="flex-item" style="flex-grow: 1; overflow: auto;">
            <page_beach_inspector-aws-basic class="hide"></page_beach_inspector-aws-basic>
            <page_beach_inspector-aws-commands class="hide"
                                               commands={getCommands()}
                                               callback={callbackDisplayController}></page_beach_inspector-aws-commands>
            <page_beach_inspector-aws-options class="hide"
                                              options={getOptions()}
                                              callback={callbackDisplayController}></page_beach_inspector-aws-options>
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
         let aws = this.opts.object;

         if (!aws) return [];

         return this.opts.object._core.commands.sort((a,b) => {
             return a.CODE > b.CODE ? 1 : -1;
         });
     };
     this.getOptions = () => {
         let aws = this.opts.object;

         if (!aws) return [];

         let out = [];
         for (var k in aws._edges.out) {
             let to = aws._edges.out[k]._target;
             if (to._class == "OPTION")
                 out.push(to);
         }

         return out;
     };

     this.page_tabs = new PageTabs([
         {code: 'basid',    label: 'Basic',    tag: 'page_beach_inspector-aws-basic' },
         {code: 'commands', label: 'Commands', tag: 'page_beach_inspector-aws-commands' },
         {code: 'options',  label: 'Options',  tag: 'page_beach_inspector-aws-options' },
     ]);

     this.on('mount', () => {
         this.page_tabs.switchTab(this.tags)
         this.update();
     });

     this.clickTab = (e, action, data) => {
         if (this.page_tabs.switchTab(this.tags, data.code))
             this.update();
     };

     this.callbackDisplayController = (e, action, data) => {
         ACTIONS.switchDisplay(data.class, data._id, !data.display);
     };
    </script>
</page_beach_inspector-aws>
