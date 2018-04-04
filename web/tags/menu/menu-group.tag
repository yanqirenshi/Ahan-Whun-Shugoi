<menu-group>
    <menu-item each={opts.data.children}
               code={code}
               select={false}></menu-item>

    <style>
     menu-group {
         display: flex;
         flex-direction: column;
         flex-wrap: nowrap;
     }
     menu-group > menu-item {
         align-items: flex-start;
     }
    </style>

    <script>
     dump('--')
     dump(this.opts.data.children)
    </script>
</menu-group>
