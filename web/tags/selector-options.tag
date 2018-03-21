<selector-options>
    <div each={opts.data}>
        <input type="checkbox"
               checked={display ? 'checked' : ''}
               onchange={this.opts.onchange}
               _class={_class}
               _id={_id}>
        {code}
    </div>
</selector-options>
