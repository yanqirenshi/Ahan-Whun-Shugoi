<selector-tabs class="panel-tabs">
    <div>
        <a each={opts.tabs}
           class="{select ? 'is-active' : ''} {display ? '' : 'hide'}"
           code={code}
           onclick={opts.clickTab}>{code}</a>
    </div>

    <style>
     selector-tabs .hide { display: none; }
     selector-tabs.panel-tabs {
         align-items: flex-start;
         border-color: rgba(217, 51, 63, 0.3);
         display: block;
     }
     selector-tabs.panel-tabs > div {
         display: flex;
         flex-direction: row;
         padding: 0px 0px 11px 0px;
     }
     selector-tabs.panel-tabs a {
         border-color: rgba(217, 51, 63, 0.1);
         justify-content: space-around;
         flex-grow: 1;
         text-align: center;
     }
     selector-tabs.panel-tabs a.is-active {
         border-color: rgba(217, 51, 63, 1);
     }
    </style>
</selector-tabs>
