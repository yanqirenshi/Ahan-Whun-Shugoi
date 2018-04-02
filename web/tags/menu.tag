<menu>
    <nav>
        <menu-item each={finder()} code={code}></menu-item>
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
     this.finder = () => {
         return STORE.state().finders.list;
     };
    </script>
</menu>
