<page-tabs>
    <section class="section" style="padding-top: 0px; padding-bottom: 33px;">
        <div class="container">

            <div class="tabs">
                <ul>
                    <li each={opts.tabs} class={opts.active_tag==code ? 'is-active' : ''}>
                        <a code={code}
                           onclick={opts.clickTab}>{label}</a>
                    </li>
                </ul>
            </div>

        </div>
    </section>
</page-tabs>
