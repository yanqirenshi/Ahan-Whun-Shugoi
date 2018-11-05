<page_beach_inspector class={opts.object ? '' : 'hide'}>

    <div class="inspector">
        <page_beach_inspector-aws        class="{hide('AWS')}"        object={getSource('AWS')}></page_beach_inspector-aws>
        <page_beach_inspector-command    class="{hide('COMMAND')}"    object={getSource('COMMAND')}></page_beach_inspector-command>
        <page_beach_inspector-option     class="{hide('OPTION')}"     object={getSource('OPTION')}></page_beach_inspector-option>
        <page_beach_inspector-subcommand class="{hide('SUBCOMMAND')}" object={getSource('SUBCOMMAND')}></page_beach_inspector-subcommand>
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

    <style>
     page_beach_inspector .section {
         padding-bottom: 0px;
         padding-top: 22px;
     }
     page_beach_inspector .section > .container > h1 {
         margin-bottom: 8px;
     }
     page_beach_inspector .section > .container > .contents {
         padding-left: 11px;
     }
    </style>


    <script>
     this.getSource = (code) => {
         if (!this.opts.object || this.opts.object._class != code)
             return null;

         return this.opts.object;
     };
     this.hide = (code) => {
         if (!this.opts.object || this.opts.object._class != code)
             return 'hide'

         return '';
     };
    </script>
</page_beach_inspector>
