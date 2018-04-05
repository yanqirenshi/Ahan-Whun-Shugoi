<menu>
    <menu-finders finders={finders()}></menu-finders>
    <menu-group each={data in menuGroups()}
                data={data}
                click-group={clickMenuGroup}
                click-item={clickMenuItem}></menu-group>

    <style>
     menu {
         position: fixed;
         bottom: 0;
         right: 0;

         margin-right: 16px;

         display: flex;
         flex-direction: row;
         flex-wrap: nowrap;
     }
     menu > menu-finders, menu > menu-group {
         align-items: flex-end;
     }
    </style>

    <script>
     this.state = () => { return STORE.state().beach; };
     this.findParentTag = (tagName, tag) => {
         if (tag.tagName.toUpperCase() == tagName.toUpperCase())
             return tag;
         return this.findParentTag (tagName, tag.parentNode)
     };
     this.clickMenuGroup = (e) => {
         let tag = this.findParentTag('menu-item',e.target);
         let code = tag.getAttribute('code');

         STORE.dispatch(ACTIONS.clickMenuGroupItem(code));
         this.update();
     }
     this.clickMenuItem = (e) => {
         let tag = this.findParentTag('menu-item',e.target);
         let code = tag.getAttribute('code');
         let parent_code = tag.getAttribute('parent-code');

         STORE.dispatch(ACTIONS.clickMenuItem(code, parent_code));
         this.update();
     }
     this.finders = () => {
         let finders = this.state().finders.list;
         return finders.map((finder) => {
             return {
                 code: finder.code,
                 type: 'finder'
             }
         });
     };
     this.menuGroups = () => {
         return this.state().menus;
     };
     STORE.subscribe((action) => {
         if (action.type=='CLICK-FINDER' || action.type=='CLICK-MENU-GROUP-ITEM')
             this.update();
     });
    </script>
</menu>
