<page-beach>
    <section-header title="Beach"></section-header>

    <page-tabs tabs={tabs}
               active_tag={active_tag}
               click-tab={clickTab}></page-tabs>

    <div>
        <page-beach_readme class="hide"></page-beach_readme>
        <page-beach_functions class="hide"></page-beach_functions>
        <page-beach_datamodels class="hide"></page-beach_datamodels>
        <page-beach_operators class="hide"></page-beach_operators>
        <page-beach_classes class="hide"></page-beach_classes>
    </div>

    <section-footer></section-footer>

    <script>
     this.default_tag = 'readme';
     this.active_tag = null;
     this.tabs = [
         { code: 'readme',     label: 'README',      tag: 'page-beach_readme' },
         { code: 'functions',  label: 'Functions',   tag: 'page-beach_functions' },
         { code: 'datamodels', label: 'Data Models', tag: 'page-beach_datamodels' },
         { code: 'classes',    label: 'Classes',     tag: 'page-beach_classes' },
         { code: 'operators',  label: 'Operators',   tag: 'page-beach_operators' },
     ];
     this.clickTab = (e) => {
         this.switchTab(e.target.getAttribute('code'));
     };
     this.on('mount', () => {
         this.switchTab(this.default_tag);
     });
     this.switchTab = (code) => {
         if (this.active_tag == code) return;

         this.active_tag = code;

         let tag = null;
         for (var i in this.tabs) {
             let tab = this.tabs[i];
             this.tags[tab.tag].root.classList.add('hide');
             if (tab.code==code)
                 tag = tab.tag;
         }

         this.tags[tag].root.classList.remove('hide');

         this.update();
     };
    </script>
</page-beach>
