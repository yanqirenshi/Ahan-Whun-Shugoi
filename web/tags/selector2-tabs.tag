<selector2-tabs class="panel-tabs">
    <a each={opts.tabs}
       class="{display ? 'is-active' : ''}"
       code={code}
       onclick={opts.clickTab}>{code}</a>

    <style>
     selector2-tabs.panel-tabs {
         border-color: rgba(217, 51, 63, 0.3);
         padding-top: 3px;
     }
     selector2-tabs.panel-tabs a {
         border-color: rgba(217, 51, 63, 0.1);
     }
     selector2-tabs.panel-tabs a.is-active {
         border-color: rgba(217, 51, 63, 1);
     }
    </style>

</selector2-tabs>
