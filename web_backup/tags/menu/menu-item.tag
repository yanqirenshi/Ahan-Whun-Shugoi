<menu-item class="box-shadow {display()} {select()} "
           code={opts.data.code}
           type={opts.data.type}
           title={opts.data.code}
           action={opts.data.action}
           onclick={opts.clickItem}>

    <p style="position: absolute;">
        {finderCode(opts.data.code)}
        <i class="{opts.data.icon}"></i>
    </p>

    <style>
     menu-item {
         display:block;
         margin: 3px 5px;
         padding: 11px;
         background: #fff;
         width: 44px;
         height: 44px;
         border-radius: 44px;
         text-align: center;
         border: 1px solid rgba(217, 51, 63, 0.3);
     }
     menu-item.hide { display: none; }
     menu-item.selected {
         background: rgba(217, 51, 63, 0.8);
         color: #fff;
         font-weight: bold;
     }
     menu-item p{
         position: absolute;
         color: rgba(8, 8, 8, 0.2);
     }
     menu-item svg.svg-inline--fa{
         position: absolute;
         top: 0;
         left: 0;
         width: inherit;
         height: inherit;
         color: rgba(217, 51, 63, 0.6);
         font-size: 20px;
     }
    </style>

    <script>
     this.display = () => {
         return this.opts.display ? '' : 'hide';
     };
     this.select = () => {
         return (this.opts.select == this.opts.data.code) ? 'selected' : '';
     };
     this.finderCode = (code) => {
         let len = code.length;
         return (code.substring(0,1) + code.substring(len-1)).toUpperCase();
     };
    </script>
</menu-item>
