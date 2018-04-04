<menu>
    <menu-finders finders={finders()}></menu-finders>
    <menu-group each={data in menuGroups()}
                data={data}></menu-group>

    <style>
     menu {
         position: fixed;
         bottom: 0;
         right: 0;

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
     this.clickMenuItem = (e) => {
         let code = e.target.getAttribute('code');
         let type = e.target.getAttribute('type');
         if (type=='finder')
             STORE.dispatch(ACTIONS.clickFinder());
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
         if (action.type=='CLICK-FINDER')
             this.update();
     });
    </script>
</menu>
