<menu>
    <div style="float:left;">
        <menu-item each={finders()}
                   code={code}
                   select={STORE.state().finders.select}
                   type={type}
                   click-menu-item={clickMenuItem}></menu-item>
    </div>
    <menu-group each={data in menuGroups()}
                data={data}></menu-group>

    <style>
     menu {
         position: fixed;
         bottom: 0;
         right: 0;
         display: block;
     }
    </style>

    <script>
     this.clickMenuItem = (e) => {
         let code = e.target.getAttribute('code');
         let type = e.target.getAttribute('type');
         if (type=='finder')
             STORE.dispatch(ACTIONS.clickFinder());
     }
     this.finders = () => {
         return STORE.state().finders.list.map((finder) => {
             return {
                 code: finder.code,
                 type: 'finder'
             }
         });
     };
     this.menuGroups = () => {
         return STORE.state().beach.menus;
     };
     STORE.subscribe((action) => {
         if (action.type=='CLICK-FINDER')
             this.update();
     });
    </script>
</menu>
