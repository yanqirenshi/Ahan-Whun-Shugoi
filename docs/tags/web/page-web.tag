<page-web>

    <section-header title="Web"></section-header>

    <page-tabs tabs={tabs}
               active_tag={active_tag}
               click-tab={clickTab}></page-tabs>

    <div>
        <page-web_tab-sitemap class="hide"></page-web_tab-sitemap>
        <page-web_tab_readme  class="hide"></page-web_tab_readme>
        <page-web_tab_beach   class="hide"></page-web_tab_beach>
    </div>

    <section-footer></section-footer>

    <script>
     this.default_tag = 'readme';
     this.active_tag = null;
     this.tabs = [
         { code: 'readme',  label: 'README',  tag: 'page-web_tab_readme' },
         { code: 'sitemap', label: 'Sitemap', tag: 'page-web_tab-sitemap' },
         { code: 'beach',   label: 'Beach',   tag: 'page-web_tab_beach' },
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

</page-web>
