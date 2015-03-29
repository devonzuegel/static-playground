(function() {
  var Origami, optns,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  Origami = (function() {
    var get_children, hierarchy, is_child_of, is_defined, make_elem_header, open_close;

    hierarchy = [];

    function Origami(optns) {
      var elems, h, hdr, i, len, ref;
      if (is_defined(optns.hierarchy)) {
        hierarchy = optns.hierarchy.reverse();
      }
      elems = $.makeArray($('#origami').children());
      for (h = i = 0, len = elems.length; i < len; h = ++i) {
        hdr = elems[h];
        if (ref = hdr.tagName, indexOf.call(optns.fold, ref) >= 0) {
          (function(hdr, h) {
            var $btn, $div, $hdr, children, ref1;
            make_elem_header(hdr, h, optns);
            children = get_children(elems, hdr, h);
            $(children).wrapAll("<div id='fold-me-" + h + "'></div>");
            $hdr = $("#fold-hdr-" + h);
            $div = $("#fold-me-" + h);
            $btn = $("#origami-btn-" + h)[0];
            $hdr.click(function() {
              return open_close($hdr, $div, $btn, optns);
            });
            if (ref1 = hdr.tagName, indexOf.call(optns.start_closed, ref1) >= 0) {
              return open_close($hdr, $div, $btn, optns);
            }
          })(hdr, h);
        }
      }
      $('#origami').show();
    }

    is_defined = function(hierarchy) {
      return hierarchy && (JSON.stringify(hierarchy) !== '[""]');
    };

    is_child_of = function(elem, hdr) {
      var i_e, i_h;
      i_e = hierarchy.indexOf(elem.tagName);
      i_h = hierarchy.indexOf(hdr.tagName);
      return i_e < i_h;
    };

    make_elem_header = function(header, h, optns) {
      $(header).css('cursor', 'pointer');
      $(header).addClass(optns.hdr_klass.open);
      header.id = "fold-hdr-" + h;
      return header.innerHTML = "<span class='origami-btn " + optns.btn_klass.open + "' id='origami-btn-" + h + "'>" + optns.btn_symbols.open + "</span> " + header.innerHTML;
    };

    get_children = function(elems, header, h) {
      var children, e, i, len, ref;
      children = [];
      ref = elems.slice(h + 1);
      for (i = 0, len = ref.length; i < len; i++) {
        e = ref[i];
        if (!is_child_of(e, header)) {
          break;
        }
        children.push(e);
      }
      return children;
    };

    open_close = function($hdr, $div, $btn, optns) {
      var closed, open;
      $div.slideToggle(optns.duration);
      $($btn).toggleClass(optns.btn_klass.open + " " + optns.btn_klass.closed);
      open = optns.btn_symbols.open;
      closed = optns.btn_symbols.closed;
      $btn.innerText = $btn.innerText === open ? closed : open;
      return $hdr.toggleClass(optns.hdr_klass.open + " " + optns.hdr_klass.closed);
    };

    return Origami;

  })();

  optns = {
    hierarchy: ['H1', 'H2', 'H3', 'H4', 'H5', 'H6'],
    fold: ['H1', 'H2', 'H3', 'H4', 'H5', 'H6'],
    btn_symbols: {
      open: '+',
      closed: '-'
    },
    start_closed: [],
    hdr_klass: {
      open: '',
      closed: ''
    },
    btn_klass: {
      open: '',
      closed: ''
    },
    duration: 200
  };

  $(document).ready(function() {
    var origami;
    $.extend(optns, document.origami);
    if ($('#origami')) {
      return origami = new Origami(optns);
    }
  });

}).call(this);
