<menu-item class="box-shadow {select()}"
           onclick={opts.clickMenuItem}>
    <p code={opts.code}
       type={opts.type}
       title={opts.code}>
        {finderCode(opts.code)}
    </p>

    <style>
     menu-item {
         display:block;
         margin: 8px;
         padding: 11px;
         background: #fff;
         width: 44px;
         height: 44px;
         border-radius: 44px;
         text-align: center;
         border: 1px solid rgba(217, 51, 63, 0.3);
     }
     menu-item.selected {
         background: rgba(217, 51, 63, 0.8);
         color: #fff;
         font-weight: bold;
     }
    </style>

    <script>
     this.select = () => {
         return (this.opts.select == this.opts.code) ? 'selected' : '';
     };
     this.finderCode = (code) => {
         let len = code.length;
         return (code.substring(0,1) + code.substring(len-1)).toUpperCase();
     };
    </script>
</menu-item>
