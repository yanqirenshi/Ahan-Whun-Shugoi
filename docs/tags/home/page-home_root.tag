<page-home_root>
    <section-header title="AHAN-WHUN-SHUGOI"
                    subtitle="AWS Cli wrapper with Manuals"></section-header>

    <page-tabs tabs={tabs}
               active_tag={active_tag}
               click-tab={clickTab}></page-tabs>

    <div>
        <page-home_readme class="hide"></page-home_readme>
        <page-home_packages class="hide"></page-home_packages>
        <page-home_operators class="hide"></page-home_operators>
        <page-home_others class="hide"></page-home_others>
    </div>

    <script>
     this.default_tag = 'readme';
     this.active_tag = null;
     this.tabs = [
         { code: 'readme',    label: 'README',    tag: 'page-home_readme' },
         { code: 'packages',  label: 'Packages',  tag: 'page-home_packages' },
         { code: 'operators', label: 'Operators', tag: 'page-home_operators' },
         { code: 'others',    label: 'Others',    tag: 'page-home_others' },
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
</page-home_root>
