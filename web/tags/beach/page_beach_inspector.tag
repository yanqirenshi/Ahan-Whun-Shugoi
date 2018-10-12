<page_beach_inspector class={opts.object ? '' : 'hide'}>

    <div class="inspector">
        <page_beach_inspector-aws        class="{hide('AWS')}"        object={opts.object}></page_beach_inspector-aws>
        <page_beach_inspector-command    class="{hide('COMMAND')}"    object={opts.object}></page_beach_inspector-command>
        <page_beach_inspector-option     class="{hide('OPTION')}"     object={opts.object}></page_beach_inspector-option>
        <page_beach_inspector-subcommand class="{hide('SUBCOMMAND')}" object={opts.object}></page_beach_inspector-subcommand>
    </div>

    <style>
     page_beach_inspector > .inspector {
         height: 100vh;
         min-width: 222px;
         max-width: 555px;
         padding: 22px;
         position: fixed;
         right: 0px;
         top: 0px;
         box-shadow: 0px 0px 3px #888888;
         background: #ffffff;
     }
    </style>

    <script>
     this.hide = (code) => {
         if (!this.opts.object || this.opts.object._class != code)
             return 'hide'

         return '';
     };
    </script>
</page_beach_inspector>
