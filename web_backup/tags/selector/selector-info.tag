<selector-info>
    <div class="contents panel-block">
        <div>
            <h3 class="title is-4">Description</h3>
            <p ref="description"></p>
        </div>
        <div>
            <h3 class="title is-4">Synopsis</h3>
            <p ref="synopsis"></p>
        </div>

        <div>
            <h3 class="title is-4">Uri</h3>
            <div class="section">
                <a href="{this.opts.data.uri}">{this.opts.data.uri}</a>
            </div>
        </div>

        <div>
            <h3 class="title is-4">Location</h3>
            <div class="section">
                <table class="table">
                    <thead><tr><th>x</th><th>y</th><th>z</th></tr></thead>
                    <tbody><tr>
                        <td>{location('X')}</td>
                        <td>{location('Y')}</td>
                        <td>{location('Z')}</td>
                    </tr></tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="tail panel-block" style="align-items:flex-end;">
    </div>

    <style>
     selector-info {
         width: 50vw;
         align-items: stretch;
         flex-grow: 1;

         display: flex;
         flex-direction: column;

         padding: 0px;
         background: #ffffff;
         border-left: solid 1px rgba(217, 51, 63, 0.3);
         border-right: solid 1px rgba(217, 51, 63, 0.3);
     }
     selector-info > .contents {
         flex-direction: column;
         overflow: auto;
         overflow-x: hidden;
         flex-grow: 1;
     }
     selector-info > .contents > div{
         width: 100%;
     }
     selector-info > .contents .section {
         padding: 1rem 2rem;
     }
     selector-info > div.panel-block,
     selector-info > div.panel-block:first-child
     {
         border-top:none;
         border-left:none;
         border-right:none;
         border-color: rgba(217, 51, 63, 0.3);
     }
     selector-info > div.panel-block:last-child {
         border-bottom:none;
     }
     selector-info > .tail {
         background: rgba(217, 51, 63, 0.6);
         color: #fff;
     }
    </style>

    <script>
     this.on('update', () => {
         this.refs.description.innerHTML = this.opts.data.description;
         this.refs.synopsis.innerHTML = this.opts.data.synopsis;
     });

     this.location = function (key) {
         if (!this.opts.data || !this.opts.data.location)
             return '?'

         return this.opts.data.location[key];
     }.bind(this);
    </script>
</selector-info>
