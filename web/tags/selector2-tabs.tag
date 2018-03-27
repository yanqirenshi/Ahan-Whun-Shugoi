<selector2-tabs class="panel-tabs">
    <div>
        <a each={opts.tabs}
           class="{display ? 'is-active' : ''}"
           code={code}
           onclick={opts.clickTab}>{code}</a>
    </div>

    <style>
     selector2-tabs.panel-tabs {
         align-items: flex-start;
         border-color: rgba(217, 51, 63, 0.3);
         display: block;
     }
     selector2-tabs.panel-tabs > div {
         display: flex;
         flex-direction: row;
         padding: 0px 0px 11px 0px;
     }
     selector2-tabs.panel-tabs a {
         border-color: rgba(217, 51, 63, 0.1);
         justify-content: space-around;
         flex-grow: 1;
     }
     selector2-tabs.panel-tabs a.is-active {
         border-color: rgba(217, 51, 63, 1);
     }
    </style>
</selector2-tabs>
