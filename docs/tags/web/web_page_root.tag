<web_page_root>
    <section-header title="Web"></section-header>

    <page-tabs tabs={tabs}
               active_tag={active_tag}
               click-tab={clickTab}></page-tabs>

    <div>
        <web_page_tab_sitemap class="hide"></web_page_tab_sitemap>
        <web_page_tab_readme class="hide"></web_page_tab_readme>
        <web_page_tab_beach class="hide"></web_page_tab_beach>
    </div>

    <section-footer></section-footer>

    <script>
     this.default_tag = 'readme';
     this.active_tag = null;
     this.tabs = [
         { code: 'readme',  label: 'README',  tag: 'web_page_tab_readme' },
         { code: 'sitemap', label: 'Sitemap', tag: 'web_page_tab_sitemap' },
         { code: 'beach',   label: 'Beach',   tag: 'web_page_tab_beach' },
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
</web_page_root>
