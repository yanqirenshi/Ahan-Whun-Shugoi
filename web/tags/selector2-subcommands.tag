<selector2-subcommands class="panel-block">
    <div class="panel-block">
        <p class="control has-icons-left">
            <input class="input is-small" type="text" placeholder="search">
            <span class="icon is-small is-left">
                <i class="fas fa-search"></i>
            </span>
        </p>
    </div>

    <div class="panel-block" style="flex-direction: column; overflow: auto; overflow-x: hidden;">
        <div style="width:100%;">xxx</div>
    </div>

    <style>
     selector2-commands.panel-block {
         align-items:stretch;
         flex-grow: 1;
         flex-direction: column;
         padding: 0px;
         background: #ffffff;
         border-color: rgba(217, 51, 63, 0.3);
     }
     selector2-commands > div.panel-block,
     selector2-commands > div.panel-block:first-child
     {
         border-top:none;
         border-left:none;
         border-right:none;
         border-color: rgba(217, 51, 63, 0.3);
     }

    </style>
</selector2-subcommands>
