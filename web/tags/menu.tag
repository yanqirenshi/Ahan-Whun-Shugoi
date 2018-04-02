<menu>
    <nav>
        <menu-item each={finder()}
                   code={code}
                   select={STORE.state().finders.select}
                   click-menu-item={clickMenuItem}></menu-item>
    </nav>

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
         STORE.dispatch(ACTIONS.clickFinder(e.target.getAttribute('code')));
     }
     this.finder = () => {
         return STORE.state().finders.list;
     };
     STORE.subscribe((action) => {
         if (action.type=='CLICK-FINDER')
             this.update();
     });
    </script>
</menu>
