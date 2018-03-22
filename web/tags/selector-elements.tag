<selector-elements>
    <div each={opts.data}>
        <input type="checkbox"
               checked={display ? 'checked' : ''}
               onchange={this.opts.changeDisplay}
               _class={_class}
               _id={_id}>
        {code}
    </div>
</selector-elements>
