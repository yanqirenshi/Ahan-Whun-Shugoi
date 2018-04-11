<menu-finder class="box-shadow"
             select="{select()}"
             onclick={opts.clickFinder}>
    <!-- fal fa-binoculars -->
    <p code={opts.code}
       type={opts.type}
       title={opts.code}>
        {finderCode(opts.code)}
    </p>

    <style>
     menu-finder {
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
     menu-finder[select=selected] {
         background: rgba(217, 51, 63, 0.8);
         color: #fff;
         font-weight: bold;
     }
    </style>

    <script>
     this.select = () => {
         return (this.opts.selectCode == this.opts.code) ? 'selected' : '';
     };
     this.finderCode = (code) => {
         let len = code.length;
         return (code.substring(0,1) + code.substring(len-1)).toUpperCase();
     };
    </script>
</menu-finder>
