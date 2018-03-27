<selector2-commands class="panel-block">

    <div class="panel-block">
        <p class="control has-icons-left">
            <input class="input is-small" type="text" placeholder="search">
            <span class="icon is-small is-left">
                <i class="fas fa-search"></i>
            </span>
        </p>
    </div>

    <div class="contents panel-block">
        <div each={opts.data} style="width:100%">
            <input type="checkbox"
                   checked={display ? 'checked' : ''}
                   onchange={opts.changeDisplay}
                   _class={_class}
                   _id={_id}>
            {code}
        </div>

    </div>

    <div class="tail panel-block" style="align-items:flex-end;">
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
     selector2-commands > div.panel-block:last-child {
         border-bottom:none;
     }
     selector2-commands .contents {
         flex-direction: column;
         overflow: auto;
         overflow-x: hidden;
         flex-grow: 1;
     }
     selector2-commands .tail {
         background: rgba(217, 51, 63, 0.6);
         color: #fff;
     }
    </style>

    <script>
    </script>
</selector2-commands>
