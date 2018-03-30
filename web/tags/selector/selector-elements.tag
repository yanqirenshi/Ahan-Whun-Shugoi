<selector-elements>
    <div class="panel-block" style="display:block;">
        <p class="control has-icons-left">
            <input class="input is-small"
                   type="text"
                   placeholder="search"
                   ref="searchKeyword"
                   oninput={this.onInput}
                   value={opts.searchKeyword}>
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
     selector-elements {
         align-items: stretch;
         flex-grow: 1;

         display: flex;
         flex-direction: column;

         padding: 0px;
         background: #ffffff;
         border-left: solid 1px rgba(217, 51, 63, 0.3);
         border-right: solid 1px rgba(217, 51, 63, 0.3);
     }

     selector-elements > div.panel-block,
     selector-elements > div.panel-block:first-child
     {
         border-top:none;
         border-left:none;
         border-right:none;
         border-color: rgba(217, 51, 63, 0.3);
     }
     selector-elements > div.panel-block:last-child {
         border-bottom:none;
     }
     selector-elements .contents {
         flex-direction: column;
         overflow: auto;
         overflow-x: hidden;
         flex-grow: 1;
     }
     selector-elements .tail {
         background: rgba(217, 51, 63, 0.6);
         color: #fff;
     }
    </style>

    <script>
     this.onInput = (e) => {
         let tabs = STORE.state().selector.tabs;
         let tab_code = tabs.find((tab)=>{ return tab.select; }).code
         STORE.dispatch(ACTIONS.updateSelectorElementKeword(tab_code, e.target.value));
     }
    </script>
</selector-elements>
