class Vanilla_URI {
    parselHash (hash) {
        let ret = hash.match(/#(.*)/) || hash.match(/^#(.*)$/);
        return ret ? ret[1].split('/') : [];
    }
}
