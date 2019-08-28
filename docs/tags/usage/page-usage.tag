<page-usage>
    <section-header title="Usage"
                    subtitle=""></section-header>

    <page-tabs tabs={tabs}
               active_tag={active_tag}
               click-tab={clickTab}></page-tabs>

    <div>
        <page-usage_readme        class="hide"></page-usage_readme>
        <page-usage_setting-lisp  class="hide"></page-usage_setting-lisp>
        <page-usage_import-manual class="hide"></page-usage_import-manual>
    </div>

    <section-footer></section-footer>

    <script>
     this.default_tag = 'readme';
     this.active_tag = null;
     this.tabs = [
         { code: 'readme',        label: 'README',        tag: 'page-usage_readme' },
         { code: 'setting-lisp',  label: 'Setting Lisp',  tag: 'page-usage_setting-lisp' },
         { code: 'import-manual', label: 'Import Manual', tag: 'page-usage_import-manual' },
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
</page-usage>
