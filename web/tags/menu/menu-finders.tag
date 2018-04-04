<menu-finders>
    <menu-finder each={opts.finders}
                 code={code}
                 type={type}
                 select={select()}>
    </menu-finder>


    <style>
     menu-finders {
         display: flex;
         flex-direction: row-reverse;
         flex-wrap: nowrap;
     }
     menu-finders > menu-finder{
         align-items: flex-end; 
     }
    </style>

    <script>
     this.select = () => {
         let state = STORE.state().beach;
         return state.finders.select;
     };
    </script>
</menu-finders>
