<beach_page_root>
    <section-header title="Beach"></section-header>

    <page-tabs tabs={tabs}
               active_tag={active_tag}
               click-tab={clickTab}></page-tabs>

    <div>
        <beach_page_readme class="hide"></beach_page_readme>
        <beach_page_functions class="hide"></beach_page_functions>
        <beach_page_datamodels class="hide"></beach_page_datamodels>
        <beach_page_operators class="hide"></beach_page_operators>
        <beach_page_classes class="hide"></beach_page_classes>
    </div>

    <section-footer></section-footer>

    <script>
     this.default_tag = 'readme';
     this.active_tag = null;
     this.tabs = [
         { code: 'readme',     label: 'README',      tag: 'beach_page_readme' },
         { code: 'functions',  label: 'Functions',   tag: 'beach_page_functions' },
         { code: 'datamodels', label: 'Data Models', tag: 'beach_page_datamodels' },
         { code: 'classes',    label: 'Classes',     tag: 'beach_page_classes' },
         { code: 'operators',  label: 'Operators',   tag: 'beach_page_operators' },
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
</beach_page_root>
