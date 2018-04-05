<menu-group>
    <menu-item data={opts.data}
               select={false}
               display={true}
               parent-code={null}
               click-item={opts.clickGroup}></menu-item>

    <menu-item each={data in opts.data.children}
               data={data}
               display={displayChild()}
               select={false}
               parent-code={parentCode()}
               click-item={childrenClickItem()}></menu-item>

    <style>
     menu-group {
         display: flex;
         flex-direction: column-reverse;
         flex-wrap: nowrap;
     }
     menu-group > menu-item {
         align-items: flex-start;
     }
    </style>

    <script>
     this.displayChild = () => {
         return this.opts.data.open;
     };
     this.childrenClickItem = () => {
         return this.opts.clickItem;
     };
     this.parentCode = () => {
         return this.opts.data.code;
     };
    </script>
</menu-group>
