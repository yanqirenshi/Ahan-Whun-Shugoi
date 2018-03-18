class NetworkGraphSvg {
    constructor(x, y, w, h) {
        this._svg = null;
        this._x = x ? x : 0;
        this._y = y ? y : 0;
        this._w = w ? w : 0;
        this._h = h ? h : 0;
        this._scale = 1;
    }
    setSize (w,h) {
        this.w = w ? w : 0;
        this.h = h ? h : 0;
    }
    setSvg (svg) {
        this._svg = svg;
    }
}
