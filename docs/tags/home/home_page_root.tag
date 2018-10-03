<home_page_root>
    <section-header title="AHAN-WHUN-SHUGOI"
                    subtitle="AWS Cli wrapper with Manuals"></section-header>

    
    <page-tabs tabs={tabs}
               active_tag={active_tag}
               click-tab={clickTab}></page-tabs>

    <div>
        <home_page_readme class="hide"></home_page_readme>
        <home_page_packages class="hide"></home_page_packages>
        <home_page_operators class="hide"></home_page_operators>
        <home_page_others class="hide"></home_page_others>
    </div>

    <script>
     this.default_tag = 'readme';
     this.active_tag = null;
     this.tabs = [
         { code: 'readme',    label: 'README',    tag: 'home_page_readme' },
         { code: 'packages',  label: 'Packages',  tag: 'home_page_packages' },
         { code: 'operators', label: 'Operators', tag: 'home_page_operators' },
         { code: 'others',    label: 'Others',    tag: 'home_page_others' },
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
</home_page_root>
