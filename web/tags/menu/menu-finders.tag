<menu-finders>
    <menu-finder each={opts.finders}
                 code={code}
                 type={type}
                 select-code={parent.opts.selectCode}
                 click-finder={parent.opts.clickFinder}>
    </menu-finder>

    <style>
     menu-finders {
         display: flex;
         flex-direction: row-reverse;
         flex-wrap: nowrap;
     }
     menu-finders > menu-finder{
         align-items: flex-start;
     }
    </style>
</menu-finders>
