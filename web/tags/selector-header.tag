<selector-header class="panel-heading">
    <p>
        {title()}
    </p>

    <style>
     selector-header.panel-heading {
         background: rgba(217, 51, 63, 0.6);
         color: #fff;
         font-weight: bold;
         align-items:flex-start;
     }
     selector-header.panel-heading,
     selector-header.panel-heading:first-child {
         border-color: rgba(217, 51, 63, 0.3);
     }
    </style>

    <script>
     this.title = () => {
         let element = this.opts.data;
         let code = element.code ? element.code : '???';
         let _class = element._class ? element._class : '???';
         return code + ' (' + _class + ')'
     };
    </script>
</selector-header>
