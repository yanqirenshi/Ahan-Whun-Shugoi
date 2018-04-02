<menu-item class="box-shadow">
    <p>{finderCode(opts.code)}</p>

    <style>
     menu-item {
         float: left;
         margin: 8px;
         padding: 11px;
         background: #fff;
         width: 44px;
         height: 44px;
         border-radius: 44px;
         text-align: center;
     }
    </style>

    <script>
     this.finderCode = (code) => {
         let len = code.length;
         return code.substring(0,1) + code.substring(len-1);
     };
    </script>
</menu-item>
