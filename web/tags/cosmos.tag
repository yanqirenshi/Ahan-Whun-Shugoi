<cosmos ref="self">
    <svg></svg>

    <style>
     cosmos {
         width: 100%;
         height: 100%;
         display: block;
         background: rgba(0,0,0,0.9);
     }
    </style>

    <script>
     this.on('mount', () => {
         let base_tag = this.refs.self;
         this.svg = new D3Svg({
             svg: d3.select("cosmos svg"),
             x: 0,
             y: 0,
             w: base_tag.clientWidth,
             h: base_tag.clientHeight,
             scale: 1
         });
     })

     this.on('update', () => {
         let base_tag = this.refs.self;
         this.svg.setSize(base_tag.clientWidth,base_tag.clientHeight);
     });
    </script>
</cosmos>
