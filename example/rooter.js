// Generated by CoffeeScript 1.3.3
(function() {
  var hash, hashTimer, rooter;

  hash = {
    listeners: [],
    listen: function(fn) {
      return rooter.hash.listeners.push(fn);
    },
    trigger: function(hash) {
      var fn, _i, _len, _ref;
      if (hash == null) {
        hash = rooter.hash.value();
      }
      if (hash === "") {
        hash = "/";
      }
      _ref = rooter.hash.listeners;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        fn = _ref[_i];
        fn(hash);
      }
    },
    value: function(h) {
      if (h) {
        window.location.hash = h;
      }
      return window.location.hash.replace('#', '');
    }
  };

  hashTimer = {
    listeners: [],
    listen: function(fn) {
      return rooter.hash.listeners.push(fn);
    },
    trigger: function(hash) {
      var fn, _i, _len, _ref;
      if (hash == null) {
        hash = rooter.hash.value();
      }
      if (hash === "") {
        hash = "/";
      }
      _ref = rooter.hash.listeners;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        fn = _ref[_i];
        fn(hash);
      }
    },
    value: function(h) {
      if (h) {
        rooter.hash.lastHash = h;
        window.location.hash = h;
      }
      return window.location.hash.replace('#', '');
    },
    lastHash: null,
    check: function() {
      var currHash;
      currHash = rooter.hash.value();
      if (currHash !== rooter.hash.lastHash) {
        rooter.hash.lastHash = currHash;
        rooter.hash.trigger(currHash);
      }
      setTimeout(rooter.hash.check, 100);
    }
  };

  rooter = {
    history: [],
    init: function() {
      rooter.hash.listen(rooter.test);
      if (rooter.hash.check) {
        return rooter.hash.check();
      }
      return rooter.hash.trigger();
    },
    routes: {},
    lastMatch: null,
    route: function(expr, fn) {
      var pattern;
      pattern = "^" + expr + "$";
      pattern = pattern.replace(/([?=,\/])/g, '\\$1').replace(/:([\w\d]+)/g, '([^/]*)');
      rooter.routes[expr] = {
        names: expr.match(/:([\w\d]+)/g),
        pattern: new RegExp(pattern),
        fn: fn
      };
    },
    test: function(hash) {
      var args, d, idx, m, name, o, r, _i, _len, _ref, _ref1;
      _ref = rooter.routes;
      for (r in _ref) {
        d = _ref[r];
        if (m = d.pattern.exec(hash)) {
          rooter.lastMatch = r;
          rooter.history.push(r);
          o = {};
          if (d.names) {
            args = m.slice(1);
            _ref1 = d.names;
            for (idx = _i = 0, _len = _ref1.length; _i < _len; idx = ++_i) {
              name = _ref1[idx];
              o[name.substring(1)] = args[idx];
            }
          }
          d.fn(o);
        }
      }
    }
  };

  if (typeof window.onhashchange !== 'undefined') {
    rooter.hash = hash;
    window.onhashchange = function() {
      return rooter.hash.trigger(rooter.hash.value());
    };
  } else {
    rooter.hash = hashTimer;
    setTimeout(rooter.hash.check, 100);
  }

  window.rooter = rooter;

}).call(this);
