!(function (e) {
  function t(t) {
    for (
      var o, c, i = t[0], l = t[1], d = t[2], s = 0, m = [];
      s < i.length;
      s++
    )
      (c = i[s]),
        Object.prototype.hasOwnProperty.call(r, c) && r[c] && m.push(r[c][0]),
        (r[c] = 0);
    for (o in l) Object.prototype.hasOwnProperty.call(l, o) && (e[o] = l[o]);
    for (u && u(t); m.length; ) m.shift()();
    return a.push.apply(a, d || []), n();
  }
  function n() {
    for (var e, t = 0; t < a.length; t++) {
      for (var n = a[t], o = !0, i = 1; i < n.length; i++) {
        var l = n[i];
        0 !== r[l] && (o = !1);
      }
      o && (a.splice(t--, 1), (e = c((c.s = n[0]))));
    }
    return e;
  }
  var o = {},
    r = { 1: 0 },
    a = [];
  function c(t) {
    if (o[t]) return o[t].exports;
    var n = (o[t] = { i: t, l: !1, exports: {} });
    return e[t].call(n.exports, n, n.exports, c), (n.l = !0), n.exports;
  }
  (c.m = e),
    (c.c = o),
    (c.d = function (e, t, n) {
      c.o(e, t) || Object.defineProperty(e, t, { enumerable: !0, get: n });
    }),
    (c.r = function (e) {
      "undefined" != typeof Symbol &&
        Symbol.toStringTag &&
        Object.defineProperty(e, Symbol.toStringTag, { value: "Module" }),
        Object.defineProperty(e, "__esModule", { value: !0 });
    }),
    (c.t = function (e, t) {
      if ((1 & t && (e = c(e)), 8 & t)) return e;
      if (4 & t && "object" == typeof e && e && e.__esModule) return e;
      var n = Object.create(null);
      if (
        (c.r(n),
        Object.defineProperty(n, "default", { enumerable: !0, value: e }),
        2 & t && "string" != typeof e)
      )
        for (var o in e)
          c.d(
            n,
            o,
            function (t) {
              return e[t];
            }.bind(null, o)
          );
      return n;
    }),
    (c.n = function (e) {
      var t =
        e && e.__esModule
          ? function () {
              return e["default"];
            }
          : function () {
              return e;
            };
      return c.d(t, "a", t), t;
    }),
    (c.o = function (e, t) {
      return Object.prototype.hasOwnProperty.call(e, t);
    }),
    (c.p = "");
  var i = (window.webpackJsonp = window.webpackJsonp || []),
    l = i.push.bind(i);
  (i.push = t), (i = i.slice());
  for (var d = 0; d < i.length; d++) t(i[d]);
  var u = l;
  a.push([224, 0]), n();
})(
  Array(59).concat([
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.InterfaceLockNoticeBox = void 0);
      var o = n(0),
        r = n(2),
        a = n(1);
      t.InterfaceLockNoticeBox = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          l = e.siliconUser,
          d = void 0 === l ? i.siliconUser : l,
          u = e.locked,
          s = void 0 === u ? i.locked : u,
          m = e.onLockStatusChange,
          p =
            void 0 === m
              ? function () {
                  return c("lock");
                }
              : m,
          C = e.accessText,
          h = void 0 === C ? "an ID card" : C;
        return d
          ? (0, o.createComponentVNode)(2, a.NoticeBox, {
              color: d && "grey",
              children: (0, o.createComponentVNode)(2, a.Flex, {
                align: "center",
                children: [
                  (0, o.createComponentVNode)(2, a.Flex.Item, {
                    children: "Interface lock status:",
                  }),
                  (0, o.createComponentVNode)(2, a.Flex.Item, { grow: 1 }),
                  (0, o.createComponentVNode)(2, a.Flex.Item, {
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      m: 0,
                      color: s ? "red" : "green",
                      icon: s ? "lock" : "unlock",
                      content: s ? "Locked" : "Unlocked",
                      onClick: function () {
                        p && p(!s);
                      },
                    }),
                  }),
                ],
              }),
            })
          : (0, o.createComponentVNode)(2, a.NoticeBox, {
              children: [
                "Swipe ",
                h,
                " ",
                "to ",
                s ? "unlock" : "lock",
                " this interface.",
              ],
            });
      };
    },
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.BeakerContents = void 0);
      var o = n(0),
        r = n(1);
      t.BeakerContents = function (e) {
        var t = e.beakerLoaded,
          n = e.beakerContents;
        return (0, o.createComponentVNode)(2, r.Box, {
          children: [
            (!t &&
              (0, o.createComponentVNode)(2, r.Box, {
                color: "label",
                children: "No beaker loaded.",
              })) ||
              (0 === n.length &&
                (0, o.createComponentVNode)(2, r.Box, {
                  color: "label",
                  children: "Beaker is empty.",
                })),
            n.map(function (e) {
              return (0,
              o.createComponentVNode)(2, r.Box, { color: "label", children: [e.volume, " units of ", e.name] }, e.name);
            }),
          ],
        });
      };
    },
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.AiRestorerContent = t.AiRestorer = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.AiRestorer = function () {
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 370,
          height: 360,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, i),
          }),
        });
      };
      var i = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          l = i.AI_present,
          d = i.error,
          u = i.name,
          s = i.laws,
          m = i.isDead,
          p = i.restoring,
          C = i.health,
          h = i.ejectable;
        return (0, o.createFragment)(
          [
            d &&
              (0, o.createComponentVNode)(2, a.NoticeBox, {
                textAlign: "center",
                children: d,
              }),
            !!h &&
              (0, o.createComponentVNode)(2, a.Button, {
                fluid: !0,
                icon: "eject",
                content: l ? u : "----------",
                disabled: !l,
                onClick: function () {
                  return c("PRG_eject");
                },
              }),
            !!l &&
              (0, o.createComponentVNode)(2, a.Section, {
                title: h ? "System Status" : u,
                buttons: (0, o.createComponentVNode)(2, a.Box, {
                  inline: !0,
                  bold: !0,
                  color: m ? "bad" : "good",
                  children: m ? "Nonfunctional" : "Functional",
                }),
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList, {
                    children: (0, o.createComponentVNode)(
                      2,
                      a.LabeledList.Item,
                      {
                        label: "Integrity",
                        children: (0, o.createComponentVNode)(
                          2,
                          a.ProgressBar,
                          {
                            value: C,
                            minValue: 0,
                            maxValue: 100,
                            ranges: {
                              good: [70, Infinity],
                              average: [50, 70],
                              bad: [-Infinity, 50],
                            },
                          }
                        ),
                      }
                    ),
                  }),
                  !!p &&
                    (0, o.createComponentVNode)(2, a.Box, {
                      bold: !0,
                      textAlign: "center",
                      fontSize: "20px",
                      color: "good",
                      mt: 1,
                      children: "RECONSTRUCTION IN PROGRESS",
                    }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    icon: "plus",
                    content: "Begin Reconstruction",
                    disabled: p,
                    mt: 1,
                    onClick: function () {
                      return c("PRG_beginReconstruction");
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Section, {
                    title: "Laws",
                    level: 2,
                    children: s.map(function (e) {
                      return (0,
                      o.createComponentVNode)(2, a.Box, { className: "candystripe", children: e }, e);
                    }),
                  }),
                ],
              }),
          ],
          0
        );
      };
      t.AiRestorerContent = i;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.AccessList = void 0);
      var o = n(0),
        r = n(21),
        a = n(2),
        c = n(1);
      function i(e, t) {
        var n;
        if ("undefined" == typeof Symbol || null == e[Symbol.iterator]) {
          if (
            Array.isArray(e) ||
            (n = (function (e, t) {
              if (!e) return;
              if ("string" == typeof e) return l(e, t);
              var n = Object.prototype.toString.call(e).slice(8, -1);
              "Object" === n && e.constructor && (n = e.constructor.name);
              if ("Map" === n || "Set" === n) return Array.from(e);
              if (
                "Arguments" === n ||
                /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)
              )
                return l(e, t);
            })(e)) ||
            (t && e && "number" == typeof e.length)
          ) {
            n && (e = n);
            var o = 0;
            return function () {
              return o >= e.length ? { done: !0 } : { done: !1, value: e[o++] };
            };
          }
          throw new TypeError(
            "Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."
          );
        }
        return (n = e[Symbol.iterator]()).next.bind(n);
      }
      function l(e, t) {
        (null == t || t > e.length) && (t = e.length);
        for (var n = 0, o = new Array(t); n < t; n++) o[n] = e[n];
        return o;
      }
      var d = {
        0: { icon: "times-circle", color: "bad" },
        1: { icon: "stop-circle", color: null },
        2: { icon: "check-circle", color: "good" },
      };
      t.AccessList = function (e, t) {
        var n,
          l = e.accesses,
          u = void 0 === l ? [] : l,
          s = e.selectedList,
          m = void 0 === s ? [] : s,
          p = e.accessMod,
          C = e.grantAll,
          h = e.denyAll,
          N = e.grantDep,
          V = e.denyDep,
          b = (0, a.useLocalState)(
            t,
            "accessName",
            null == (n = u[0]) ? void 0 : n.name
          ),
          f = b[0],
          g = b[1],
          v = u.find(function (e) {
            return e.name === f;
          }),
          k = (0, r.sortBy)(function (e) {
            return e.desc;
          })((null == v ? void 0 : v.accesses) || []),
          w = function (e) {
            for (var t, n = !1, o = !1, r = i(e); !(t = r()).done; ) {
              var a = t.value;
              m.includes(a.ref) ? (n = !0) : (o = !0);
            }
            return !n && o ? 0 : n && o ? 1 : 2;
          };
        return (0, o.createComponentVNode)(2, c.Section, {
          title: "Access",
          buttons: (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, c.Button, {
                icon: "check-double",
                content: "Grant All",
                color: "good",
                onClick: function () {
                  return C();
                },
              }),
              (0, o.createComponentVNode)(2, c.Button, {
                icon: "undo",
                content: "Deny All",
                color: "bad",
                onClick: function () {
                  return h();
                },
              }),
            ],
            4
          ),
          children: (0, o.createComponentVNode)(2, c.Flex, {
            children: [
              (0, o.createComponentVNode)(2, c.Flex.Item, {
                children: (0, o.createComponentVNode)(2, c.Tabs, {
                  vertical: !0,
                  children: u.map(function (e) {
                    var t = e.accesses || [],
                      n = d[w(t)].icon,
                      r = d[w(t)].color;
                    return (0, o.createComponentVNode)(
                      2,
                      c.Tabs.Tab,
                      {
                        altSelection: !0,
                        color: r,
                        icon: n,
                        selected: e.name === f,
                        onClick: function () {
                          return g(e.name);
                        },
                        children: e.name,
                      },
                      e.name
                    );
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, c.Flex.Item, {
                grow: 1,
                children: [
                  (0, o.createComponentVNode)(2, c.Grid, {
                    children: [
                      (0, o.createComponentVNode)(2, c.Grid.Column, {
                        mr: 0,
                        children: (0, o.createComponentVNode)(2, c.Button, {
                          fluid: !0,
                          icon: "check",
                          content: "Grant Region",
                          color: "good",
                          onClick: function () {
                            return N(v.regid);
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, c.Grid.Column, {
                        ml: 0,
                        children: (0, o.createComponentVNode)(2, c.Button, {
                          fluid: !0,
                          icon: "times",
                          content: "Deny Region",
                          color: "bad",
                          onClick: function () {
                            return V(v.regid);
                          },
                        }),
                      }),
                    ],
                  }),
                  k.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      c.Button.Checkbox,
                      {
                        fluid: !0,
                        content: e.desc,
                        checked: m.includes(e.ref),
                        onClick: function () {
                          return p(e.ref);
                        },
                      },
                      e.desc
                    );
                  }),
                ],
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.CargoCatalog = t.Cargo = void 0);
      var o = n(0),
        r = n(21),
        a = n(2),
        c = n(1),
        i = n(52),
        l = n(3);
      t.Cargo = function (e, t) {
        var n = (0, a.useBackend)(t),
          r = (n.act, n.data),
          i = (0, a.useSharedState)(t, "tab", "catalog"),
          m = i[0],
          C = i[1],
          h = r.requestonly,
          N = r.cart || [],
          V = r.requests || [];
        return (0, o.createComponentVNode)(2, l.Window, {
          resizable: !0,
          width: 780,
          height: 750,
          children: (0, o.createComponentVNode)(2, l.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, d),
              (0, o.createComponentVNode)(2, c.Section, {
                fitted: !0,
                children: (0, o.createComponentVNode)(2, c.Tabs, {
                  children: [
                    (0, o.createComponentVNode)(2, c.Tabs.Tab, {
                      icon: "list",
                      selected: "catalog" === m,
                      onClick: function () {
                        return C("catalog");
                      },
                      children: "Catalog",
                    }),
                    (0, o.createComponentVNode)(2, c.Tabs.Tab, {
                      icon: "envelope",
                      textColor: "requests" !== m && V.length > 0 && "yellow",
                      selected: "requests" === m,
                      onClick: function () {
                        return C("requests");
                      },
                      children: ["Requests (", V.length, ")"],
                    }),
                    !h &&
                      (0, o.createComponentVNode)(2, c.Tabs.Tab, {
                        icon: "shopping-cart",
                        textColor: "cart" !== m && N.length > 0 && "yellow",
                        selected: "cart" === m,
                        onClick: function () {
                          return C("cart");
                        },
                        children: ["Checkout (", N.length, ")"],
                      }),
                  ],
                }),
              }),
              "catalog" === m && (0, o.createComponentVNode)(2, u),
              "requests" === m && (0, o.createComponentVNode)(2, s),
              "cart" === m && (0, o.createComponentVNode)(2, p),
            ],
          }),
        });
      };
      var d = function (e, t) {
          var n = (0, a.useBackend)(t),
            r = n.act,
            l = n.data,
            d = l.away,
            u = l.docked,
            s = l.loan,
            m = l.loan_dispatched,
            p = l.location,
            C = l.message,
            h = l.points,
            N = l.requestonly;
          return (0, o.createComponentVNode)(2, c.Section, {
            title: "Cargo",
            buttons: (0, o.createComponentVNode)(2, c.Box, {
              inline: !0,
              bold: !0,
              children: [
                (0, o.createComponentVNode)(2, c.AnimatedNumber, {
                  value: h,
                  format: function (e) {
                    return (0, i.formatMoney)(e);
                  },
                }),
                " credits",
              ],
            }),
            children: (0, o.createComponentVNode)(2, c.LabeledList, {
              children: [
                (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                  label: "Shuttle",
                  children:
                    (u &&
                      !N &&
                      (0, o.createComponentVNode)(2, c.Button, {
                        content: p,
                        onClick: function () {
                          return r("send");
                        },
                      })) ||
                    p,
                }),
                (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                  label: "CentCom Message",
                  children: C,
                }),
                !!s &&
                  !N &&
                  (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                    label: "Loan",
                    children:
                      (!m &&
                        (0, o.createComponentVNode)(2, c.Button, {
                          content: "Loan Shuttle",
                          disabled: !(d && u),
                          onClick: function () {
                            return r("loan");
                          },
                        })) ||
                      (0, o.createComponentVNode)(2, c.Box, {
                        color: "bad",
                        children: "Loaned to Centcom",
                      }),
                  }),
              ],
            }),
          });
        },
        u = function (e, t) {
          var n,
            l = e.express,
            d = (0, a.useBackend)(t),
            u = d.act,
            s = d.data,
            p = s.self_paid,
            C = (0, r.toArray)(s.supplies),
            h = (0, a.useSharedState)(
              t,
              "supply",
              null == (n = C[0]) ? void 0 : n.name
            ),
            N = h[0],
            V = h[1],
            b = C.find(function (e) {
              return e.name === N;
            });
          return (0, o.createComponentVNode)(2, c.Section, {
            title: "Catalog",
            buttons:
              !l &&
              (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, m),
                  (0, o.createComponentVNode)(2, c.Button.Checkbox, {
                    ml: 2,
                    content: "Buy Privately",
                    checked: p,
                    onClick: function () {
                      return u("toggleprivate");
                    },
                  }),
                ],
                4
              ),
            children: (0, o.createComponentVNode)(2, c.Flex, {
              children: [
                (0, o.createComponentVNode)(2, c.Flex.Item, {
                  ml: -1,
                  mr: 1,
                  children: (0, o.createComponentVNode)(2, c.Tabs, {
                    vertical: !0,
                    children: C.map(function (e) {
                      return (0, o.createComponentVNode)(
                        2,
                        c.Tabs.Tab,
                        {
                          selected: e.name === N,
                          onClick: function () {
                            return V(e.name);
                          },
                          children: [e.name, " (", e.packs.length, ")"],
                        },
                        e.name
                      );
                    }),
                  }),
                }),
                (0, o.createComponentVNode)(2, c.Flex.Item, {
                  grow: 1,
                  basis: 0,
                  children: (0, o.createComponentVNode)(2, c.Table, {
                    children:
                      null == b
                        ? void 0
                        : b.packs.map(function (e) {
                            var t = [];
                            return (
                              e.small_item && t.push("Small"),
                              e.access && t.push("Restricted"),
                              (0, o.createComponentVNode)(
                                2,
                                c.Table.Row,
                                {
                                  className: "candystripe",
                                  children: [
                                    (0, o.createComponentVNode)(
                                      2,
                                      c.Table.Cell,
                                      { children: e.name }
                                    ),
                                    (0, o.createComponentVNode)(
                                      2,
                                      c.Table.Cell,
                                      {
                                        collapsing: !0,
                                        color: "label",
                                        textAlign: "right",
                                        children: t.join(", "),
                                      }
                                    ),
                                    (0, o.createComponentVNode)(
                                      2,
                                      c.Table.Cell,
                                      {
                                        collapsing: !0,
                                        textAlign: "right",
                                        children: (0, o.createComponentVNode)(
                                          2,
                                          c.Button,
                                          {
                                            fluid: !0,
                                            tooltip: e.desc,
                                            tooltipPosition: "left",
                                            onClick: function () {
                                              return u("add", { id: e.id });
                                            },
                                            children: [
                                              (0, i.formatMoney)(
                                                p
                                                  ? Math.round(1.1 * e.cost)
                                                  : e.cost
                                              ),
                                              " cr",
                                            ],
                                          }
                                        ),
                                      }
                                    ),
                                  ],
                                },
                                e.name
                              )
                            );
                          }),
                  }),
                }),
              ],
            }),
          });
        };
      t.CargoCatalog = u;
      var s = function (e, t) {
          var n = (0, a.useBackend)(t),
            r = n.act,
            l = n.data,
            d = l.requestonly,
            u = l.requests || [];
          return (0, o.createComponentVNode)(2, c.Section, {
            title: "Active Requests",
            buttons:
              !d &&
              (0, o.createComponentVNode)(2, c.Button, {
                icon: "times",
                content: "Clear",
                color: "transparent",
                onClick: function () {
                  return r("denyall");
                },
              }),
            children: [
              0 === u.length &&
                (0, o.createComponentVNode)(2, c.Box, {
                  color: "good",
                  children: "No Requests",
                }),
              u.length > 0 &&
                (0, o.createComponentVNode)(2, c.Table, {
                  children: u.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      c.Table.Row,
                      {
                        className: "candystripe",
                        children: [
                          (0, o.createComponentVNode)(2, c.Table.Cell, {
                            collapsing: !0,
                            color: "label",
                            children: ["#", e.id],
                          }),
                          (0, o.createComponentVNode)(2, c.Table.Cell, {
                            children: e.object,
                          }),
                          (0, o.createComponentVNode)(2, c.Table.Cell, {
                            children: (0, o.createVNode)(
                              1,
                              "b",
                              null,
                              e.orderer,
                              0
                            ),
                          }),
                          (0, o.createComponentVNode)(2, c.Table.Cell, {
                            width: "25%",
                            children: (0, o.createVNode)(
                              1,
                              "i",
                              null,
                              e.reason,
                              0
                            ),
                          }),
                          (0, o.createComponentVNode)(2, c.Table.Cell, {
                            collapsing: !0,
                            textAlign: "right",
                            children: [(0, i.formatMoney)(e.cost), " cr"],
                          }),
                          !d &&
                            (0, o.createComponentVNode)(2, c.Table.Cell, {
                              collapsing: !0,
                              children: [
                                (0, o.createComponentVNode)(2, c.Button, {
                                  icon: "check",
                                  color: "good",
                                  onClick: function () {
                                    return r("approve", { id: e.id });
                                  },
                                }),
                                (0, o.createComponentVNode)(2, c.Button, {
                                  icon: "times",
                                  color: "bad",
                                  onClick: function () {
                                    return r("deny", { id: e.id });
                                  },
                                }),
                              ],
                            }),
                        ],
                      },
                      e.id
                    );
                  }),
                }),
            ],
          });
        },
        m = function (e, t) {
          var n = (0, a.useBackend)(t),
            r = n.act,
            l = n.data,
            d = l.requestonly,
            u = l.cart || [],
            s = u.reduce(function (e, t) {
              return e + t.cost;
            }, 0);
          return d
            ? null
            : (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, c.Box, {
                    inline: !0,
                    mx: 1,
                    children: [
                      0 === u.length && "Cart is empty",
                      1 === u.length && "1 item",
                      u.length >= 2 && u.length + " items",
                      " ",
                      s > 0 && "(" + (0, i.formatMoney)(s) + " cr)",
                    ],
                  }),
                  (0, o.createComponentVNode)(2, c.Button, {
                    icon: "times",
                    color: "transparent",
                    content: "Clear",
                    onClick: function () {
                      return r("clear");
                    },
                  }),
                ],
                4
              );
        },
        p = function (e, t) {
          var n = (0, a.useBackend)(t),
            r = n.act,
            l = n.data,
            d = l.requestonly,
            u = l.away,
            s = l.docked,
            p = l.location,
            C = l.cart || [];
          return (0, o.createComponentVNode)(2, c.Section, {
            title: "Current Cart",
            buttons: (0, o.createComponentVNode)(2, m),
            children: [
              0 === C.length &&
                (0, o.createComponentVNode)(2, c.Box, {
                  color: "label",
                  children: "Nothing in cart",
                }),
              C.length > 0 &&
                (0, o.createComponentVNode)(2, c.Table, {
                  children: C.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      c.Table.Row,
                      {
                        className: "candystripe",
                        children: [
                          (0, o.createComponentVNode)(2, c.Table.Cell, {
                            collapsing: !0,
                            color: "label",
                            children: ["#", e.id],
                          }),
                          (0, o.createComponentVNode)(2, c.Table.Cell, {
                            children: e.object,
                          }),
                          (0, o.createComponentVNode)(2, c.Table.Cell, {
                            collapsing: !0,
                            children:
                              !!e.paid &&
                              (0, o.createVNode)(
                                1,
                                "b",
                                null,
                                "[Paid Privately]",
                                16
                              ),
                          }),
                          (0, o.createComponentVNode)(2, c.Table.Cell, {
                            collapsing: !0,
                            textAlign: "right",
                            children: [(0, i.formatMoney)(e.cost), " cr"],
                          }),
                          (0, o.createComponentVNode)(2, c.Table.Cell, {
                            collapsing: !0,
                            children: (0, o.createComponentVNode)(2, c.Button, {
                              icon: "minus",
                              onClick: function () {
                                return r("remove", { id: e.id });
                              },
                            }),
                          }),
                        ],
                      },
                      e.id
                    );
                  }),
                }),
              C.length > 0 &&
                !d &&
                (0, o.createComponentVNode)(2, c.Box, {
                  mt: 2,
                  children:
                    (1 === u &&
                      1 === s &&
                      (0, o.createComponentVNode)(2, c.Button, {
                        color: "green",
                        style: { "line-height": "28px", padding: "0 12px" },
                        content: "Confirm the order",
                        onClick: function () {
                          return r("send");
                        },
                      })) ||
                    (0, o.createComponentVNode)(2, c.Box, {
                      opacity: 0.5,
                      children: ["Shuttle in ", p, "."],
                    }),
                }),
            ],
          });
        };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.LaunchpadConsole = t.LaunchpadControl = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = function (e, t) {
          var n = (0, r.useBackend)(t).act;
          return (0, o.createComponentVNode)(2, a.Grid, {
            width: "1px",
            children: [
              (0, o.createComponentVNode)(2, a.Grid.Column, {
                children: [
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    icon: "arrow-left",
                    iconRotation: 45,
                    mb: 1,
                    onClick: function () {
                      return n("move_pos", { x: -1, y: 1 });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    icon: "arrow-left",
                    mb: 1,
                    onClick: function () {
                      return n("move_pos", { x: -1 });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    icon: "arrow-down",
                    iconRotation: 45,
                    mb: 1,
                    onClick: function () {
                      return n("move_pos", { x: -1, y: -1 });
                    },
                  }),
                ],
              }),
              (0, o.createComponentVNode)(2, a.Grid.Column, {
                children: [
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    icon: "arrow-up",
                    mb: 1,
                    onClick: function () {
                      return n("move_pos", { y: 1 });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    content: "R",
                    mb: 1,
                    onClick: function () {
                      return n("set_pos", { x: 0, y: 0 });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    icon: "arrow-down",
                    mb: 1,
                    onClick: function () {
                      return n("move_pos", { y: -1 });
                    },
                  }),
                ],
              }),
              (0, o.createComponentVNode)(2, a.Grid.Column, {
                children: [
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    icon: "arrow-up",
                    iconRotation: 45,
                    mb: 1,
                    onClick: function () {
                      return n("move_pos", { x: 1, y: 1 });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    icon: "arrow-right",
                    mb: 1,
                    onClick: function () {
                      return n("move_pos", { x: 1 });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    icon: "arrow-right",
                    iconRotation: 45,
                    mb: 1,
                    onClick: function () {
                      return n("move_pos", { x: 1, y: -1 });
                    },
                  }),
                ],
              }),
            ],
          });
        },
        l = function (e, t) {
          var n = e.topLevel,
            c = (0, r.useBackend)(t),
            l = c.act,
            d = c.data,
            u = d.x,
            s = d.y,
            m = d.pad_name,
            p = d.range;
          return (0, o.createComponentVNode)(2, a.Section, {
            title: (0, o.createComponentVNode)(2, a.Input, {
              value: m,
              width: "170px",
              onChange: function (e, t) {
                return l("rename", { name: t });
              },
            }),
            level: n ? 1 : 2,
            buttons: (0, o.createComponentVNode)(2, a.Button, {
              icon: "times",
              content: "Remove",
              color: "bad",
              onClick: function () {
                return l("remove");
              },
            }),
            children: [
              (0, o.createComponentVNode)(2, a.Grid, {
                children: [
                  (0, o.createComponentVNode)(2, a.Grid.Column, {
                    children: (0, o.createComponentVNode)(2, a.Section, {
                      title: "Controls",
                      level: 2,
                      children: (0, o.createComponentVNode)(2, i),
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.Grid.Column, {
                    children: (0, o.createComponentVNode)(2, a.Section, {
                      title: "Target",
                      level: 2,
                      children: (0, o.createComponentVNode)(2, a.Box, {
                        fontSize: "26px",
                        children: [
                          (0, o.createComponentVNode)(2, a.Box, {
                            mb: 1,
                            children: [
                              (0, o.createComponentVNode)(2, a.Box, {
                                inline: !0,
                                bold: !0,
                                mr: 1,
                                children: "X:",
                              }),
                              (0, o.createComponentVNode)(2, a.NumberInput, {
                                value: u,
                                minValue: -p,
                                maxValue: p,
                                lineHeight: "30px",
                                fontSize: "26px",
                                width: "90px",
                                height: "30px",
                                stepPixelSize: 10,
                                onChange: function (e, t) {
                                  return l("set_pos", { x: t });
                                },
                              }),
                            ],
                          }),
                          (0, o.createComponentVNode)(2, a.Box, {
                            children: [
                              (0, o.createComponentVNode)(2, a.Box, {
                                inline: !0,
                                bold: !0,
                                mr: 1,
                                children: "Y:",
                              }),
                              (0, o.createComponentVNode)(2, a.NumberInput, {
                                value: s,
                                minValue: -p,
                                maxValue: p,
                                stepPixelSize: 10,
                                lineHeight: "30px",
                                fontSize: "26px",
                                width: "90px",
                                height: "30px",
                                onChange: function (e, t) {
                                  return l("set_pos", { y: t });
                                },
                              }),
                            ],
                          }),
                        ],
                      }),
                    }),
                  }),
                ],
              }),
              (0, o.createComponentVNode)(2, a.Grid, {
                children: [
                  (0, o.createComponentVNode)(2, a.Grid.Column, {
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      fluid: !0,
                      icon: "upload",
                      content: "Launch",
                      textAlign: "center",
                      onClick: function () {
                        return l("launch");
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.Grid.Column, {
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      fluid: !0,
                      icon: "download",
                      content: "Pull",
                      textAlign: "center",
                      onClick: function () {
                        return l("pull");
                      },
                    }),
                  }),
                ],
              }),
            ],
          });
        };
      t.LaunchpadControl = l;
      t.LaunchpadConsole = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          d = n.data,
          u = d.launchpads,
          s = void 0 === u ? [] : u,
          m = d.selected_id;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 475,
          height: 260,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children:
              (0 === s.length &&
                (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children: "No Pads Connected",
                })) ||
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.Flex, {
                  minHeight: "190px",
                  children: [
                    (0, o.createComponentVNode)(2, a.Flex.Item, {
                      width: "140px",
                      minHeight: "190px",
                      children: s.map(function (e) {
                        return (0, o.createComponentVNode)(
                          2,
                          a.Button,
                          {
                            fluid: !0,
                            ellipsis: !0,
                            content: e.name,
                            selected: m === e.id,
                            color: "transparent",
                            onClick: function () {
                              return i("select_pad", { id: e.id });
                            },
                          },
                          e.name
                        );
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.Flex.Item, {
                      minHeight: "100%",
                      children: (0, o.createComponentVNode)(2, a.Divider, {
                        vertical: !0,
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.Flex.Item, {
                      grow: 1,
                      basis: 0,
                      minHeight: "100%",
                      children:
                        (m && (0, o.createComponentVNode)(2, l)) ||
                        (0, o.createComponentVNode)(2, a.Box, {
                          children: "Please select a pad",
                        }),
                    }),
                  ],
                }),
              }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.PowerMonitorContent = t.PowerMonitor = void 0);
      var o = n(0),
        r = n(21),
        a = n(50),
        c = n(8),
        i = n(6),
        l = n(1),
        d = n(3),
        u = n(2),
        s = 5e5;
      t.PowerMonitor = function () {
        return (0, o.createComponentVNode)(2, d.Window, {
          resizable: !0,
          width: 550,
          height: 700,
          children: (0, o.createComponentVNode)(2, d.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, m),
          }),
        });
      };
      var m = function (e, t) {
        var n = (0, u.useBackend)(t).data,
          i = n.history,
          d = (0, u.useLocalState)(t, "sortByField", null),
          m = d[0],
          h = d[1],
          N = i.supply[i.supply.length - 1] || 0,
          V = i.demand[i.demand.length - 1] || 0,
          b = i.supply.map(function (e, t) {
            return [t, e];
          }),
          f = i.demand.map(function (e, t) {
            return [t, e];
          }),
          g = Math.max.apply(Math, [s].concat(i.supply, i.demand)),
          v = (0, a.flow)([
            (0, r.map)(function (e, t) {
              return Object.assign({}, e, { id: e.name + t });
            }),
            "name" === m &&
              (0, r.sortBy)(function (e) {
                return e.name;
              }),
            "charge" === m &&
              (0, r.sortBy)(function (e) {
                return -e.charge;
              }),
            "draw" === m &&
              (0, r.sortBy)(
                function (e) {
                  return (
                    (t = e.load),
                    (n = String(t.split(" ")[1]).toLowerCase()),
                    -["w", "kw", "mw", "gw"].indexOf(n)
                  );
                  var t, n;
                },
                function (e) {
                  return -parseFloat(e.load);
                }
              ),
          ])(n.areas);
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, l.Flex, {
              spacing: 1,
              children: [
                (0, o.createComponentVNode)(2, l.Flex.Item, {
                  width: "200px",
                  children: (0, o.createComponentVNode)(2, l.Section, {
                    children: (0, o.createComponentVNode)(2, l.LabeledList, {
                      children: [
                        (0, o.createComponentVNode)(2, l.LabeledList.Item, {
                          label: "Supply",
                          children: (0, o.createComponentVNode)(
                            2,
                            l.ProgressBar,
                            {
                              value: N,
                              minValue: 0,
                              maxValue: g,
                              color: "teal",
                              children: (0, c.toFixed)(N / 1e3) + " kW",
                            }
                          ),
                        }),
                        (0, o.createComponentVNode)(2, l.LabeledList.Item, {
                          label: "Draw",
                          children: (0, o.createComponentVNode)(
                            2,
                            l.ProgressBar,
                            {
                              value: V,
                              minValue: 0,
                              maxValue: g,
                              color: "pink",
                              children: (0, c.toFixed)(V / 1e3) + " kW",
                            }
                          ),
                        }),
                      ],
                    }),
                  }),
                }),
                (0, o.createComponentVNode)(2, l.Flex.Item, {
                  grow: 1,
                  children: (0, o.createComponentVNode)(2, l.Section, {
                    position: "relative",
                    height: "100%",
                    children: [
                      (0, o.createComponentVNode)(2, l.Chart.Line, {
                        fillPositionedParent: !0,
                        data: b,
                        rangeX: [0, b.length - 1],
                        rangeY: [0, g],
                        strokeColor: "rgba(0, 181, 173, 1)",
                        fillColor: "rgba(0, 181, 173, 0.25)",
                      }),
                      (0, o.createComponentVNode)(2, l.Chart.Line, {
                        fillPositionedParent: !0,
                        data: f,
                        rangeX: [0, f.length - 1],
                        rangeY: [0, g],
                        strokeColor: "rgba(224, 57, 151, 1)",
                        fillColor: "rgba(224, 57, 151, 0.25)",
                      }),
                    ],
                  }),
                }),
              ],
            }),
            (0, o.createComponentVNode)(2, l.Section, {
              children: [
                (0, o.createComponentVNode)(2, l.Box, {
                  mb: 1,
                  children: [
                    (0, o.createComponentVNode)(2, l.Box, {
                      inline: !0,
                      mr: 2,
                      color: "label",
                      children: "Sort by:",
                    }),
                    (0, o.createComponentVNode)(2, l.Button.Checkbox, {
                      checked: "name" === m,
                      content: "Name",
                      onClick: function () {
                        return h("name" !== m && "name");
                      },
                    }),
                    (0, o.createComponentVNode)(2, l.Button.Checkbox, {
                      checked: "charge" === m,
                      content: "Charge",
                      onClick: function () {
                        return h("charge" !== m && "charge");
                      },
                    }),
                    (0, o.createComponentVNode)(2, l.Button.Checkbox, {
                      checked: "draw" === m,
                      content: "Draw",
                      onClick: function () {
                        return h("draw" !== m && "draw");
                      },
                    }),
                  ],
                }),
                (0, o.createComponentVNode)(2, l.Table, {
                  children: [
                    (0, o.createComponentVNode)(2, l.Table.Row, {
                      header: !0,
                      children: [
                        (0, o.createComponentVNode)(2, l.Table.Cell, {
                          children: "Area",
                        }),
                        (0, o.createComponentVNode)(2, l.Table.Cell, {
                          collapsing: !0,
                          children: "Charge",
                        }),
                        (0, o.createComponentVNode)(2, l.Table.Cell, {
                          textAlign: "right",
                          children: "Draw",
                        }),
                        (0, o.createComponentVNode)(2, l.Table.Cell, {
                          collapsing: !0,
                          title: "Equipment",
                          children: "Eqp",
                        }),
                        (0, o.createComponentVNode)(2, l.Table.Cell, {
                          collapsing: !0,
                          title: "Lighting",
                          children: "Lgt",
                        }),
                        (0, o.createComponentVNode)(2, l.Table.Cell, {
                          collapsing: !0,
                          title: "Environment",
                          children: "Env",
                        }),
                      ],
                    }),
                    v.map(function (e, t) {
                      return (0,
                      o.createVNode)(1, "tr", "Table__row candystripe", [(0, o.createVNode)(1, "td", null, e.name, 0), (0, o.createVNode)(1, "td", "Table__cell text-right text-nowrap", (0, o.createComponentVNode)(2, p, { charging: e.charging, charge: e.charge }), 2), (0, o.createVNode)(1, "td", "Table__cell text-right text-nowrap", e.load, 0), (0, o.createVNode)(1, "td", "Table__cell text-center text-nowrap", (0, o.createComponentVNode)(2, C, { status: e.eqp }), 2), (0, o.createVNode)(1, "td", "Table__cell text-center text-nowrap", (0, o.createComponentVNode)(2, C, { status: e.lgt }), 2), (0, o.createVNode)(1, "td", "Table__cell text-center text-nowrap", (0, o.createComponentVNode)(2, C, { status: e.env }), 2)], 4, null, e.id);
                    }),
                  ],
                }),
              ],
            }),
          ],
          4
        );
      };
      t.PowerMonitorContent = m;
      var p = function (e) {
        var t = e.charging,
          n = e.charge;
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, l.Icon, {
              width: "18px",
              textAlign: "center",
              name:
                (0 === t && (n > 50 ? "battery-half" : "battery-quarter")) ||
                (1 === t && "bolt") ||
                (2 === t && "battery-full"),
              color:
                (0 === t && (n > 50 ? "yellow" : "red")) ||
                (1 === t && "yellow") ||
                (2 === t && "green"),
            }),
            (0, o.createComponentVNode)(2, l.Box, {
              inline: !0,
              width: "36px",
              textAlign: "right",
              children: (0, c.toFixed)(n) + "%",
            }),
          ],
          4
        );
      };
      p.defaultHooks = i.pureComponentHooks;
      var C = function (e) {
        var t = e.status,
          n = Boolean(2 & t),
          r = Boolean(1 & t),
          a = (n ? "On" : "Off") + " [" + (r ? "auto" : "manual") + "]";
        return (0, o.createComponentVNode)(2, l.ColorBox, {
          color: n ? "good" : "bad",
          content: r ? undefined : "M",
          title: a,
        });
      };
      C.defaultHooks = i.pureComponentHooks;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.StationAlertConsoleContent = t.StationAlertConsole = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.StationAlertConsole = function () {
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 325,
          height: 500,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, i),
          }),
        });
      };
      var i = function (e, t) {
        var n = (0, r.useBackend)(t).data.alarms || [],
          c = n.Fire || [],
          i = n.Atmosphere || [],
          l = n.Power || [];
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, a.Section, {
              title: "Fire Alarms",
              children: (0, o.createVNode)(
                1,
                "ul",
                null,
                [
                  0 === c.length &&
                    (0, o.createVNode)(
                      1,
                      "li",
                      "color-good",
                      "Systems Nominal",
                      16
                    ),
                  c.map(function (e) {
                    return (0,
                    o.createVNode)(1, "li", "color-average", e, 0, null, e);
                  }),
                ],
                0
              ),
            }),
            (0, o.createComponentVNode)(2, a.Section, {
              title: "Atmospherics Alarms",
              children: (0, o.createVNode)(
                1,
                "ul",
                null,
                [
                  0 === i.length &&
                    (0, o.createVNode)(
                      1,
                      "li",
                      "color-good",
                      "Systems Nominal",
                      16
                    ),
                  i.map(function (e) {
                    return (0,
                    o.createVNode)(1, "li", "color-average", e, 0, null, e);
                  }),
                ],
                0
              ),
            }),
            (0, o.createComponentVNode)(2, a.Section, {
              title: "Power Alarms",
              children: (0, o.createVNode)(
                1,
                "ul",
                null,
                [
                  0 === l.length &&
                    (0, o.createVNode)(
                      1,
                      "li",
                      "color-good",
                      "Systems Nominal",
                      16
                    ),
                  l.map(function (e) {
                    return (0,
                    o.createVNode)(1, "li", "color-average", e, 0, null, e);
                  }),
                ],
                0
              ),
            }),
          ],
          4
        );
      };
      t.StationAlertConsoleContent = i;
    },
    ,
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.PortableBasicInfo = void 0);
      var o = n(0),
        r = n(2),
        a = n(1);
      t.PortableBasicInfo = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          l = i.connected,
          d = i.holding,
          u = i.on,
          s = i.pressure;
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, a.Section, {
              title: "Status",
              buttons: (0, o.createComponentVNode)(2, a.Button, {
                icon: u ? "power-off" : "times",
                content: u ? "On" : "Off",
                selected: u,
                onClick: function () {
                  return c("power");
                },
              }),
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Pressure",
                    children: [
                      (0, o.createComponentVNode)(2, a.AnimatedNumber, {
                        value: s,
                      }),
                      " kPa",
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Port",
                    color: l ? "good" : "average",
                    children: l ? "Connected" : "Not Connected",
                  }),
                ],
              }),
            }),
            (0, o.createComponentVNode)(2, a.Section, {
              title: "Holding Tank",
              minHeight: "82px",
              buttons: (0, o.createComponentVNode)(2, a.Button, {
                icon: "eject",
                content: "Eject",
                disabled: !d,
                onClick: function () {
                  return c("eject");
                },
              }),
              children: d
                ? (0, o.createComponentVNode)(2, a.LabeledList, {
                    children: [
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Label",
                        children: d.name,
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Pressure",
                        children: [
                          (0, o.createComponentVNode)(2, a.AnimatedNumber, {
                            value: d.pressure,
                          }),
                          " kPa",
                        ],
                      }),
                    ],
                  })
                : (0, o.createComponentVNode)(2, a.Box, {
                    color: "average",
                    children: "No holding tank",
                  }),
            }),
          ],
          4
        );
      };
    },
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    function (e, t, n) {
      n(149), (e.exports = n(449));
    },
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    function (e, t, n) {
      "use strict";
      var o = n(0);
      n(451),
        n(452),
        n(453),
        n(454),
        n(455),
        n(456),
        n(457),
        n(458),
        n(459),
        n(460),
        n(461),
        n(462);
      var r,
        a,
        c = n(99),
        i = (n(100), n(136)),
        l = n(187),
        d = n(137),
        u = n(188),
        s = n(51);
      c.perf.mark(
        "inception",
        null == (r = window.performance) || null == (a = r.timing)
          ? void 0
          : a.navigationStart
      ),
        c.perf.mark("init");
      var m = (0, u.configureStore)(),
        p = (0, d.createRenderer)(function () {
          var e = (0, n(490).getRoutedComponent)(m);
          return (0,
          o.createComponentVNode)(2, u.StoreProvider, { store: m, children: (0, o.createComponentVNode)(2, e) });
        });
      !(function C() {
        if ("loading" !== document.readyState) {
          for (
            (0, s.setupGlobalEvents)(),
              (0, i.setupHotKeys)(),
              (0, l.captureExternalLinks)(),
              m.subscribe(p),
              window.update = function (e) {
                return m.dispatch(Byond.parseJson(e));
              };
            ;

          ) {
            var e = window.__updateQueue__.shift();
            if (!e) break;
            window.update(e);
          }
          0;
        } else document.addEventListener("DOMContentLoaded", C);
      })();
    },
    ,
    function (e, t, n) {},
    function (e, t, n) {},
    function (e, t, n) {},
    function (e, t, n) {},
    function (e, t, n) {},
    function (e, t, n) {},
    function (e, t, n) {},
    function (e, t, n) {},
    function (e, t, n) {},
    function (e, t, n) {},
    function (e, t, n) {},
    function (e, t, n) {},
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.getRoutedComponent = void 0);
      var o = n(0),
        r = n(2),
        a = (n(192), n(3)),
        c = n(491),
        i = function (e, t) {
          return function () {
            return (0, o.createComponentVNode)(2, a.Window, {
              resizable: !0,
              children: (0, o.createComponentVNode)(2, a.Window.Content, {
                scrollable: !0,
                children: [
                  "notFound" === e &&
                    (0, o.createVNode)(
                      1,
                      "div",
                      null,
                      [
                        (0, o.createTextVNode)("Interface "),
                        (0, o.createVNode)(1, "b", null, t, 0),
                        (0, o.createTextVNode)(" was not found."),
                      ],
                      4
                    ),
                  "missingExport" === e &&
                    (0, o.createVNode)(
                      1,
                      "div",
                      null,
                      [
                        (0, o.createTextVNode)("Interface "),
                        (0, o.createVNode)(1, "b", null, t, 0),
                        (0, o.createTextVNode)(" is missing an export."),
                      ],
                      4
                    ),
                ],
              }),
            });
          };
        },
        l = function () {
          return (0, o.createComponentVNode)(2, a.Window, {
            resizable: !0,
            children: (0, o.createComponentVNode)(2, a.Window.Content, {
              scrollable: !0,
            }),
          });
        };
      t.getRoutedComponent = function (e) {
        var t = e.getState(),
          n = (0, r.selectBackend)(t),
          o = n.suspended,
          a = n.config;
        if (o) return l;
        var d,
          u = null == a ? void 0 : a["interface"];
        try {
          d = c("./" + u + ".js");
        } catch (m) {
          if ("MODULE_NOT_FOUND" === m.code) return i("notFound", u);
          throw m;
        }
        var s = d[u];
        return s || i("missingExport", u);
      };
    },
    function (e, t, n) {
      var o = {
        "./AdminSecretsPanel.js": 492,
        "./AdvancedAirlockController.js": 493,
        "./AiAirlock.js": 494,
        "./AiRestorer.js": 203,
        "./AirAlarm.js": 495,
        "./AirlockElectronics.js": 496,
        "./Apc.js": 497,
        "./AtmosAlertConsole.js": 498,
        "./AtmosControlConsole.js": 499,
        "./AtmosFilter.js": 500,
        "./AtmosMixer.js": 501,
        "./AtmosPump.js": 502,
        "./AutomatedAnnouncement.js": 503,
        "./BankMachine.js": 504,
        "./Biogenerator.js": 505,
        "./BluespaceArtillery.js": 506,
        "./BorgPanel.js": 507,
        "./BottleDispenser.js": 508,
        "./BrigTimer.js": 509,
        "./CameraConsole.js": 510,
        "./Canister.js": 511,
        "./Canvas.js": 512,
        "./Cargo.js": 205,
        "./CargoExpress.js": 513,
        "./CargoHoldTerminal.js": 514,
        "./CellularEmporium.js": 515,
        "./CentcomPodLauncher.js": 516,
        "./ChemAcclimator.js": 517,
        "./ChemDebugSynthesizer.js": 518,
        "./ChemDispenser.js": 519,
        "./ChemFilter.js": 520,
        "./ChemHeater.js": 521,
        "./ChemMaster.js": 522,
        "./ChemPress.js": 523,
        "./ChemReactionChamber.js": 524,
        "./ChemSplitter.js": 525,
        "./ChemSynthesizer.js": 526,
        "./ClockworkSlab.js": 527,
        "./CodexGigas.js": 528,
        "./ComputerFabricator.js": 529,
        "./Crayon.js": 530,
        "./CrewConsole.js": 531,
        "./Cryo.js": 532,
        "./DecalPainter.js": 533,
        "./DisposalUnit.js": 534,
        "./DnaVault.js": 535,
        "./EightBallVote.js": 536,
        "./Electropack.js": 537,
        "./EmergencyShuttleConsole.js": 538,
        "./EngravedMessage.js": 539,
        "./ExosuitControlConsole.js": 540,
        "./ForbiddenLore.js": 541,
        "./Gps.js": 542,
        "./GravityGenerator.js": 543,
        "./Guardian.js": 544,
        "./GulagItemReclaimer.js": 545,
        "./GulagTeleporterConsole.js": 546,
        "./Holodeck.js": 547,
        "./HypnoChair.js": 548,
        "./ImplantChair.js": 549,
        "./InfraredEmitter.js": 550,
        "./Intellicard.js": 551,
        "./KeycardAuth.js": 552,
        "./LaborClaimConsole.js": 553,
        "./LanguageMenu.js": 554,
        "./LaunchpadConsole.js": 206,
        "./LaunchpadRemote.js": 555,
        "./MechBayPowerConsole.js": 556,
        "./MiningVendor.js": 557,
        "./Mint.js": 558,
        "./ModularFabricator.js": 559,
        "./Mule.js": 560,
        "./NaniteChamberControl.js": 561,
        "./NaniteCloudControl.js": 562,
        "./NaniteProgramHub.js": 563,
        "./NaniteProgrammer.js": 564,
        "./NaniteRemote.js": 565,
        "./NotificationPreferences.js": 566,
        "./NtnetRelay.js": 567,
        "./NtosAiRestorer.js": 568,
        "./NtosArcade.js": 569,
        "./NtosAtmos.js": 570,
        "./NtosCard.js": 571,
        "./NtosConfiguration.js": 572,
        "./NtosCrewManifest.js": 573,
        "./NtosCyborgRemoteMonitor.js": 574,
        "./NtosFileManager.js": 575,
        "./NtosJobManager.js": 576,
        "./NtosMain.js": 577,
        "./NtosNetChat.js": 578,
        "./NtosNetDos.js": 579,
        "./NtosNetDownloader.js": 580,
        "./NtosNetMonitor.js": 581,
        "./NtosPowerMonitor.js": 582,
        "./NtosRevelation.js": 583,
        "./NtosRoboControl.js": 584,
        "./NtosStationAlertConsole.js": 585,
        "./NtosSupermatterMonitor.js": 586,
        "./NuclearBomb.js": 587,
        "./OperatingComputer.js": 588,
        "./Orbit.js": 589,
        "./OreBox.js": 590,
        "./OreRedemptionMachine.js": 591,
        "./Pandemic.js": 592,
        "./PaperSheet.js": 593,
        "./ParticleAccelerator.js": 595,
        "./PatchDispenser.js": 596,
        "./PersonalCrafting.js": 597,
        "./PortableGenerator.js": 598,
        "./PortablePump.js": 599,
        "./PortableScrubber.js": 600,
        "./PowerMonitor.js": 207,
        "./ProximitySensor.js": 601,
        "./RDConsole.js": 602,
        "./Radio.js": 603,
        "./RadioactiveMicrolaser.js": 604,
        "./RapidPipeDispenser.js": 605,
        "./RoboticsControlConsole.js": 606,
        "./SatelliteControl.js": 607,
        "./ScannerGate.js": 608,
        "./ShuttleManipulator.js": 609,
        "./Signaler.js": 610,
        "./Sleeper.js": 611,
        "./SlimeBodySwapper.js": 612,
        "./SmartVend.js": 613,
        "./Smes.js": 614,
        "./SmokeMachine.js": 615,
        "./SolarControl.js": 616,
        "./SpaceHeater.js": 617,
        "./SpawnersMenu.js": 618,
        "./StationAlertConsole.js": 208,
        "./SuitStorageUnit.js": 619,
        "./SyndContractor.js": 620,
        "./TachyonArray.js": 621,
        "./Tank.js": 622,
        "./TankDispenser.js": 623,
        "./Teleporter.js": 624,
        "./ThermoMachine.js": 625,
        "./TicketBrowser.js": 626,
        "./TicketMessenger.js": 627,
        "./Timer.js": 628,
        "./TransferValve.js": 629,
        "./TurbineComputer.js": 630,
        "./TurboLift.js": 631,
        "./TurretControl.js": 632,
        "./Uplink.js": 633,
        "./Vending.js": 634,
        "./Vote.js": 635,
        "./Wires.js": 636,
      };
      function r(e) {
        var t = a(e);
        return n(t);
      }
      function a(e) {
        if (!n.o(o, e)) {
          var t = new Error("Cannot find module '" + e + "'");
          throw ((t.code = "MODULE_NOT_FOUND"), t);
        }
        return o[e];
      }
      (r.keys = function () {
        return Object.keys(o);
      }),
        (r.resolve = a),
        (e.exports = r),
        (r.id = 491);
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.AdminSecretsPanel = void 0);
      var o,
        r = n(0),
        a = n(19),
        c = n(2),
        i = n(1),
        l = n(3),
        d =
          (n(6),
          (o = [
            "The first rule of adminbuse is: you don't talk about the adminbuse.",
            "Oh, this is gonna be fun.",
            "ADMIN, HE'S DOING IT SIDEWAYS!",
            "What flavor of admemes are we having today?",
            "Mass Purrbation. You know you want to.",
            "What does this button do?",
            "NOO YOU CANT JUST ABUSE YOUR POWERS LIKE THAT",
            "haha admin machine go bwoink",
            "RDM RDM RDM RDM",
            "admin man grief ban he",
            "NOOO ADMEMIN IS RUINING MY IMMERSION NOOOOOOOOOOOO",
          ])[Math.floor(Math.random() * o.length)]);
      t.AdminSecretsPanel = function (e, t) {
        var n = (0, c.useBackend)(t),
          o = n.act,
          u = n.data.Categories,
          s = void 0 === u ? [] : u,
          m = (0, c.useLocalState)(t, "searchText", ""),
          p = m[0],
          C = m[1],
          h = (0, a.createSearch)(p, function (e) {
            return e;
          }),
          N = function (e) {
            return h(e[0]);
          },
          V = (0, r.createComponentVNode)(2, i.Section, {
            title: (0, r.createComponentVNode)(2, i.Table, {
              children: (0, r.createComponentVNode)(2, i.Table.Row, {
                children: [
                  (0, r.createComponentVNode)(2, i.Table.Cell, { children: d }),
                  (0, r.createComponentVNode)(2, i.Table.Cell, {
                    textAlign: "right",
                    children: (0, r.createComponentVNode)(2, i.Input, {
                      placeholder: "Search",
                      value: p,
                      onInput: function (e, t) {
                        return C(t);
                      },
                      mx: 1,
                    }),
                  }),
                ],
              }),
            }),
          }),
          b = function (e) {
            return (0, r.createComponentVNode)(2, i.Flex.Item, {
              grow: 1,
              basis: "49%",
              children: (0, r.createComponentVNode)(2, i.Button, {
                fluid: !0,
                ellipsis: !0,
                my: 0.5,
                onClick: function () {
                  return o(e[1]);
                },
                content: e[0],
              }),
            });
          },
          f = Object.entries(s).map(function (e) {
            var t = e[1].filter(N).map(b);
            if (t.length)
              return (0, r.createComponentVNode)(
                2,
                i.Collapsible,
                {
                  title: e[0] + " (" + t.length + ")",
                  bold: !0,
                  children: (0, r.createComponentVNode)(2, i.Section, {
                    children: (0, r.createComponentVNode)(2, i.Flex, {
                      spacing: 1,
                      wrap: "wrap",
                      textAlign: "center",
                      justify: "center",
                      children: t,
                    }),
                  }),
                },
                !0
              );
          });
        return (0, r.createComponentVNode)(2, l.Window, {
          width: 720,
          height: 480,
          resizable: !0,
          children: (0, r.createComponentVNode)(2, l.Window.Content, {
            scrollable: !0,
            children: [
              V,
              (0, r.createComponentVNode)(2, i.Section, {
                children: [f, f && 0 === f.length && "No results found."],
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.Airlock = t.Vent = t.AACControl = t.AACStatus = t.AdvancedAirlockController = void 0);
      var o = n(0),
        r = n(8),
        a = n(19),
        c = n(2),
        i = n(1),
        l = n(59),
        d = n(6),
        u = n(3);
      t.AdvancedAirlockController = function (e, t) {
        var n = e.state,
          r = (0, c.useBackend)(t),
          a = r.act,
          i = r.data,
          d = i.locked && !i.siliconUser;
        return (0, o.createComponentVNode)(2, u.Window, {
          width: 440,
          height: 650,
          children: (0, o.createComponentVNode)(2, u.Window.Content, {
            children: (0, o.createFragment)(
              [
                (0, o.createComponentVNode)(2, l.InterfaceLockNoticeBox, {
                  siliconUser: i.siliconUser,
                  locked: i.locked,
                  onLockStatusChange: function () {
                    return a("lock");
                  },
                }),
                (0, o.createComponentVNode)(2, s, { state: n }),
                !d && (0, o.createComponentVNode)(2, m, { state: n }),
              ],
              0
            ),
          }),
        });
      };
      var s = function (e, t) {
        var n,
          a = (0, c.useBackend)(t),
          l = a.act,
          d = a.data,
          u = d.cyclestate,
          s = d.pressure,
          m = d.maxpressure,
          p = d.emagged,
          C =
            (((n = {})[0] = {
              color: "good",
              localStatusText: "Cycled to interior",
            }),
            (n[1] = {
              color: "average",
              localStatusText: "Pressurizing (interior)",
            }),
            (n[2] = {
              color: "average",
              localStatusText: "Depressurizing (interior)",
            }),
            (n[6] = { color: "good", localStatusText: "Cycled to exterior" }),
            (n[5] = {
              color: "average",
              localStatusText: "Pressurizing (exterior)",
            }),
            (n[4] = {
              color: "average",
              localStatusText: "Depressurizing (exterior)",
            }),
            (n[3] = { color: "average", localStatusText: "Unknown" }),
            (n[-1] = { color: "good", localStatusText: "Shuttle Docked" }),
            (n[-2] = {
              color: "bad",
              localStatusText:
                "Error. Contact an atmospheric      technician for assistance.",
            }),
            n),
          h = C[u] || C[0],
          N = h.color,
          V = h.localStatusText;
        return (0, o.createComponentVNode)(2, i.Section, {
          title: "Airlock Status",
          children: [
            (0, o.createComponentVNode)(2, i.LabeledList, {
              children: (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                    label: "Pressure",
                    children: (0, o.createComponentVNode)(2, i.ProgressBar, {
                      ranges: {
                        good: [0.75, Infinity],
                        average: [0.25, 0.75],
                        bad: [-Infinity, 0.25],
                      },
                      value: s / m,
                      children: [(0, r.toFixed)(s, 2), " kPa"],
                    }),
                  }),
                  (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                    label: "Status",
                    color: N,
                    children: V,
                  }),
                  !!p &&
                    (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                      label: "Warning",
                      color: "bad",
                      children:
                        "Safety measures offline. Device may exhibit abnormal behaviour.",
                    }),
                  (0, o.createComponentVNode)(2, i.LabeledList.Item),
                ],
                0
              ),
            }),
            (0 === u || 3 === u || 1 === u || 4 === u) &&
              (0, o.createComponentVNode)(2, i.Button, {
                icon: "sync-alt",
                content: "Cycle to Exterior",
                onClick: function () {
                  return l("cycle", { exterior: 1 });
                },
              }),
            (6 === d.cyclestate ||
              3 === d.cyclestate ||
              5 === d.cyclestate ||
              2 === d.cyclestate) &&
              (0, o.createComponentVNode)(2, i.Button, {
                icon: "sync-alt",
                content: "Cycle to Interior",
                onClick: function () {
                  return l("cycle", { exterior: 0 });
                },
              }),
            (5 === d.cyclestate ||
              1 === d.cyclestate ||
              4 === d.cyclestate ||
              2 === d.cyclestate) &&
              (0, o.createComponentVNode)(2, i.Button, {
                icon: "forward",
                content:
                  "Skip " +
                  (5 === d.cyclestate || 1 === d.cyclestate
                    ? "pressurization"
                    : "depressurization") +
                  (d.skip_timer < d.skip_delay
                    ? " (in " +
                      Math.round((d.skip_delay - d.skip_timer) / 10) +
                      " seconds)"
                    : ""),
                color: "danger",
                disabled: d.skip_timer < d.skip_delay,
                onClick: function () {
                  return l("skip");
                },
              }),
          ],
        });
      };
      t.AACStatus = s;
      var m = function (e, t) {
        var n = (0, c.useBackend)(t),
          r = n.act,
          a = n.data,
          l = e.state,
          u = a.cyclestate,
          s = a.config_error_str,
          m = a.interior_pressure,
          h = a.exterior_pressure,
          N = a.depressurization_margin,
          V = a.skip_delay,
          b = a.vents,
          f = a.airlocks;
        return (0, o.createComponentVNode)(2, i.Section, {
          title: "Configuration",
          children: [
            -2 === u &&
              !!s &&
              (0, o.createComponentVNode)(2, i.Box, {
                className: (0, d.classes)(["NoticeBox"]),
                children: s,
              }),
            (0, o.createComponentVNode)(2, i.LabeledList, {
              children: [
                (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                  label: "Actions",
                  children: (0, o.createComponentVNode)(2, i.Button, {
                    icon: "search",
                    content: "Scan for Devices",
                    onClick: function () {
                      return r("scan");
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                  label: "Interior Pressure",
                  children: (0, o.createComponentVNode)(2, i.NumberInput, {
                    animated: !0,
                    value: parseFloat(m),
                    unit: "kPa",
                    width: "125px",
                    minValue: 0,
                    maxValue: 102,
                    step: 1,
                    onChange: function (e, t) {
                      return r("interior_pressure", { pressure: t });
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                  label: "Exterior Pressure",
                  children: (0, o.createComponentVNode)(2, i.NumberInput, {
                    animated: !0,
                    value: parseFloat(h),
                    unit: "kPa",
                    width: "125px",
                    minValue: 0,
                    maxValue: 101.325,
                    step: 1,
                    onChange: function (e, t) {
                      return r("exterior_pressure", { pressure: t });
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                  label: "Depressurization Margin",
                  children: (0, o.createComponentVNode)(2, i.NumberInput, {
                    animated: !0,
                    value: parseFloat(N),
                    unit: "kPa",
                    width: "125px",
                    minValue: 0.15,
                    maxValue: 40,
                    step: 1,
                    onChange: function (e, t) {
                      return r("depressurization_margin", { pressure: t });
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                  label: "Time before Skip Allowed",
                  children: (0, o.createComponentVNode)(2, i.NumberInput, {
                    animated: !0,
                    value: Math.round(parseFloat(V)) / 10,
                    unit: "seconds",
                    width: "125px",
                    minValue: 0,
                    maxValue: 120,
                    step: 1,
                    onChange: function (e, t) {
                      return r("skip_delay", { skip_delay: 10 * t });
                    },
                  }),
                }),
              ],
            }),
            b && 0 !== b.length
              ? b.map(function (e) {
                  return (0,
                  o.normalizeProps)((0, o.createComponentVNode)(2, p, Object.assign({ state: l }, e), e.vent_id));
                })
              : (0, o.createComponentVNode)(2, i.Box, {
                  className: (0, d.classes)(["NoticeBox"]),
                  children: "No vents",
                }),
            f && 0 !== f.length
              ? f.map(function (e) {
                  return (0,
                  o.normalizeProps)((0, o.createComponentVNode)(2, C, Object.assign({ state: l }, e), e.airlock_id));
                })
              : (0, o.createComponentVNode)(2, i.Box, {
                  className: (0, d.classes)(["NoticeBox"]),
                  children: "No Airlocks",
                }),
          ],
        });
      };
      t.AACControl = m;
      var p = function (e, t) {
        var n = (0, c.useBackend)(t),
          r = n.act,
          l = n.data,
          d = e.vent_id,
          u = e.name,
          s = e.role;
        return (0, o.createComponentVNode)(2, i.Section, {
          level: 2,
          title: (0, a.decodeHtmlEntities)(u),
          buttons: (0, o.createComponentVNode)(2, i.Button, {
            content: "Show Hologram",
            selected: l.vis_target === d,
            onClick: function () {
              return r(l.vis_target === d ? "clear_vis" : "set_vis_vent", {
                vent_id: d,
              });
            },
          }),
          children: (0, o.createComponentVNode)(2, i.LabeledList, {
            children: (0, o.createComponentVNode)(2, i.LabeledList.Item, {
              label: "Roles",
              children: [
                (0, o.createComponentVNode)(2, i.Button, {
                  icon: "sign-out-alt",
                  content: "Int. Pressurize",
                  selected: !!(1 & s),
                  onClick: function () {
                    return r("toggle_role", { vent_id: d, val: 1 });
                  },
                }),
                (0, o.createComponentVNode)(2, i.Button, {
                  icon: "sign-in-alt",
                  content: "Int. Depressurize",
                  selected: !!(2 & s),
                  onClick: function () {
                    return r("toggle_role", { vent_id: d, val: 2 });
                  },
                }),
                (0, o.createComponentVNode)(2, i.Button, {
                  icon: "sign-out-alt",
                  content: "Ext. Pressurize",
                  selected: !!(4 & s),
                  onClick: function () {
                    return r("toggle_role", { vent_id: d, val: 4 });
                  },
                }),
                (0, o.createComponentVNode)(2, i.Button, {
                  icon: "sign-in-alt",
                  content: "Ext. Depressurize",
                  selected: !!(8 & s),
                  onClick: function () {
                    return r("toggle_role", { vent_id: d, val: 8 });
                  },
                }),
              ],
            }),
          }),
        });
      };
      t.Vent = p;
      var C = function (e, t) {
        var n = (0, c.useBackend)(t),
          r = n.act,
          l = n.data,
          d = e.airlock_id,
          u = e.name,
          s = e.role,
          m = e.access;
        return (0, o.createComponentVNode)(2, i.Section, {
          level: 2,
          title: (0, a.decodeHtmlEntities)(u),
          buttons: (0, o.createComponentVNode)(2, i.Button, {
            content: "Show Hologram",
            selected: l.vis_target === d,
            onClick: function () {
              return r(l.vis_target === d ? "clear_vis" : "set_vis_airlock", {
                airlock_id: d,
              });
            },
          }),
          children: (0, o.createComponentVNode)(2, i.LabeledList, {
            children: [
              (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                label: "Roles",
                children: [
                  (0, o.createComponentVNode)(2, i.Button, {
                    icon: "sign-in-alt",
                    content: "Interior",
                    selected: !s,
                    onClick: function () {
                      return r("set_airlock_role", { airlock_id: d, val: 0 });
                    },
                  }),
                  (0, o.createComponentVNode)(2, i.Button, {
                    icon: "sign-out-alt",
                    content: "Exterior",
                    selected: !!s,
                    onClick: function () {
                      return r("set_airlock_role", { airlock_id: d, val: 1 });
                    },
                  }),
                ],
              }),
              (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                label: "Access",
                children: m,
              }),
            ],
          }),
        });
      };
      t.Airlock = C;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.AiAirlock = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = {
          2: { color: "good", localStatusText: "Offline" },
          1: { color: "average", localStatusText: "Caution" },
          0: { color: "bad", localStatusText: "Optimal" },
        };
      t.AiAirlock = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = i[d.power.main] || i[0],
          s = i[d.power.backup] || i[0],
          m = i[d.shock] || i[0];
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 500,
          height: 390,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Power Status",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Main",
                      color: u.color,
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: "lightbulb-o",
                        disabled: !d.power.main,
                        content: "Disrupt",
                        onClick: function () {
                          return l("disrupt-main");
                        },
                      }),
                      children: [
                        d.power.main ? "Online" : "Offline",
                        " ",
                        d.wires.main_1 && d.wires.main_2
                          ? d.power.main_timeleft > 0 &&
                            "[" + d.power.main_timeleft + "s]"
                          : "[Wires have been cut!]",
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Backup",
                      color: s.color,
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: "lightbulb-o",
                        disabled: !d.power.backup,
                        content: "Disrupt",
                        onClick: function () {
                          return l("disrupt-backup");
                        },
                      }),
                      children: [
                        d.power.backup ? "Online" : "Offline",
                        " ",
                        d.wires.backup_1 && d.wires.backup_2
                          ? d.power.backup_timeleft > 0 &&
                            "[" + d.power.backup_timeleft + "s]"
                          : "[Wires have been cut!]",
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Electrify",
                      color: m.color,
                      buttons: (0, o.createFragment)(
                        [
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "wrench",
                            disabled: !(d.wires.shock && 0 === d.shock),
                            content: "Restore",
                            onClick: function () {
                              return l("shock-restore");
                            },
                          }),
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "bolt",
                            disabled: !d.wires.shock,
                            content: "Temporary",
                            onClick: function () {
                              return l("shock-temp");
                            },
                          }),
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "bolt",
                            disabled: !d.wires.shock,
                            content: "Permanent",
                            onClick: function () {
                              return l("shock-perm");
                            },
                          }),
                        ],
                        4
                      ),
                      children: [
                        2 === d.shock ? "Safe" : "Electrified",
                        " ",
                        (d.wires.shock
                          ? d.shock_timeleft > 0 &&
                            "[" + d.shock_timeleft + "s]"
                          : "[Wires have been cut!]") ||
                          (-1 === d.shock_timeleft && "[Permanent]"),
                      ],
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Access and Door Control",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "ID Scan",
                      color: "bad",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: d.id_scanner ? "power-off" : "times",
                        content: d.id_scanner ? "Enabled" : "Disabled",
                        selected: d.id_scanner,
                        disabled: !d.wires.id_scanner,
                        onClick: function () {
                          return l("idscan-toggle");
                        },
                      }),
                      children: !d.wires.id_scanner && "[Wires have been cut!]",
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Emergency Access",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: d.emergency ? "power-off" : "times",
                        content: d.emergency ? "Enabled" : "Disabled",
                        selected: d.emergency,
                        onClick: function () {
                          return l("emergency-toggle");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Divider),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Door Bolts",
                      color: "bad",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: d.locked ? "lock" : "unlock",
                        content: d.locked ? "Lowered" : "Raised",
                        selected: d.locked,
                        disabled: !d.wires.bolts,
                        onClick: function () {
                          return l("bolt-toggle");
                        },
                      }),
                      children: !d.wires.bolts && "[Wires have been cut!]",
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Door Bolt Lights",
                      color: "bad",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: d.lights ? "power-off" : "times",
                        content: d.lights ? "Enabled" : "Disabled",
                        selected: d.lights,
                        disabled: !d.wires.lights,
                        onClick: function () {
                          return l("light-toggle");
                        },
                      }),
                      children: !d.wires.lights && "[Wires have been cut!]",
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Door Force Sensors",
                      color: "bad",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: d.safe ? "power-off" : "times",
                        content: d.safe ? "Enabled" : "Disabled",
                        selected: d.safe,
                        disabled: !d.wires.safe,
                        onClick: function () {
                          return l("safe-toggle");
                        },
                      }),
                      children: !d.wires.safe && "[Wires have been cut!]",
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Door Timing Safety",
                      color: "bad",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: d.speed ? "power-off" : "times",
                        content: d.speed ? "Enabled" : "Disabled",
                        selected: d.speed,
                        disabled: !d.wires.timing,
                        onClick: function () {
                          return l("speed-toggle");
                        },
                      }),
                      children: !d.wires.timing && "[Wires have been cut!]",
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Divider),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Door Control",
                      color: "bad",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: d.opened ? "sign-out-alt" : "sign-in-alt",
                        content: d.opened ? "Open" : "Closed",
                        selected: d.opened,
                        disabled: d.locked || d.welded,
                        onClick: function () {
                          return l("open-close");
                        },
                      }),
                      children:
                        !(!d.locked && !d.welded) &&
                        (0, o.createVNode)(
                          1,
                          "span",
                          null,
                          [
                            (0, o.createTextVNode)("[Door is "),
                            d.locked ? "bolted" : "",
                            d.locked && d.welded ? " and " : "",
                            d.welded ? "welded" : "",
                            (0, o.createTextVNode)("!]"),
                          ],
                          0
                        ),
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.AirAlarm = void 0);
      var o = n(0),
        r = n(8),
        a = n(19),
        c = n(2),
        i = n(1),
        l = n(44),
        d = n(3),
        u = n(59);
      t.AirAlarm = function (e, t) {
        var n = (0, c.useBackend)(t),
          r = (n.act, n.data),
          a = r.locked && !r.siliconUser;
        return (0, o.createComponentVNode)(2, d.Window, {
          resizable: !0,
          width: 440,
          height: 650,
          children: (0, o.createComponentVNode)(2, d.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, u.InterfaceLockNoticeBox),
              (0, o.createComponentVNode)(2, s),
              !a && (0, o.createComponentVNode)(2, p),
            ],
          }),
        });
      };
      var s = function (e, t) {
          var n = (0, c.useBackend)(t).data,
            a = (n.environment_data || []).filter(function (e) {
              return e.value >= 0.01;
            }),
            l = {
              0: { color: "good", localStatusText: "Optimal" },
              1: { color: "average", localStatusText: "Caution" },
              2: {
                color: "bad",
                localStatusText: "Danger (Internals Required)",
              },
            },
            d = l[n.danger_level] || l[0];
          return (0, o.createComponentVNode)(2, i.Section, {
            title: "Air Status",
            children: (0, o.createComponentVNode)(2, i.LabeledList, {
              children: [
                (a.length > 0 &&
                  (0, o.createFragment)(
                    [
                      a.map(function (e) {
                        var t = l[e.danger_level] || l[0];
                        return (0,
                        o.createComponentVNode)(2, i.LabeledList.Item, { label: e.name, color: t.color, children: [(0, r.toFixed)(e.value, 2), e.unit] }, e.name);
                      }),
                      (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                        label: "Local status",
                        color: d.color,
                        children: d.localStatusText,
                      }),
                      (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                        label: "Area status",
                        color: n.atmos_alarm || n.fire_alarm ? "bad" : "good",
                        children:
                          (n.atmos_alarm
                            ? "Atmosphere Alarm"
                            : n.fire_alarm && "Fire Alarm") || "Nominal",
                      }),
                    ],
                    0
                  )) ||
                  (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                    label: "Warning",
                    color: "bad",
                    children: "Cannot obtain air sample for analysis.",
                  }),
                !!n.emagged &&
                  (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                    label: "Warning",
                    color: "bad",
                    children:
                      "Safety measures offline. Device may exhibit abnormal behavior.",
                  }),
              ],
            }),
          });
        },
        m = {
          home: {
            title: "Air Controls",
            component: function () {
              return C;
            },
          },
          vents: {
            title: "Vent Controls",
            component: function () {
              return h;
            },
          },
          scrubbers: {
            title: "Scrubber Controls",
            component: function () {
              return V;
            },
          },
          modes: {
            title: "Operating Mode",
            component: function () {
              return f;
            },
          },
          thresholds: {
            title: "Alarm Thresholds",
            component: function () {
              return g;
            },
          },
        },
        p = function (e, t) {
          var n = (0, c.useLocalState)(t, "screen"),
            r = n[0],
            a = n[1],
            l = m[r] || m.home,
            d = l.component();
          return (0, o.createComponentVNode)(2, i.Section, {
            title: l.title,
            buttons:
              r &&
              (0, o.createComponentVNode)(2, i.Button, {
                icon: "arrow-left",
                content: "Back",
                onClick: function () {
                  return a();
                },
              }),
            children: (0, o.createComponentVNode)(2, d),
          });
        },
        C = function (e, t) {
          var n = (0, c.useBackend)(t),
            r = n.act,
            a = n.data,
            l = (0, c.useLocalState)(t, "screen"),
            d = (l[0], l[1]),
            u = a.mode,
            s = a.atmos_alarm;
          return (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, i.Button, {
                icon: s ? "exclamation-triangle" : "exclamation",
                color: s && "caution",
                content: "Area Atmosphere Alarm",
                onClick: function () {
                  return r(s ? "reset" : "alarm");
                },
              }),
              (0, o.createComponentVNode)(2, i.Box, { mt: 1 }),
              (0, o.createComponentVNode)(2, i.Button, {
                icon: 3 === u ? "exclamation-triangle" : "exclamation",
                color: 3 === u && "danger",
                content: "Panic Siphon",
                onClick: function () {
                  return r("mode", { mode: 3 === u ? 1 : 3 });
                },
              }),
              (0, o.createComponentVNode)(2, i.Box, { mt: 2 }),
              (0, o.createComponentVNode)(2, i.Button, {
                icon: "sign-out-alt",
                content: "Vent Controls",
                onClick: function () {
                  return d("vents");
                },
              }),
              (0, o.createComponentVNode)(2, i.Box, { mt: 1 }),
              (0, o.createComponentVNode)(2, i.Button, {
                icon: "filter",
                content: "Scrubber Controls",
                onClick: function () {
                  return d("scrubbers");
                },
              }),
              (0, o.createComponentVNode)(2, i.Box, { mt: 1 }),
              (0, o.createComponentVNode)(2, i.Button, {
                icon: "cog",
                content: "Operating Mode",
                onClick: function () {
                  return d("modes");
                },
              }),
              (0, o.createComponentVNode)(2, i.Box, { mt: 1 }),
              (0, o.createComponentVNode)(2, i.Button, {
                icon: "chart-bar",
                content: "Alarm Thresholds",
                onClick: function () {
                  return d("thresholds");
                },
              }),
            ],
            4
          );
        },
        h = function (e, t) {
          var n = (0, c.useBackend)(t).data.vents;
          return n && 0 !== n.length
            ? n.map(function (e) {
                return (0, o.createComponentVNode)(2, N, { vent: e }, e.id_tag);
              })
            : "Nothing to show";
        },
        N = function (e, t) {
          var n = e.vent,
            r = (0, c.useBackend)(t).act,
            l = n.id_tag,
            d = n.long_name,
            u = n.power,
            s = n.checks,
            m = n.excheck,
            p = n.incheck,
            C = n.direction,
            h = n.external,
            N = n.internal,
            V = n.extdefault,
            b = n.intdefault;
          return (0, o.createComponentVNode)(2, i.Section, {
            level: 2,
            title: (0, a.decodeHtmlEntities)(d),
            buttons: (0, o.createComponentVNode)(2, i.Button, {
              icon: u ? "power-off" : "times",
              selected: u,
              content: u ? "On" : "Off",
              onClick: function () {
                return r("power", { id_tag: l, val: Number(!u) });
              },
            }),
            children: (0, o.createComponentVNode)(2, i.LabeledList, {
              children: [
                (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                  label: "Mode",
                  children: "release" === C ? "Pressurizing" : "Releasing",
                }),
                (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                  label: "Pressure Regulator",
                  children: [
                    (0, o.createComponentVNode)(2, i.Button, {
                      icon: "sign-in-alt",
                      content: "Internal",
                      selected: p,
                      onClick: function () {
                        return r("incheck", { id_tag: l, val: s });
                      },
                    }),
                    (0, o.createComponentVNode)(2, i.Button, {
                      icon: "sign-out-alt",
                      content: "External",
                      selected: m,
                      onClick: function () {
                        return r("excheck", { id_tag: l, val: s });
                      },
                    }),
                  ],
                }),
                !!p &&
                  (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                    label: "Internal Target",
                    children: [
                      (0, o.createComponentVNode)(2, i.NumberInput, {
                        value: Math.round(N),
                        unit: "kPa",
                        width: "75px",
                        minValue: 0,
                        step: 10,
                        maxValue: 5066,
                        onChange: function (e, t) {
                          return r("set_internal_pressure", {
                            id_tag: l,
                            value: t,
                          });
                        },
                      }),
                      (0, o.createComponentVNode)(2, i.Button, {
                        icon: "undo",
                        disabled: b,
                        content: "Reset",
                        onClick: function () {
                          return r("reset_internal_pressure", { id_tag: l });
                        },
                      }),
                    ],
                  }),
                !!m &&
                  (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                    label: "External Target",
                    children: [
                      (0, o.createComponentVNode)(2, i.NumberInput, {
                        value: Math.round(h),
                        unit: "kPa",
                        width: "75px",
                        minValue: 0,
                        step: 10,
                        maxValue: 5066,
                        onChange: function (e, t) {
                          return r("set_external_pressure", {
                            id_tag: l,
                            value: t,
                          });
                        },
                      }),
                      (0, o.createComponentVNode)(2, i.Button, {
                        icon: "undo",
                        disabled: V,
                        content: "Reset",
                        onClick: function () {
                          return r("reset_external_pressure", { id_tag: l });
                        },
                      }),
                    ],
                  }),
              ],
            }),
          });
        },
        V = function (e, t) {
          var n = (0, c.useBackend)(t).data.scrubbers;
          return n && 0 !== n.length
            ? n.map(function (e) {
                return (0,
                o.createComponentVNode)(2, b, { scrubber: e }, e.id_tag);
              })
            : "Nothing to show";
        },
        b = function (e, t) {
          var n = e.scrubber,
            r = (0, c.useBackend)(t).act,
            d = n.long_name,
            u = n.power,
            s = n.scrubbing,
            m = n.id_tag,
            p = n.widenet,
            C = n.filter_types;
          return (0, o.createComponentVNode)(2, i.Section, {
            level: 2,
            title: (0, a.decodeHtmlEntities)(d),
            buttons: (0, o.createComponentVNode)(2, i.Button, {
              icon: u ? "power-off" : "times",
              content: u ? "On" : "Off",
              selected: u,
              onClick: function () {
                return r("power", { id_tag: m, val: Number(!u) });
              },
            }),
            children: (0, o.createComponentVNode)(2, i.LabeledList, {
              children: [
                (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                  label: "Mode",
                  children: [
                    (0, o.createComponentVNode)(2, i.Button, {
                      icon: s ? "filter" : "sign-in-alt",
                      color: s || "danger",
                      content: s ? "Scrubbing" : "Siphoning",
                      onClick: function () {
                        return r("scrubbing", { id_tag: m, val: Number(!s) });
                      },
                    }),
                    (0, o.createComponentVNode)(2, i.Button, {
                      icon: p ? "expand" : "compress",
                      selected: p,
                      content: p ? "Expanded range" : "Normal range",
                      onClick: function () {
                        return r("widenet", { id_tag: m, val: Number(!p) });
                      },
                    }),
                  ],
                }),
                (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                  label: "Filters",
                  children:
                    (s &&
                      C.map(function (e) {
                        return (0, o.createComponentVNode)(
                          2,
                          i.Button,
                          {
                            icon: e.enabled ? "check-square-o" : "square-o",
                            content: (0, l.getGasLabel)(e.gas_id, e.gas_name),
                            title: e.gas_name,
                            selected: e.enabled,
                            onClick: function () {
                              return r("toggle_filter", {
                                id_tag: m,
                                val: e.gas_id,
                              });
                            },
                          },
                          e.gas_id
                        );
                      })) ||
                    "N/A",
                }),
              ],
            }),
          });
        },
        f = function (e, t) {
          var n = (0, c.useBackend)(t),
            r = n.act,
            a = n.data.modes;
          return a && 0 !== a.length
            ? a.map(function (e) {
                return (0, o.createFragment)(
                  [
                    (0, o.createComponentVNode)(2, i.Button, {
                      icon: e.selected ? "check-square-o" : "square-o",
                      selected: e.selected,
                      color: e.selected && e.danger && "danger",
                      content: e.name,
                      onClick: function () {
                        return r("mode", { mode: e.mode });
                      },
                    }),
                    (0, o.createComponentVNode)(2, i.Box, { mt: 1 }),
                  ],
                  4,
                  e.mode
                );
              })
            : "Nothing to show";
        },
        g = function (e, t) {
          var n = (0, c.useBackend)(t),
            a = n.act,
            l = n.data.thresholds;
          return (0, o.createVNode)(
            1,
            "table",
            "LabeledList",
            [
              (0, o.createVNode)(
                1,
                "thead",
                null,
                (0, o.createVNode)(
                  1,
                  "tr",
                  null,
                  [
                    (0, o.createVNode)(1, "td"),
                    (0, o.createVNode)(1, "td", "color-bad", "min2", 16),
                    (0, o.createVNode)(1, "td", "color-average", "min1", 16),
                    (0, o.createVNode)(1, "td", "color-average", "max1", 16),
                    (0, o.createVNode)(1, "td", "color-bad", "max2", 16),
                  ],
                  4
                ),
                2
              ),
              (0, o.createVNode)(
                1,
                "tbody",
                null,
                l.map(function (e) {
                  return (0, o.createVNode)(
                    1,
                    "tr",
                    null,
                    [
                      (0, o.createVNode)(
                        1,
                        "td",
                        "LabeledList__label",
                        e.name,
                        0
                      ),
                      e.settings.map(function (e) {
                        return (0, o.createVNode)(
                          1,
                          "td",
                          null,
                          (0, o.createComponentVNode)(2, i.Button, {
                            content: (0, r.toFixed)(e.selected, 2),
                            onClick: function () {
                              return a("threshold", { env: e.env, var: e.val });
                            },
                          }),
                          2,
                          null,
                          e.val
                        );
                      }),
                    ],
                    0,
                    null,
                    e.name
                  );
                }),
                0
              ),
            ],
            4,
            { style: { width: "100%" } }
          );
        };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.AirlockElectronics = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = n(204);
      t.AirlockElectronics = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.oneAccess,
          s = d.unres_direction,
          m = d.regions || [],
          p = d.accesses || [];
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 420,
          height: 485,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Main",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Access Required",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: u ? "unlock" : "lock",
                        content: u ? "One" : "All",
                        onClick: function () {
                          return l("one_access");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Unrestricted Access",
                      children: [
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: 1 & s ? "check-square-o" : "square-o",
                          content: "North",
                          selected: 1 & s,
                          onClick: function () {
                            return l("direc_set", { unres_direction: "1" });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: 2 & s ? "check-square-o" : "square-o",
                          content: "South",
                          selected: 2 & s,
                          onClick: function () {
                            return l("direc_set", { unres_direction: "2" });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: 4 & s ? "check-square-o" : "square-o",
                          content: "East",
                          selected: 4 & s,
                          onClick: function () {
                            return l("direc_set", { unres_direction: "4" });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: 8 & s ? "check-square-o" : "square-o",
                          content: "West",
                          selected: 8 & s,
                          onClick: function () {
                            return l("direc_set", { unres_direction: "8" });
                          },
                        }),
                      ],
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, i.AccessList, {
                accesses: m,
                selectedList: p,
                accessMod: function (e) {
                  return l("set", { access: e });
                },
                grantAll: function () {
                  return l("grant_all");
                },
                denyAll: function () {
                  return l("clear_all");
                },
                grantDep: function (e) {
                  return l("grant_region", { region: e });
                },
                denyDep: function (e) {
                  return l("deny_region", { region: e });
                },
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Apc = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = n(59);
      t.Apc = function (e, t) {
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 450,
          height: 460,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, u),
          }),
        });
      };
      var l = {
          2: {
            color: "good",
            externalPowerText: "External Power",
            chargingText: "Fully Charged",
          },
          1: {
            color: "average",
            externalPowerText: "Low External Power",
            chargingText: "Charging",
          },
          0: {
            color: "bad",
            externalPowerText: "No External Power",
            chargingText: "Not Charging",
          },
        },
        d = {
          1: {
            icon: "terminal",
            content: "Override Programming",
            action: "hack",
          },
          2: {
            icon: "caret-square-down",
            content: "Shunt Core Process",
            action: "occupy",
          },
          3: {
            icon: "caret-square-left",
            content: "Return to Main Core",
            action: "deoccupy",
          },
          4: {
            icon: "caret-square-down",
            content: "Shunt Core Process",
            action: "occupy",
          },
        },
        u = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            u = n.data,
            s = u.locked && !u.siliconUser,
            m = l[u.externalPower] || l[0],
            p = l[u.chargingStatus] || l[0],
            C = u.powerChannels || [],
            h = d[u.malfStatus] || d[0],
            N = u.powerCellStatus / 100;
          return u.failTime > 0
            ? (0, o.createComponentVNode)(2, a.NoticeBox, {
                children: [
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    (0, o.createVNode)(1, "h3", null, "SYSTEM FAILURE", 16),
                    2
                  ),
                  (0, o.createVNode)(
                    1,
                    "i",
                    null,
                    "I/O regulators malfunction detected! Waiting for system reboot...",
                    16
                  ),
                  (0, o.createVNode)(1, "br"),
                  "Automatic reboot in ",
                  u.failTime,
                  " seconds...",
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: "sync",
                    content: "Reboot Now",
                    onClick: function () {
                      return c("reboot");
                    },
                  }),
                ],
              })
            : (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, i.InterfaceLockNoticeBox),
                  (0, o.createComponentVNode)(2, a.Section, {
                    title: "Power Status",
                    children: (0, o.createComponentVNode)(2, a.LabeledList, {
                      children: [
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Main Breaker",
                          color: m.color,
                          buttons: (0, o.createComponentVNode)(2, a.Button, {
                            icon: u.isOperating ? "power-off" : "times",
                            content: u.isOperating ? "On" : "Off",
                            selected: u.isOperating && !s,
                            disabled: s,
                            onClick: function () {
                              return c("breaker");
                            },
                          }),
                          children: ["[ ", m.externalPowerText, " ]"],
                        }),
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Power Cell",
                          children: (0, o.createComponentVNode)(
                            2,
                            a.ProgressBar,
                            { color: "good", value: N }
                          ),
                        }),
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Charge Mode",
                          color: p.color,
                          buttons: (0, o.createComponentVNode)(2, a.Button, {
                            icon: u.chargeMode ? "sync" : "close",
                            content: u.chargeMode ? "Auto" : "Off",
                            disabled: s,
                            onClick: function () {
                              return c("charge");
                            },
                          }),
                          children: ["[ ", p.chargingText, " ]"],
                        }),
                      ],
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.Section, {
                    title: "Power Channels",
                    children: (0, o.createComponentVNode)(2, a.LabeledList, {
                      children: [
                        C.map(function (e) {
                          var t = e.topicParams;
                          return (0, o.createComponentVNode)(
                            2,
                            a.LabeledList.Item,
                            {
                              label: e.title,
                              buttons: (0, o.createFragment)(
                                [
                                  (0, o.createComponentVNode)(2, a.Box, {
                                    inline: !0,
                                    mx: 2,
                                    color: e.status >= 2 ? "good" : "bad",
                                    children: e.status >= 2 ? "On" : "Off",
                                  }),
                                  (0, o.createComponentVNode)(2, a.Button, {
                                    icon: "sync",
                                    content: "Auto",
                                    selected:
                                      !s && (1 === e.status || 3 === e.status),
                                    disabled: s,
                                    onClick: function () {
                                      return c("channel", t.auto);
                                    },
                                  }),
                                  (0, o.createComponentVNode)(2, a.Button, {
                                    icon: "power-off",
                                    content: "On",
                                    selected: !s && 2 === e.status,
                                    disabled: s,
                                    onClick: function () {
                                      return c("channel", t.on);
                                    },
                                  }),
                                  (0, o.createComponentVNode)(2, a.Button, {
                                    icon: "times",
                                    content: "Off",
                                    selected: !s && 0 === e.status,
                                    disabled: s,
                                    onClick: function () {
                                      return c("channel", t.off);
                                    },
                                  }),
                                ],
                                4
                              ),
                              children: e.powerLoad,
                            },
                            e.title
                          );
                        }),
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Total Load",
                          children: (0, o.createVNode)(
                            1,
                            "b",
                            null,
                            u.totalLoad,
                            0
                          ),
                        }),
                      ],
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.Section, {
                    title: "Misc",
                    buttons:
                      !!u.siliconUser &&
                      (0, o.createFragment)(
                        [
                          !!u.malfStatus &&
                            (0, o.createComponentVNode)(2, a.Button, {
                              icon: h.icon,
                              content: h.content,
                              color: "bad",
                              onClick: function () {
                                return c(h.action);
                              },
                            }),
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "lightbulb-o",
                            content: "Overload",
                            onClick: function () {
                              return c("overload");
                            },
                          }),
                        ],
                        0
                      ),
                    children: [
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Cover Lock",
                        buttons: (0, o.createComponentVNode)(2, a.Button, {
                          icon: u.coverLocked ? "lock" : "unlock",
                          content: u.coverLocked ? "Engaged" : "Disengaged",
                          disabled: s,
                          onClick: function () {
                            return c("cover");
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Emergency Lighting",
                        buttons: (0, o.createComponentVNode)(2, a.Button, {
                          icon: "lightbulb-o",
                          content: u.emergencyLights ? "Enabled" : "Disabled",
                          disabled: s,
                          onClick: function () {
                            return c("emergency_lighting");
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Night Shift Lighting",
                        buttons: (0, o.createComponentVNode)(2, a.Button, {
                          icon: "lightbulb-o",
                          content: u.nightshiftLights ? "Enabled" : "Disabled",
                          disabled: s,
                          onClick: function () {
                            return c("toggle_nightshift");
                          },
                        }),
                      }),
                    ],
                  }),
                ],
                4
              );
        };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.AtmosAlertConsole = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.AtmosAlertConsole = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.priority || [],
          u = l.minor || [];
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 350,
          height: 300,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.Section, {
              title: "Alarms",
              children: (0, o.createVNode)(
                1,
                "ul",
                null,
                [
                  0 === d.length &&
                    (0, o.createVNode)(
                      1,
                      "li",
                      "color-good",
                      "No Priority Alerts",
                      16
                    ),
                  d.map(function (e) {
                    return (0, o.createVNode)(
                      1,
                      "li",
                      null,
                      (0, o.createComponentVNode)(2, a.Button, {
                        icon: "times",
                        content: e,
                        color: "bad",
                        onClick: function () {
                          return i("clear", { zone: e });
                        },
                      }),
                      2,
                      null,
                      e
                    );
                  }),
                  u.length > 0 &&
                    (0, o.createVNode)(
                      1,
                      "li",
                      "color-good",
                      "No Minor Alerts",
                      16
                    ),
                  u.map(function (e) {
                    return (0, o.createVNode)(
                      1,
                      "li",
                      null,
                      (0, o.createComponentVNode)(2, a.Button, {
                        icon: "times",
                        content: e,
                        color: "average",
                        onClick: function () {
                          return i("clear", { zone: e });
                        },
                      }),
                      2,
                      null,
                      e
                    );
                  }),
                ],
                0
              ),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.AtmosControlConsole = void 0);
      var o = n(0),
        r = n(21),
        a = n(8),
        c = n(2),
        i = n(1),
        l = n(3);
      t.AtmosControlConsole = function (e, t) {
        var n,
          d = (0, c.useBackend)(t),
          u = d.act,
          s = d.data,
          m = s.sensors || [];
        return (0, o.createComponentVNode)(2, l.Window, {
          resizable: !0,
          width: 400,
          height: 925,
          children: (0, o.createComponentVNode)(2, l.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, i.Section, {
                title: !!s.tank && (null == (n = m[0]) ? void 0 : n.long_name),
                children: m.map(function (e) {
                  var t = e.gases || {};
                  return (0, o.createComponentVNode)(
                    2,
                    i.Section,
                    {
                      title: !s.tank && e.long_name,
                      level: 2,
                      children: (0, o.createComponentVNode)(2, i.LabeledList, {
                        children: [
                          (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                            label: "Pressure",
                            children: (0, a.toFixed)(e.pressure, 2) + " kPa",
                          }),
                          !!e.temperature &&
                            (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                              label: "Temperature",
                              children: (0, a.toFixed)(e.temperature, 2) + " K",
                            }),
                          (0, r.map)(function (e, t) {
                            return (0,
                            o.createComponentVNode)(2, i.LabeledList.Item, { label: t, children: (0, a.toFixed)(e, 2) + "%" });
                          })(t),
                        ],
                      }),
                    },
                    e.id_tag
                  );
                }),
              }),
              s.tank &&
                (0, o.createComponentVNode)(2, i.Section, {
                  title: "Controls",
                  buttons: (0, o.createComponentVNode)(2, i.Button, {
                    icon: "undo",
                    content: "Reconnect",
                    onClick: function () {
                      return u("reconnect");
                    },
                  }),
                  children: (0, o.createComponentVNode)(2, i.LabeledList, {
                    children: [
                      (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                        label: "Input Injector",
                        children: (0, o.createComponentVNode)(2, i.Button, {
                          icon: s.inputting ? "power-off" : "times",
                          content: s.inputting ? "Injecting" : "Off",
                          selected: s.inputting,
                          onClick: function () {
                            return u("input");
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                        label: "Input Rate",
                        children: (0, o.createComponentVNode)(
                          2,
                          i.NumberInput,
                          {
                            value: s.inputRate,
                            unit: "L/s",
                            width: "63px",
                            minValue: 0,
                            maxValue: 200,
                            suppressFlicker: 2e3,
                            onChange: function (e, t) {
                              return u("rate", { rate: t });
                            },
                          }
                        ),
                      }),
                      (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                        label: "Output Regulator",
                        children: (0, o.createComponentVNode)(2, i.Button, {
                          icon: s.outputting ? "power-off" : "times",
                          content: s.outputting ? "Open" : "Closed",
                          selected: s.outputting,
                          onClick: function () {
                            return u("output");
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                        label: "Output Pressure",
                        children: (0, o.createComponentVNode)(
                          2,
                          i.NumberInput,
                          {
                            value: parseFloat(s.outputPressure),
                            unit: "kPa",
                            width: "75px",
                            minValue: 0,
                            maxValue: 4500,
                            step: 10,
                            suppressFlicker: 2e3,
                            onChange: function (e, t) {
                              return u("pressure", { pressure: t });
                            },
                          }
                        ),
                      }),
                    ],
                  }),
                }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.AtmosFilter = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(44),
        i = n(3);
      t.AtmosFilter = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.filter_types || [];
        return (0, o.createComponentVNode)(2, i.Window, {
          width: 390,
          height: 187,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Power",
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      icon: d.on ? "power-off" : "times",
                      content: d.on ? "On" : "Off",
                      selected: d.on,
                      onClick: function () {
                        return l("power");
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Transfer Rate",
                    children: [
                      (0, o.createComponentVNode)(2, a.NumberInput, {
                        animated: !0,
                        value: parseFloat(d.rate),
                        width: "63px",
                        unit: "L/s",
                        minValue: 0,
                        maxValue: 200,
                        onDrag: function (e, t) {
                          return l("rate", { rate: t });
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        ml: 1,
                        icon: "plus",
                        content: "Max",
                        disabled: d.rate === d.max_rate,
                        onClick: function () {
                          return l("rate", { rate: "max" });
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Filter",
                    children: u.map(function (e) {
                      return (0, o.createComponentVNode)(
                        2,
                        a.Button,
                        {
                          selected: e.selected,
                          content: (0, c.getGasLabel)(e.id, e.name),
                          onClick: function () {
                            return l("filter", { mode: e.id });
                          },
                        },
                        e.id
                      );
                    }),
                  }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.AtmosMixer = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.AtmosMixer = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 370,
          height: 165,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Power",
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      icon: l.on ? "power-off" : "times",
                      content: l.on ? "On" : "Off",
                      selected: l.on,
                      onClick: function () {
                        return i("power");
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Output Pressure",
                    children: [
                      (0, o.createComponentVNode)(2, a.NumberInput, {
                        animated: !0,
                        value: parseFloat(l.set_pressure),
                        unit: "kPa",
                        width: "75px",
                        minValue: 0,
                        maxValue: 4500,
                        step: 10,
                        onChange: function (e, t) {
                          return i("pressure", { pressure: t });
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        ml: 1,
                        icon: "plus",
                        content: "Max",
                        disabled: l.set_pressure === l.max_pressure,
                        onClick: function () {
                          return i("pressure", { pressure: "max" });
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Node 1",
                    children: (0, o.createComponentVNode)(2, a.NumberInput, {
                      animated: !0,
                      value: l.node1_concentration,
                      unit: "%",
                      width: "60px",
                      minValue: 0,
                      maxValue: 100,
                      stepPixelSize: 2,
                      onDrag: function (e, t) {
                        return i("node1", { concentration: t });
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Node 2",
                    children: (0, o.createComponentVNode)(2, a.NumberInput, {
                      animated: !0,
                      value: l.node2_concentration,
                      unit: "%",
                      width: "60px",
                      minValue: 0,
                      maxValue: 100,
                      stepPixelSize: 2,
                      onDrag: function (e, t) {
                        return i("node2", { concentration: t });
                      },
                    }),
                  }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.AtmosPump = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.AtmosPump = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 335,
          height: 115,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Power",
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      icon: l.on ? "power-off" : "times",
                      content: l.on ? "On" : "Off",
                      selected: l.on,
                      onClick: function () {
                        return i("power");
                      },
                    }),
                  }),
                  l.max_rate
                    ? (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Transfer Rate",
                        children: [
                          (0, o.createComponentVNode)(2, a.NumberInput, {
                            animated: !0,
                            value: parseFloat(l.rate),
                            width: "63px",
                            unit: "L/s",
                            minValue: 0,
                            maxValue: 200,
                            onChange: function (e, t) {
                              return i("rate", { rate: t });
                            },
                          }),
                          (0, o.createComponentVNode)(2, a.Button, {
                            ml: 1,
                            icon: "plus",
                            content: "Max",
                            disabled: l.rate === l.max_rate,
                            onClick: function () {
                              return i("rate", { rate: "max" });
                            },
                          }),
                        ],
                      })
                    : (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Output Pressure",
                        children: [
                          (0, o.createComponentVNode)(2, a.NumberInput, {
                            animated: !0,
                            value: parseFloat(l.pressure),
                            unit: "kPa",
                            width: "75px",
                            minValue: 0,
                            maxValue: 4500,
                            step: 10,
                            onChange: function (e, t) {
                              return i("pressure", { pressure: t });
                            },
                          }),
                          (0, o.createComponentVNode)(2, a.Button, {
                            ml: 1,
                            icon: "plus",
                            content: "Max",
                            disabled: l.pressure === l.max_pressure,
                            onClick: function () {
                              return i("pressure", { pressure: "max" });
                            },
                          }),
                        ],
                      }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.AutomatedAnnouncement = void 0);
      var o = n(0),
        r = (n(19), n(2)),
        a = n(1),
        c = n(3),
        i = "%PERSON will be replaced with their name.\n%RANK with their job.";
      t.AutomatedAnnouncement = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.arrivalToggle,
          s = d.arrival,
          m = d.newheadToggle,
          p = d.newhead;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 500,
          height: 225,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Arrival Announcement",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: u ? "power-off" : "times",
                  selected: u,
                  content: u ? "On" : "Off",
                  onClick: function () {
                    return l("ArrivalToggle");
                  },
                }),
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Message",
                    buttons: (0, o.createComponentVNode)(2, a.Button, {
                      icon: "info",
                      tooltip: i,
                      tooltipPosition: "left",
                    }),
                    children: (0, o.createComponentVNode)(2, a.Input, {
                      fluid: !0,
                      value: s,
                      onChange: function (e, t) {
                        return l("ArrivalText", { newText: t });
                      },
                    }),
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Departmental Head Announcement",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: m ? "power-off" : "times",
                  selected: m,
                  content: m ? "On" : "Off",
                  onClick: function () {
                    return l("NewheadToggle");
                  },
                }),
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Message",
                    buttons: (0, o.createComponentVNode)(2, a.Button, {
                      icon: "info",
                      tooltip: i,
                      tooltipPosition: "left",
                    }),
                    children: (0, o.createComponentVNode)(2, a.Input, {
                      fluid: !0,
                      value: p,
                      onChange: function (e, t) {
                        return l("NewheadText", { newText: t });
                      },
                    }),
                  }),
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.BankMachine = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.BankMachine = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.current_balance,
          u = l.siphoning,
          s = l.station_name;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 335,
          height: 160,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: s + " Vault",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Current Balance",
                    buttons: (0, o.createComponentVNode)(2, a.Button, {
                      icon: u ? "times" : "sync",
                      content: u ? "Stop Siphoning" : "Siphon Credits",
                      selected: u,
                      onClick: function () {
                        return i(u ? "halt" : "siphon");
                      },
                    }),
                    children: d + " cr",
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.NoticeBox, {
                textAlign: "center",
                children: "Authorized personnel only",
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.BiogeneratorContent = t.Biogenerator = void 0);
      var o = n(0),
        r = n(6),
        a = n(19),
        c = n(2),
        i = n(1),
        l = n(52),
        d = n(3);
      t.Biogenerator = function (e, t) {
        var n = (0, c.useBackend)(t).data,
          r = n.beaker,
          a = n.processing;
        return (0, o.createComponentVNode)(2, d.Window, {
          resizable: !0,
          width: 550,
          height: 380,
          children: [
            !!a &&
              (0, o.createComponentVNode)(2, i.Dimmer, {
                fontSize: "32px",
                children: [
                  (0, o.createComponentVNode)(2, i.Icon, {
                    name: "cog",
                    spin: 1,
                  }),
                  " Processing...",
                ],
              }),
            (0, o.createComponentVNode)(2, d.Window.Content, {
              scrollable: !0,
              children: [
                !r &&
                  (0, o.createComponentVNode)(2, i.NoticeBox, {
                    children: "No Container",
                  }),
                !!r && (0, o.createComponentVNode)(2, u),
              ],
            }),
          ],
        });
      };
      var u = function (e, t) {
        var n,
          r,
          d = (0, c.useBackend)(t),
          u = d.act,
          m = d.data,
          p = m.biomass,
          C = m.can_process,
          h = m.categories,
          N = void 0 === h ? [] : h,
          V = (0, c.useLocalState)(t, "searchText", ""),
          b = V[0],
          f = V[1],
          g = (0, c.useLocalState)(
            t,
            "category",
            null == (n = N[0]) ? void 0 : n.name
          ),
          v = g[0],
          k = g[1],
          w = (0, a.createSearch)(b, function (e) {
            return e.name;
          }),
          B =
            (b.length > 0 &&
              N.flatMap(function (e) {
                return e.items || [];
              })
                .filter(w)
                .filter(function (e, t) {
                  return t < 25;
                })) ||
            (null ==
            (r = N.find(function (e) {
              return e.name === v;
            }))
              ? void 0
              : r.items) ||
            [];
        return (0, o.createComponentVNode)(2, i.Section, {
          title: (0, o.createComponentVNode)(2, i.Box, {
            inline: !0,
            color: p > 0 ? "good" : "bad",
            children: [(0, l.formatMoney)(p), " Biomass"],
          }),
          buttons: (0, o.createFragment)(
            [
              (0, o.createTextVNode)("Search"),
              (0, o.createComponentVNode)(2, i.Input, {
                value: b,
                onInput: function (e, t) {
                  return f(t);
                },
                mx: 1,
              }),
              (0, o.createComponentVNode)(2, i.Button, {
                icon: "eject",
                content: "Eject",
                onClick: function () {
                  return u("detach");
                },
              }),
              (0, o.createComponentVNode)(2, i.Button, {
                icon: "cog",
                content: "Activate",
                disabled: !C,
                onClick: function () {
                  return u("activate");
                },
              }),
            ],
            4
          ),
          children: (0, o.createComponentVNode)(2, i.Flex, {
            children: [
              0 === b.length &&
                (0, o.createComponentVNode)(2, i.Flex.Item, {
                  children: (0, o.createComponentVNode)(2, i.Tabs, {
                    vertical: !0,
                    children: N.map(function (e) {
                      var t;
                      return (0, o.createComponentVNode)(
                        2,
                        i.Tabs.Tab,
                        {
                          selected: e.name === v,
                          onClick: function () {
                            return k(e.name);
                          },
                          children: [
                            e.name,
                            " (",
                            (null == (t = e.items) ? void 0 : t.length) || 0,
                            ")",
                          ],
                        },
                        e.name
                      );
                    }),
                  }),
                }),
              (0, o.createComponentVNode)(2, i.Flex.Item, {
                grow: 1,
                basis: 0,
                children: [
                  0 === B.length &&
                    (0, o.createComponentVNode)(2, i.NoticeBox, {
                      children:
                        0 === b.length
                          ? "No items in this category."
                          : "No results found.",
                    }),
                  (0, o.createComponentVNode)(2, i.Table, {
                    children: (0, o.createComponentVNode)(2, s, {
                      biomass: p,
                      items: B,
                    }),
                  }),
                ],
              }),
            ],
          }),
        });
      };
      t.BiogeneratorContent = u;
      var s = function (e, t) {
        var n = (0, c.useBackend)(t).act,
          a = (0, c.useLocalState)(t, "hoveredItem", {}),
          l = a[0],
          d = a[1],
          u = (l && l.cost) || 0;
        return e.items
          .map(function (n) {
            var o = (0, c.useLocalState)(t, "amount" + n.name, 1),
              r = o[0],
              a = o[1],
              i = l && l.name !== n.name,
              d = e.biomass - u * l.amount < n.cost * r,
              s = i && d,
              m = e.biomass < n.cost * r || s;
            return Object.assign({}, n, {
              disabled: m,
              amount: r,
              setAmount: a,
            });
          })
          .map(function (e) {
            return (0, o.createComponentVNode)(
              2,
              i.Table.Row,
              {
                children: [
                  (0, o.createComponentVNode)(2, i.Table.Cell, {
                    children: [
                      (0, o.createVNode)(
                        1,
                        "span",
                        (0, r.classes)(["design32x32", e.id]),
                        null,
                        1,
                        { style: { "vertical-align": "middle" } }
                      ),
                      " ",
                      (0, o.createVNode)(1, "b", null, e.name, 0),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, i.Table.Cell, {
                    collapsing: !0,
                    children: (0, o.createComponentVNode)(2, i.NumberInput, {
                      value: Math.round(e.amount),
                      width: "35px",
                      minValue: 1,
                      maxValue: 10,
                      onChange: function (t, n) {
                        return e.setAmount(n);
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, i.Table.Cell, {
                    collapsing: !0,
                    children: (0, o.createComponentVNode)(2, i.Button, {
                      style: { "text-align": "right" },
                      fluid: !0,
                      content: e.cost * e.amount + " BIO",
                      disabled: e.disabled,
                      onmouseover: function () {
                        return d(e);
                      },
                      onmouseout: function () {
                        return d({});
                      },
                      onClick: function () {
                        return n("create", { id: e.id, amount: e.amount });
                      },
                    }),
                  }),
                ],
              },
              e.id
            );
          });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.BluespaceArtillery = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.BluespaceArtillery = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.notice,
          u = l.connected,
          s = l.unlocked,
          m = l.target;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 400,
          height: 220,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              !!d &&
                (0, o.createComponentVNode)(2, a.NoticeBox, { children: d }),
              u
                ? (0, o.createFragment)(
                    [
                      (0, o.createComponentVNode)(2, a.Section, {
                        title: "Target",
                        buttons: (0, o.createComponentVNode)(2, a.Button, {
                          icon: "crosshairs",
                          disabled: !s,
                          onClick: function () {
                            return i("recalibrate");
                          },
                        }),
                        children: (0, o.createComponentVNode)(2, a.Box, {
                          color: m ? "average" : "bad",
                          fontSize: "25px",
                          children: m || "No Target Set",
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Section, {
                        children: s
                          ? (0, o.createComponentVNode)(2, a.Box, {
                              style: { margin: "auto" },
                              children: (0, o.createComponentVNode)(
                                2,
                                a.Button,
                                {
                                  fluid: !0,
                                  content: "FIRE",
                                  color: "bad",
                                  disabled: !m,
                                  fontSize: "30px",
                                  textAlign: "center",
                                  lineHeight: "46px",
                                  onClick: function () {
                                    return i("fire");
                                  },
                                }
                              ),
                            })
                          : (0, o.createFragment)(
                              [
                                (0, o.createComponentVNode)(2, a.Box, {
                                  color: "bad",
                                  fontSize: "18px",
                                  children:
                                    "Bluespace artillery is currently locked.",
                                }),
                                (0, o.createComponentVNode)(2, a.Box, {
                                  mt: 1,
                                  children:
                                    "Awaiting authorization via keycard reader from at minimum two station heads.",
                                }),
                              ],
                              4
                            ),
                      }),
                    ],
                    4
                  )
                : (0, o.createComponentVNode)(2, a.Section, {
                    children: (0, o.createComponentVNode)(2, a.LabeledList, {
                      children: (0, o.createComponentVNode)(
                        2,
                        a.LabeledList.Item,
                        {
                          label: "Maintenance",
                          children: (0, o.createComponentVNode)(2, a.Button, {
                            icon: "wrench",
                            content: "Complete Deployment",
                            onClick: function () {
                              return i("build");
                            },
                          }),
                        }
                      ),
                    }),
                  }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.BorgPanel = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.BorgPanel = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.borg || {},
          u = l.cell || {},
          s = u.charge / u.maxcharge,
          m = l.channels || [],
          p = l.modules || [],
          C = l.upgrades || [],
          h = l.ais || [],
          N = l.laws || [];
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 700,
          height: 700,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: d.name,
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: "pencil-alt",
                  content: "Rename",
                  onClick: function () {
                    return i("rename");
                  },
                }),
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Status",
                      children: [
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: d.emagged ? "check-square-o" : "square-o",
                          content: "Emagged",
                          selected: d.emagged,
                          onClick: function () {
                            return i("toggle_emagged");
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: d.lockdown ? "check-square-o" : "square-o",
                          content: "Locked Down",
                          selected: d.lockdown,
                          onClick: function () {
                            return i("toggle_lockdown");
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: d.scrambledcodes
                            ? "check-square-o"
                            : "square-o",
                          content: "Scrambled Codes",
                          selected: d.scrambledcodes,
                          onClick: function () {
                            return i("toggle_scrambledcodes");
                          },
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Charge",
                      children: [
                        u.missing
                          ? (0, o.createVNode)(
                              1,
                              "span",
                              "color-bad",
                              "No cell installed",
                              16
                            )
                          : (0, o.createComponentVNode)(2, a.ProgressBar, {
                              value: s,
                              children: u.charge + " / " + u.maxcharge,
                            }),
                        (0, o.createVNode)(1, "br"),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "pencil-alt",
                          content: "Set",
                          onClick: function () {
                            return i("set_charge");
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "eject",
                          content: "Change",
                          onClick: function () {
                            return i("change_cell");
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "trash",
                          content: "Remove",
                          color: "bad",
                          onClick: function () {
                            return i("remove_cell");
                          },
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Radio Channels",
                      children: m.map(function (e) {
                        return (0, o.createComponentVNode)(
                          2,
                          a.Button,
                          {
                            icon: e.installed ? "check-square-o" : "square-o",
                            content: e.name,
                            selected: e.installed,
                            onClick: function () {
                              return i("toggle_radio", { channel: e.name });
                            },
                          },
                          e.name
                        );
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Module",
                      children: p.map(function (e) {
                        return (0, o.createComponentVNode)(
                          2,
                          a.Button,
                          {
                            icon:
                              d.active_module === e.type
                                ? "check-square-o"
                                : "square-o",
                            content: e.name,
                            selected: d.active_module === e.type,
                            onClick: function () {
                              return i("setmodule", { module: e.type });
                            },
                          },
                          e.type
                        );
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Upgrades",
                      children: C.map(function (e) {
                        return (0, o.createComponentVNode)(
                          2,
                          a.Button,
                          {
                            icon: e.installed ? "check-square-o" : "square-o",
                            content: e.name,
                            selected: e.installed,
                            onClick: function () {
                              return i("toggle_upgrade", { upgrade: e.type });
                            },
                          },
                          e.type
                        );
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Master AI",
                      children: h.map(function (e) {
                        return (0, o.createComponentVNode)(
                          2,
                          a.Button,
                          {
                            icon: e.connected ? "check-square-o" : "square-o",
                            content: e.name,
                            selected: e.connected,
                            onClick: function () {
                              return i("slavetoai", { slavetoai: e.ref });
                            },
                          },
                          e.ref
                        );
                      }),
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Laws",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: d.lawupdate ? "check-square-o" : "square-o",
                  content: "Lawsync",
                  selected: d.lawupdate,
                  onClick: function () {
                    return i("toggle_lawupdate");
                  },
                }),
                children: N.map(function (e) {
                  return (0,
                  o.createComponentVNode)(2, a.Box, { children: e }, e);
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.BottleDispenser = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.BottleDispenser = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.bottle_size,
          u = l.bottle_name;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 300,
          height: 120,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Bottle Volume",
                    children: (0, o.createComponentVNode)(2, a.NumberInput, {
                      value: d,
                      unit: "u",
                      width: "43px",
                      minValue: 5,
                      maxValue: 30,
                      step: 1,
                      stepPixelSize: 2,
                      onChange: function (e, t) {
                        return i("change_bottle_size", { volume: t });
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Bottle Name",
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      icon: "pencil-alt",
                      content: u,
                      onClick: function () {
                        return i("change_bottle_name");
                      },
                    }),
                  }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.BrigTimer = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.BrigTimer = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 300,
          height: 138,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.Section, {
              title: "Cell Timer",
              buttons: (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: "clock-o",
                    content: l.timing ? "Stop" : "Start",
                    selected: l.timing,
                    onClick: function () {
                      return i(l.timing ? "stop" : "start");
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: "lightbulb-o",
                    content: l.flash_charging ? "Recharging" : "Flash",
                    disabled: l.flash_charging,
                    onClick: function () {
                      return i("flash");
                    },
                  }),
                ],
                4
              ),
              children: [
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "fast-backward",
                  onClick: function () {
                    return i("time", { adjust: -600 });
                  },
                }),
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "backward",
                  onClick: function () {
                    return i("time", { adjust: -100 });
                  },
                }),
                " ",
                String(l.minutes).padStart(2, "0"),
                ":",
                String(l.seconds).padStart(2, "0"),
                " ",
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "forward",
                  onClick: function () {
                    return i("time", { adjust: 100 });
                  },
                }),
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "fast-forward",
                  onClick: function () {
                    return i("time", { adjust: 600 });
                  },
                }),
                (0, o.createVNode)(1, "br"),
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "hourglass-start",
                  content: "Short",
                  onClick: function () {
                    return i("preset", { preset: "short" });
                  },
                }),
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "hourglass-start",
                  content: "Medium",
                  onClick: function () {
                    return i("preset", { preset: "medium" });
                  },
                }),
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "hourglass-start",
                  content: "Long",
                  onClick: function () {
                    return i("preset", { preset: "long" });
                  },
                }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.CameraConsoleContent = t.CameraConsole = void 0);
      var o = n(0),
        r = n(21),
        a = n(50),
        c = n(6),
        i = n(19),
        l = n(2),
        d = n(1),
        u = n(3),
        s = function (e, t) {
          void 0 === t && (t = "");
          var n = (0, i.createSearch)(t, function (e) {
            return e.name;
          });
          return (0, a.flow)([
            (0, r.filter)(function (e) {
              return null == e ? void 0 : e.name;
            }),
            t && (0, r.filter)(n),
            (0, r.sortBy)(function (e) {
              return e.name;
            }),
          ])(e);
        };
      t.CameraConsole = function (e, t) {
        var n = (0, l.useBackend)(t),
          r = n.act,
          a = n.data,
          c = (n.config, a.mapRef),
          i = a.activeCamera,
          p = (function (e, t) {
            var n, o;
            if (!t) return [];
            var r = e.findIndex(function (e) {
              return e.name === t.name;
            });
            return [
              null == (n = e[r - 1]) ? void 0 : n.name,
              null == (o = e[r + 1]) ? void 0 : o.name,
            ];
          })(s(a.cameras), i),
          C = p[0],
          h = p[1];
        return (0, o.createComponentVNode)(2, u.Window, {
          resizable: !0,
          width: 870,
          height: 708,
          children: [
            (0, o.createVNode)(
              1,
              "div",
              "CameraConsole__left",
              (0, o.createComponentVNode)(2, u.Window.Content, {
                scrollable: !0,
                children: (0, o.createComponentVNode)(2, m),
              }),
              2
            ),
            (0, o.createVNode)(
              1,
              "div",
              "CameraConsole__right",
              [
                (0, o.createVNode)(
                  1,
                  "div",
                  "CameraConsole__toolbar",
                  [
                    (0, o.createVNode)(1, "b", null, "Camera: ", 16),
                    (i && i.name) || "\u2014",
                  ],
                  0
                ),
                (0, o.createVNode)(
                  1,
                  "div",
                  "CameraConsole__toolbarRight",
                  [
                    (0, o.createComponentVNode)(2, d.Button, {
                      icon: "chevron-left",
                      disabled: !C,
                      onClick: function () {
                        return r("switch_camera", { name: C });
                      },
                    }),
                    (0, o.createComponentVNode)(2, d.Button, {
                      icon: "chevron-right",
                      disabled: !h,
                      onClick: function () {
                        return r("switch_camera", { name: h });
                      },
                    }),
                  ],
                  4
                ),
                (0, o.createComponentVNode)(2, d.ByondUi, {
                  className: "CameraConsole__map",
                  params: { id: c, type: "map" },
                }),
              ],
              4
            ),
          ],
        });
      };
      var m = function (e, t) {
        var n = (0, l.useBackend)(t),
          r = n.act,
          a = n.data,
          i = (0, l.useLocalState)(t, "searchText", ""),
          u = i[0],
          m = i[1],
          p = a.activeCamera,
          C = s(a.cameras, u);
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, d.Input, {
              fluid: !0,
              mb: 1,
              placeholder: "Search for a camera",
              onInput: function (e, t) {
                return m(t);
              },
            }),
            (0, o.createComponentVNode)(2, d.Section, {
              children: C.map(function (e) {
                return (0, o.createVNode)(
                  1,
                  "div",
                  (0, c.classes)([
                    "Button",
                    "Button--fluid",
                    "Button--color--transparent",
                    "Button--ellipsis",
                    p && e.name === p.name && "Button--selected",
                  ]),
                  e.name,
                  0,
                  {
                    title: e.name,
                    onClick: function () {
                      return r("switch_camera", { name: e.name });
                    },
                  },
                  e.name
                );
              }),
            }),
          ],
          4
        );
      };
      t.CameraConsoleContent = m;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Canister = void 0);
      var o = n(0),
        r = n(8),
        a = n(2),
        c = n(1),
        i = n(52),
        l = n(3);
      t.Canister = function (e, t) {
        var n = (0, a.useBackend)(t),
          d = n.act,
          u = n.data,
          s = u.portConnected,
          m = u.tankPressure,
          p = u.releasePressure,
          C = u.defaultReleasePressure,
          h = u.minReleasePressure,
          N = u.maxReleasePressure,
          V = u.valveOpen,
          b = u.isPrototype,
          f = u.hasHoldingTank,
          g = u.holdingTank,
          v = u.restricted;
        return (0, o.createComponentVNode)(2, l.Window, {
          width: 300,
          height: 232,
          children: (0, o.createComponentVNode)(2, l.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Canister",
                buttons: (0, o.createFragment)(
                  [
                    !!b &&
                      (0, o.createComponentVNode)(2, c.Button, {
                        mr: 1,
                        icon: v ? "lock" : "unlock",
                        color: "caution",
                        content: v ? "Engineering" : "Public",
                        onClick: function () {
                          return d("restricted");
                        },
                      }),
                    (0, o.createComponentVNode)(2, c.Button, {
                      icon: "pencil-alt",
                      content: "Relabel",
                      onClick: function () {
                        return d("relabel");
                      },
                    }),
                  ],
                  0
                ),
                children: (0, o.createComponentVNode)(2, c.LabeledControls, {
                  children: [
                    (0, o.createComponentVNode)(2, c.LabeledControls.Item, {
                      minWidth: "66px",
                      label: "Pressure",
                      children: (0, o.createComponentVNode)(
                        2,
                        c.AnimatedNumber,
                        {
                          value: m,
                          format: function (e) {
                            return e < 1e4
                              ? (0, r.toFixed)(e) + " kPa"
                              : (0, i.formatSiUnit)(1e3 * e, 1, "Pa");
                          },
                        }
                      ),
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledControls.Item, {
                      label: "Regulator",
                      children: (0, o.createComponentVNode)(2, c.Box, {
                        position: "relative",
                        left: "-8px",
                        children: [
                          (0, o.createComponentVNode)(2, c.Knob, {
                            size: 1.25,
                            color: !!V && "yellow",
                            value: p,
                            unit: "kPa",
                            minValue: h,
                            maxValue: N,
                            step: 5,
                            stepPixelSize: 1,
                            onDrag: function (e, t) {
                              return d("pressure", { pressure: t });
                            },
                          }),
                          (0, o.createComponentVNode)(2, c.Button, {
                            fluid: !0,
                            position: "absolute",
                            top: "-2px",
                            right: "-20px",
                            color: "transparent",
                            icon: "fast-forward",
                            onClick: function () {
                              return d("pressure", { pressure: N });
                            },
                          }),
                          (0, o.createComponentVNode)(2, c.Button, {
                            fluid: !0,
                            position: "absolute",
                            top: "16px",
                            right: "-20px",
                            color: "transparent",
                            icon: "undo",
                            onClick: function () {
                              return d("pressure", { pressure: C });
                            },
                          }),
                        ],
                      }),
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledControls.Item, {
                      label: "Valve",
                      children: (0, o.createComponentVNode)(2, c.Button, {
                        my: 0.5,
                        width: "50px",
                        lineHeight: 2,
                        fontSize: "11px",
                        color: V ? (f ? "caution" : "danger") : null,
                        content: V ? "Open" : "Closed",
                        onClick: function () {
                          return d("valve");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledControls.Item, {
                      mr: 1,
                      label: "Port",
                      children: (0, o.createComponentVNode)(2, c.Box, {
                        position: "relative",
                        children: [
                          (0, o.createComponentVNode)(2, c.Icon, {
                            size: 1.25,
                            name: s ? "plug" : "times",
                            color: s ? "good" : "bad",
                          }),
                          (0, o.createComponentVNode)(2, c.Tooltip, {
                            content: s ? "Connected" : "Disconnected",
                            position: "top",
                          }),
                        ],
                      }),
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Holding Tank",
                buttons:
                  !!f &&
                  (0, o.createComponentVNode)(2, c.Button, {
                    icon: "eject",
                    color: V && "danger",
                    content: "Eject",
                    onClick: function () {
                      return d("eject");
                    },
                  }),
                children: [
                  !!f &&
                    (0, o.createComponentVNode)(2, c.LabeledList, {
                      children: [
                        (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                          label: "Label",
                          children: g.name,
                        }),
                        (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                          label: "Pressure",
                          children: [
                            (0, o.createComponentVNode)(2, c.AnimatedNumber, {
                              value: g.tankPressure,
                            }),
                            " kPa",
                          ],
                        }),
                      ],
                    }),
                  !f &&
                    (0, o.createComponentVNode)(2, c.Box, {
                      color: "average",
                      children: "No Holding Tank",
                    }),
                ],
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Canvas = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      var i = (function (e) {
        var t, n;
        function r(t) {
          var n;
          return (
            ((n = e.call(this, t) || this).canvasRef = (0, o.createRef)()),
            (n.onCVClick = t.onCanvasClick),
            n
          );
        }
        (n = e),
          ((t = r).prototype = Object.create(n.prototype)),
          (t.prototype.constructor = t),
          (t.__proto__ = n);
        var a = r.prototype;
        return (
          (a.componentDidMount = function () {
            this.drawCanvas(this.props);
          }),
          (a.componentDidUpdate = function () {
            this.drawCanvas(this.props);
          }),
          (a.drawCanvas = function (e) {
            var t = this.canvasRef.current.getContext("2d"),
              n = e.value,
              o = n.length;
            if (o) {
              var r = n[0].length,
                a = Math.round(this.canvasRef.current.width / o),
                c = Math.round(this.canvasRef.current.height / r);
              t.save(), t.scale(a, c);
              for (var i = 0; i < n.length; i++)
                for (var l = n[i], d = 0; d < l.length; d++) {
                  var u = l[d];
                  (t.fillStyle = u), t.fillRect(i, d, 1, 1);
                }
              t.restore();
            }
          }),
          (a.clickwrapper = function (e) {
            var t = this.props.value.length;
            if (t) {
              var n = this.props.value[0].length,
                o = this.canvasRef.current.width / t,
                r = this.canvasRef.current.height / n,
                a = Math.floor(e.offsetX / o) + 1,
                c = Math.floor(e.offsetY / r) + 1;
              this.onCVClick(a, c);
            }
          }),
          (a.render = function () {
            var e = this,
              t = this.props,
              n = (t.res, t.value),
              r = t.px_per_unit,
              a = void 0 === r ? 28 : r,
              c = (function (e, t) {
                if (null == e) return {};
                var n,
                  o,
                  r = {},
                  a = Object.keys(e);
                for (o = 0; o < a.length; o++)
                  (n = a[o]), t.indexOf(n) >= 0 || (r[n] = e[n]);
                return r;
              })(t, ["res", "value", "px_per_unit"]),
              i = n.length * a,
              l = 0 !== i ? n[0].length * a : 0;
            return (0, o.normalizeProps)(
              (0, o.createVNode)(
                1,
                "canvas",
                null,
                "Canvas failed to render.",
                16,
                Object.assign({ width: i || 300, height: l || 300 }, c, {
                  onClick: function (t) {
                    return e.clickwrapper(t);
                  },
                }),
                null,
                this.canvasRef
              )
            );
          }),
          r
        );
      })(o.Component);
      t.Canvas = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.Box, {
              textAlign: "center",
              children: [
                (0, o.createComponentVNode)(2, i, {
                  value: d.grid,
                  onCanvasClick: function (e, t) {
                    return l("paint", { x: e, y: t });
                  },
                }),
                (0, o.createComponentVNode)(2, a.Box, {
                  children: [
                    !d.finalized &&
                      (0, o.createComponentVNode)(2, a.Button.Confirm, {
                        onClick: function () {
                          return l("finalize");
                        },
                        content: "Finalize",
                      }),
                    d.name,
                  ],
                }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.CargoExpress = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = n(205),
        l = n(59);
      t.CargoExpress = function (e, t) {
        var n = (0, r.useBackend)(t),
          a = (n.act, n.data);
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 600,
          height: 700,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, l.InterfaceLockNoticeBox, {
                accessText: "a QM-level ID card",
              }),
              !a.locked && (0, o.createComponentVNode)(2, d),
            ],
          }),
        });
      };
      var d = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          l = n.data;
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, a.Section, {
              title: "Cargo Express",
              buttons: (0, o.createComponentVNode)(2, a.Box, {
                inline: !0,
                bold: !0,
                children: [
                  (0, o.createComponentVNode)(2, a.AnimatedNumber, {
                    value: Math.round(l.points),
                  }),
                  " credits",
                ],
              }),
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Landing Location",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Cargo Bay",
                        selected: !l.usingBeacon,
                        onClick: function () {
                          return c("LZCargo");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        selected: l.usingBeacon,
                        disabled: !l.hasBeacon,
                        onClick: function () {
                          return c("LZBeacon");
                        },
                        children: [l.beaconzone, " (", l.beaconName, ")"],
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: l.printMsg,
                        disabled: !l.canBuyBeacon,
                        onClick: function () {
                          return c("printBeacon");
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Notice",
                    children: l.message,
                  }),
                ],
              }),
            }),
            (0, o.createComponentVNode)(2, i.CargoCatalog, { express: !0 }),
          ],
          4
        );
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.CargoHoldTerminal = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.CargoHoldTerminal = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.points,
          u = l.pad,
          s = l.sending,
          m = l.status_report;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 600,
          height: 230,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Current Cargo Value",
                    children: (0, o.createComponentVNode)(2, a.Box, {
                      inline: !0,
                      bold: !0,
                      children: [
                        (0, o.createComponentVNode)(2, a.AnimatedNumber, {
                          value: Math.round(d),
                        }),
                        " credits",
                      ],
                    }),
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Cargo Pad",
                buttons: (0, o.createFragment)(
                  [
                    (0, o.createComponentVNode)(2, a.Button, {
                      icon: "sync",
                      content: "Recalculate Value",
                      disabled: !u,
                      onClick: function () {
                        return i("recalc");
                      },
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      icon: s ? "times" : "arrow-up",
                      content: s ? "Stop Sending" : "Send Goods",
                      selected: s,
                      disabled: !u,
                      onClick: function () {
                        return i(s ? "stop" : "send");
                      },
                    }),
                  ],
                  4
                ),
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Status",
                      color: u ? "good" : "bad",
                      children: u ? "Online" : "Not Found",
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Cargo Report",
                      children: m,
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.CellularEmporium = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.CellularEmporium = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.abilities;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 900,
          height: 480,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Genetic Points",
                    buttons: (0, o.createComponentVNode)(2, a.Button, {
                      icon: "undo",
                      content: "Readapt",
                      disabled: !l.can_readapt,
                      onClick: function () {
                        return i("readapt");
                      },
                    }),
                    children: l.genetic_points_remaining,
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: d.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      a.LabeledList.Item,
                      {
                        className: "candystripe",
                        label: e.name,
                        buttons: (0, o.createFragment)(
                          [
                            e.dna_cost,
                            " ",
                            (0, o.createComponentVNode)(2, a.Button, {
                              content: e.owned ? "Evolved" : "Evolve",
                              selected: e.owned,
                              onClick: function () {
                                return i("evolve", { name: e.name });
                              },
                            }),
                          ],
                          0
                        ),
                        children: [
                          e.desc,
                          (0, o.createComponentVNode)(2, a.Box, {
                            color: "good",
                            children: e.helptext,
                          }),
                        ],
                      },
                      e.name
                    );
                  }),
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.CentcomPodLauncherContent = t.CentcomPodLauncher = void 0);
      var o = n(0),
        r = (n(19), n(2)),
        a = n(1),
        c = n(3);
      t.CentcomPodLauncher = function () {
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 700,
          height: 700,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, i),
          }),
        });
      };
      var i = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data;
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, a.NoticeBox, {
              children:
                "To use this, simply spawn the atoms you want in one of the five Centcom Supplypod Bays. Items in the bay will then be launched inside your supplypod, one turf-full at a time! You can optionally use the following buttons to configure how the supplypod acts.",
            }),
            (0, o.createComponentVNode)(2, a.Section, {
              title:
                "Centcom Pod Customization (To be used against Helen Weinstein)",
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Supply Bay",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Bay #1",
                        selected: 1 === i.bayNumber,
                        onClick: function () {
                          return c("bay1");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Bay #2",
                        selected: 2 === i.bayNumber,
                        onClick: function () {
                          return c("bay2");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Bay #3",
                        selected: 3 === i.bayNumber,
                        onClick: function () {
                          return c("bay3");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Bay #4",
                        selected: 4 === i.bayNumber,
                        onClick: function () {
                          return c("bay4");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "ERT Bay",
                        selected: 5 === i.bayNumber,
                        tooltip:
                          "This bay is located on the western edge of CentCom. Its the\nglass room directly west of where ERT spawn, and south of the\nCentCom ferry. Useful for launching ERT/Deathsquads/etc. onto\nthe station via drop pods.",
                        onClick: function () {
                          return c("bay5");
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Teleport to",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: i.bay,
                        onClick: function () {
                          return c("teleportCentcom");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: i.oldArea ? i.oldArea : "Where you were",
                        disabled: !i.oldArea,
                        onClick: function () {
                          return c("teleportBack");
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Item Mode",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Clone Items",
                        selected: i.launchClone,
                        tooltip:
                          "Choosing this will create a duplicate of the item to be\nlaunched in Centcom, allowing you to send one type of item\nmultiple times. Either way, the atoms are forceMoved into\nthe supplypod after it lands (but before it opens).",
                        onClick: function () {
                          return c("launchClone");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Random Items",
                        selected: i.launchRandomItem,
                        tooltip:
                          "Choosing this will pick a random item from the selected turf\ninstead of the entire turfs contents. Best combined with\nsingle/random turf.",
                        onClick: function () {
                          return c("launchRandomItem");
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Launch style",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Ordered",
                        selected: 1 === i.launchChoice,
                        tooltip:
                          'Instead of launching everything in the bay at once, this\nwill "scan" things (one turf-full at a time) in order, left\nto right and top to bottom. undoing will reset the "scanner"\nto the top-leftmost position.',
                        onClick: function () {
                          return c("launchOrdered");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Random Turf",
                        selected: 2 === i.launchChoice,
                        tooltip:
                          "Instead of launching everything in the bay at once, this\nwill launch one random turf of items at a time.",
                        onClick: function () {
                          return c("launchRandomTurf");
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Explosion",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Custom Size",
                        selected: 1 === i.explosionChoice,
                        tooltip:
                          "This will cause an explosion of whatever size you like\n(including flame range) to occur as soon as the supplypod\nlands. Dont worry, supply-pods are explosion-proof!",
                        onClick: function () {
                          return c("explosionCustom");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Adminbus",
                        selected: 2 === i.explosionChoice,
                        tooltip:
                          "This will cause a maxcap explosion (dependent on server\nconfig) to occur as soon as the supplypod lands. Dont worry,\nsupply-pods are explosion-proof!",
                        onClick: function () {
                          return c("explosionBus");
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Damage",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Custom Damage",
                        selected: 1 === i.damageChoice,
                        tooltip:
                          "Anyone caught under the pod when it lands will be dealt\nthis amount of brute damage. Sucks to be them!",
                        onClick: function () {
                          return c("damageCustom");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Gib",
                        selected: 2 === i.damageChoice,
                        tooltip:
                          "This will attempt to gib any mob caught under the pod when\nit lands, as well as dealing a nice 5000 brute damage. Ya\nknow, just to be sure!",
                        onClick: function () {
                          return c("damageGib");
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Effects",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Stun",
                        selected: i.effectStun,
                        tooltip:
                          "Anyone who is on the turf when the supplypod is launched\nwill be stunned until the supplypod lands. They cant get\naway that easy!",
                        onClick: function () {
                          return c("effectStun");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Delimb",
                        selected: i.effectLimb,
                        tooltip:
                          "This will cause anyone caught under the pod to lose a limb,\nexcluding their head.",
                        onClick: function () {
                          return c("effectLimb");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Yeet Organs",
                        selected: i.effectOrgans,
                        tooltip:
                          "This will cause anyone caught under the pod to lose all\ntheir limbs and organs in a spectacular fashion.",
                        onClick: function () {
                          return c("effectOrgans");
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Movement",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Bluespace",
                        selected: i.effectBluespace,
                        tooltip:
                          "Gives the supplypod an advanced Bluespace Recyling Device.\nAfter opening, the supplypod will be warped directly to the\nsurface of a nearby NT-designated trash planet (/r/ss13).",
                        onClick: function () {
                          return c("effectBluespace");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Stealth",
                        selected: i.effectStealth,
                        tooltip:
                          'This hides the red target icon from appearing when you\nlaunch the supplypod. Combos well with the "Invisible"\nstyle. Sneak attack, go!',
                        onClick: function () {
                          return c("effectStealth");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Quiet",
                        selected: i.effectQuiet,
                        tooltip:
                          "This will keep the supplypod from making any sounds, except\nfor those specifically set by admins in the Sound section.",
                        onClick: function () {
                          return c("effectQuiet");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Reverse Mode",
                        selected: i.effectReverse,
                        tooltip:
                          "This pod will not send any items. Instead, after landing,\nthe supplypod will close (similar to a normal closet closing),\nand then launch back to the right centcom bay to drop off any\nnew contents.",
                        onClick: function () {
                          return c("effectReverse");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Missile Mode",
                        selected: i.effectMissile,
                        tooltip:
                          "This pod will not send any items. Instead, it will immediately\ndelete after landing (Similar visually to setting openDelay\n& departDelay to 0, but this looks nicer). Useful if you just\nwanna fuck some shit up. Combos well with the Missile style.",
                        onClick: function () {
                          return c("effectMissile");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Any Descent Angle",
                        selected: i.effectCircle,
                        tooltip:
                          "This will make the supplypod come in from any angle. Im not\nsure why this feature exists, but here it is.",
                        onClick: function () {
                          return c("effectCircle");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Machine Gun Mode",
                        selected: i.effectBurst,
                        tooltip:
                          "This will make each click launch 5 supplypods inaccuratly\naround the target turf (a 3x3 area). Combos well with the\nMissile Mode if you dont want shit lying everywhere after.",
                        onClick: function () {
                          return c("effectBurst");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Specific Target",
                        selected: i.effectTarget,
                        tooltip:
                          "This will make the supplypod target a specific atom, instead\nof the mouses position. Smiting does this automatically!",
                        onClick: function () {
                          return c("effectTarget");
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Name/Desc",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Custom Name/Desc",
                        selected: i.effectName,
                        tooltip:
                          "Allows you to add a custom name and description.",
                        onClick: function () {
                          return c("effectName");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Alert Ghosts",
                        selected: i.effectAnnounce,
                        tooltip:
                          "Alerts ghosts when a pod is launched. Useful if some dumb\nshit is aboutta come outta the pod.",
                        onClick: function () {
                          return c("effectAnnounce");
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Sound",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Custom Falling Sound",
                        selected: i.fallingSound,
                        tooltip:
                          "Choose a sound to play as the pod falls. Note that for this\nto work right you should know the exact length of the sound,\nin seconds.",
                        onClick: function () {
                          return c("fallSound");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Custom Landing Sound",
                        selected: i.landingSound,
                        tooltip: "Choose a sound to play when the pod lands.",
                        onClick: function () {
                          return c("landingSound");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Custom Opening Sound",
                        selected: i.openingSound,
                        tooltip: "Choose a sound to play when the pod opens.",
                        onClick: function () {
                          return c("openingSound");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Custom Leaving Sound",
                        selected: i.leavingSound,
                        tooltip:
                          "Choose a sound to play when the pod departs (whether that be\ndelection in the case of a bluespace pod, or leaving for\ncentcom for a reversing pod).",
                        onClick: function () {
                          return c("leavingSound");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Admin Sound Volume",
                        selected: i.soundVolume,
                        tooltip:
                          "Choose the volume for the sound to play at. Default values\nare between 1 and 100, but hey, do whatever. Im a tooltip,\nnot a cop.",
                        onClick: function () {
                          return c("soundVolume");
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Timers",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Custom Falling Duration",
                        selected: 4 !== i.fallDuration,
                        tooltip:
                          "Set how long the animation for the pod falling lasts. Create\ndramatic, slow falling pods!",
                        onClick: function () {
                          return c("fallDuration");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Custom Landing Time",
                        selected: 20 !== i.landingDelay,
                        tooltip:
                          "Choose the amount of time it takes for the supplypod to hit\nthe station. By default this value is 0.5 seconds.",
                        onClick: function () {
                          return c("landingDelay");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Custom Opening Time",
                        selected: 30 !== i.openingDelay,
                        tooltip:
                          "Choose the amount of time it takes for the supplypod to open\nafter landing. Useful for giving whatevers inside the pod a\nnice dramatic entrance! By default this value is 3 seconds.",
                        onClick: function () {
                          return c("openingDelay");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Custom Leaving Time",
                        selected: 30 !== i.departureDelay,
                        tooltip:
                          "Choose the amount of time it takes for the supplypod to leave\nafter landing. By default this value is 3 seconds.",
                        onClick: function () {
                          return c("departureDelay");
                        },
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Style",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Standard",
                        selected: 1 === i.styleChoice,
                        tooltip:
                          "Same color scheme as the normal station-used supplypods",
                        onClick: function () {
                          return c("styleStandard");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Advanced",
                        selected: 2 === i.styleChoice,
                        tooltip:
                          "The same as the stations upgraded blue-and-white\nBluespace Supplypods",
                        onClick: function () {
                          return c("styleBluespace");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Syndicate",
                        selected: 4 === i.styleChoice,
                        tooltip:
                          "A menacing black and blood-red. Great for sending meme-ops\nin style!",
                        onClick: function () {
                          return c("styleSyndie");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Deathsquad",
                        selected: 5 === i.styleChoice,
                        tooltip:
                          "A menacing black and dark blue. Great for sending deathsquads\nin style!",
                        onClick: function () {
                          return c("styleBlue");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Cult Pod",
                        selected: 6 === i.styleChoice,
                        tooltip: "A blood and rune covered cult pod!",
                        onClick: function () {
                          return c("styleCult");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Missile",
                        selected: 7 === i.styleChoice,
                        tooltip:
                          "A large missile. Combos well with a missile mode, so the\nmissile doesnt stick around after landing.",
                        onClick: function () {
                          return c("styleMissile");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Syndicate Missile",
                        selected: 8 === i.styleChoice,
                        tooltip:
                          "A large blood-red missile. Combos well with missile mode,\nso the missile doesnt stick around after landing.",
                        onClick: function () {
                          return c("styleSMissile");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Supply Crate",
                        selected: 9 === i.styleChoice,
                        tooltip: "A large, dark-green military supply crate.",
                        onClick: function () {
                          return c("styleBox");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "HONK",
                        selected: 10 === i.styleChoice,
                        tooltip: "A colorful, clown inspired look.",
                        onClick: function () {
                          return c("styleHONK");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "~Fruit",
                        selected: 11 === i.styleChoice,
                        tooltip: "For when an orange is angry",
                        onClick: function () {
                          return c("styleFruit");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Invisible",
                        selected: 12 === i.styleChoice,
                        tooltip:
                          'Makes the supplypod invisible! Useful for when you want to\nuse this feature with a gateway or something. Combos well\nwith the "Stealth" and "Quiet Landing" effects.',
                        onClick: function () {
                          return c("styleInvisible");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Gondola",
                        selected: 13 === i.styleChoice,
                        tooltip:
                          "This gondola can control when he wants to deliver his supplies\nif he has a smart enough mind, so offer up his body to ghosts\nfor maximum enjoyment. (Make sure to turn off bluespace and\nset a arbitrarily high open-time if you do!",
                        onClick: function () {
                          return c("styleGondola");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Show Contents (See Through Pod)",
                        selected: 14 === i.styleChoice,
                        tooltip:
                          "By selecting this, the pod will instead look like whatevers\ninside it (as if it were the contents falling by themselves,\nwithout a pod). Useful for launching mechs at the station\nand standing tall as they soar in from the heavens.",
                        onClick: function () {
                          return c("styleSeeThrough");
                        },
                      }),
                    ],
                  }),
                ],
              }),
            }),
            (0, o.createComponentVNode)(2, a.Section, {
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: i.numObjects + " turfs in " + i.bay,
                  buttons: (0, o.createFragment)(
                    [
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "undo Pod Bay",
                        tooltip:
                          "Manually undoes the possible things to launch in the\npod bay.",
                        onClick: function () {
                          return c("undo");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Enter Launch Mode",
                        selected: i.giveLauncher,
                        tooltip:
                          "THE CODEX ASTARTES CALLS THIS MANEUVER: STEEL RAIN",
                        onClick: function () {
                          return c("giveLauncher");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Clear Selected Bay",
                        color: "bad",
                        tooltip:
                          "This will delete all objs and mobs from the selected bay.",
                        tooltipPosition: "left",
                        onClick: function () {
                          return c("clearBay");
                        },
                      }),
                    ],
                    4
                  ),
                }),
              }),
            }),
          ],
          4
        );
      };
      t.CentcomPodLauncherContent = i;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ChemAcclimator = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.ChemAcclimator = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 320,
          height: 271,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Acclimator",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Current Temperature",
                      children: [l.chem_temp, " K"],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Target Temperature",
                      children: (0, o.createComponentVNode)(2, a.NumberInput, {
                        value: l.target_temperature,
                        unit: "K",
                        width: "59px",
                        minValue: 0,
                        maxValue: 1e3,
                        step: 5,
                        stepPixelSize: 2,
                        onChange: function (e, t) {
                          return i("set_target_temperature", {
                            temperature: t,
                          });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Acceptable Temp. Difference",
                      children: (0, o.createComponentVNode)(2, a.NumberInput, {
                        value: l.allowed_temperature_difference,
                        unit: "K",
                        width: "59px",
                        minValue: 1,
                        maxValue: l.target_temperature,
                        stepPixelSize: 2,
                        onChange: function (e, t) {
                          i("set_allowed_temperature_difference", {
                            temperature: t,
                          });
                        },
                      }),
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Status",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: "power-off",
                  content: l.enabled ? "On" : "Off",
                  selected: l.enabled,
                  onClick: function () {
                    return i("toggle_power");
                  },
                }),
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Volume",
                      children: (0, o.createComponentVNode)(2, a.NumberInput, {
                        value: l.max_volume,
                        unit: "u",
                        width: "50px",
                        minValue: l.reagent_volume,
                        maxValue: 200,
                        step: 2,
                        stepPixelSize: 2,
                        onChange: function (e, t) {
                          return i("change_volume", { volume: t });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Current Operation",
                      children: l.acclimate_state,
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Current State",
                      children: l.emptying ? "Emptying" : "Filling",
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ChemDebugSynthesizer = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.ChemDebugSynthesizer = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.amount,
          u = l.beakerCurrentVolume,
          s = l.beakerMaxVolume,
          m = l.isBeakerLoaded,
          p = l.beakerContents,
          C = void 0 === p ? [] : p;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 390,
          height: 330,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.Section, {
              title: "Recipient",
              buttons: m
                ? (0, o.createFragment)(
                    [
                      (0, o.createComponentVNode)(2, a.Button, {
                        icon: "eject",
                        content: "Eject",
                        onClick: function () {
                          return i("ejectBeaker");
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.NumberInput, {
                        value: d,
                        unit: "u",
                        minValue: 1,
                        maxValue: s,
                        step: 1,
                        stepPixelSize: 2,
                        onChange: function (e, t) {
                          return i("amount", { amount: t });
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        icon: "plus",
                        content: "Input",
                        onClick: function () {
                          return i("input");
                        },
                      }),
                    ],
                    4
                  )
                : (0, o.createComponentVNode)(2, a.Button, {
                    icon: "plus",
                    content: "Create Beaker",
                    onClick: function () {
                      return i("makecup");
                    },
                  }),
              children: m
                ? (0, o.createFragment)(
                    [
                      (0, o.createComponentVNode)(2, a.Box, {
                        children: [
                          (0, o.createComponentVNode)(2, a.AnimatedNumber, {
                            value: u,
                          }),
                          " / " + s + " u",
                        ],
                      }),
                      C.length > 0
                        ? (0, o.createComponentVNode)(2, a.LabeledList, {
                            children: C.map(function (e) {
                              return (0,
                              o.createComponentVNode)(2, a.LabeledList.Item, { label: e.name, children: [e.volume, " u"] }, e.name);
                            }),
                          })
                        : (0, o.createComponentVNode)(2, a.Box, {
                            color: "bad",
                            children: "Recipient Empty",
                          }),
                    ],
                    0
                  )
                : (0, o.createComponentVNode)(2, a.Box, {
                    color: "average",
                    children: "No Recipient",
                  }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ChemDispenser = void 0);
      var o = n(0),
        r = n(8),
        a = n(19),
        c = n(2),
        i = n(1),
        l = n(3);
      t.ChemDispenser = function (e, t) {
        var n = (0, c.useBackend)(t),
          d = n.act,
          u = n.data,
          s = !!u.recordingRecipe,
          m = Object.keys(u.recipes).map(function (e) {
            return { name: e, contents: u.recipes[e] };
          }),
          p = u.beakerTransferAmounts || [],
          C =
            (s &&
              Object.keys(u.recordingRecipe).map(function (e) {
                return {
                  id: e,
                  name: (0, a.toTitleCase)(e.replace(/_/, " ")),
                  volume: u.recordingRecipe[e],
                };
              })) ||
            u.beakerContents ||
            [];
        return (0, o.createComponentVNode)(2, l.Window, {
          resizable: !0,
          width: 565,
          height: 620,
          children: (0, o.createComponentVNode)(2, l.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, i.Section, {
                title: "Status",
                buttons:
                  s &&
                  (0, o.createComponentVNode)(2, i.Box, {
                    inline: !0,
                    mx: 1,
                    color: "red",
                    children: [
                      (0, o.createComponentVNode)(2, i.Icon, {
                        name: "circle",
                        mr: 1,
                      }),
                      "Recording",
                    ],
                  }),
                children: (0, o.createComponentVNode)(2, i.LabeledList, {
                  children: (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                    label: "Energy",
                    children: (0, o.createComponentVNode)(2, i.ProgressBar, {
                      value: u.energy / u.maxEnergy,
                      children: (0, r.toFixed)(u.energy) + " units",
                    }),
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, i.Section, {
                title: "Recipes",
                buttons: (0, o.createFragment)(
                  [
                    !s &&
                      (0, o.createComponentVNode)(2, i.Box, {
                        inline: !0,
                        mx: 1,
                        children: (0, o.createComponentVNode)(2, i.Button, {
                          color: "transparent",
                          content: "Clear recipes",
                          onClick: function () {
                            return d("clear_recipes");
                          },
                        }),
                      }),
                    !s &&
                      (0, o.createComponentVNode)(2, i.Button, {
                        icon: "circle",
                        disabled: !u.isBeakerLoaded,
                        content: "Record",
                        onClick: function () {
                          return d("record_recipe");
                        },
                      }),
                    s &&
                      (0, o.createComponentVNode)(2, i.Button, {
                        icon: "ban",
                        color: "transparent",
                        content: "Discard",
                        onClick: function () {
                          return d("cancel_recording");
                        },
                      }),
                    s &&
                      (0, o.createComponentVNode)(2, i.Button, {
                        icon: "save",
                        color: "green",
                        content: "Save",
                        onClick: function () {
                          return d("save_recording");
                        },
                      }),
                  ],
                  0
                ),
                children: (0, o.createComponentVNode)(2, i.Box, {
                  mr: -1,
                  children: [
                    m.map(function (e) {
                      return (0, o.createComponentVNode)(
                        2,
                        i.Button,
                        {
                          icon: "tint",
                          width: "129.5px",
                          lineHeight: "21px",
                          content: e.name,
                          onClick: function () {
                            return d("dispense_recipe", { recipe: e.name });
                          },
                        },
                        e.name
                      );
                    }),
                    0 === m.length &&
                      (0, o.createComponentVNode)(2, i.Box, {
                        color: "light-gray",
                        children: "No recipes.",
                      }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, i.Section, {
                title: "Dispense",
                buttons: p.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    i.Button,
                    {
                      icon: "plus",
                      selected: e === u.amount,
                      content: e,
                      onClick: function () {
                        return d("amount", { target: e });
                      },
                    },
                    e
                  );
                }),
                children: (0, o.createComponentVNode)(2, i.Box, {
                  mr: -1,
                  children: u.chemicals.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      i.Button,
                      {
                        icon: "tint",
                        width: "129.5px",
                        lineHeight: "21px",
                        content: e.title,
                        onClick: function () {
                          return d("dispense", { reagent: e.id });
                        },
                      },
                      e.id
                    );
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, i.Section, {
                title: "Beaker",
                buttons: p.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    i.Button,
                    {
                      icon: "minus",
                      disabled: s,
                      content: e,
                      onClick: function () {
                        return d("remove", { amount: e });
                      },
                    },
                    e
                  );
                }),
                children: (0, o.createComponentVNode)(2, i.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                      label: "Beaker",
                      buttons:
                        !!u.isBeakerLoaded &&
                        (0, o.createComponentVNode)(2, i.Button, {
                          icon: "eject",
                          content: "Eject",
                          disabled: !u.isBeakerLoaded,
                          onClick: function () {
                            return d("eject");
                          },
                        }),
                      children:
                        (s
                          ? "Virtual beaker"
                          : u.isBeakerLoaded &&
                            (0, o.createFragment)(
                              [
                                (0, o.createComponentVNode)(
                                  2,
                                  i.AnimatedNumber,
                                  { initial: 0, value: u.beakerCurrentVolume }
                                ),
                                (0, o.createTextVNode)("/"),
                                u.beakerMaxVolume,
                                (0, o.createTextVNode)(" units"),
                              ],
                              0
                            )) || "No beaker",
                    }),
                    (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                      label: "Contents",
                      children: [
                        (0, o.createComponentVNode)(2, i.Box, {
                          color: "label",
                          children:
                            u.isBeakerLoaded || s
                              ? 0 === C.length && "Nothing"
                              : "N/A",
                        }),
                        C.map(function (e) {
                          return (0,
                          o.createComponentVNode)(2, i.Box, { color: "label", children: [(0, o.createComponentVNode)(2, i.AnimatedNumber, { initial: 0, value: e.volume }), " ", "units of ", e.name] }, e.name);
                        }),
                      ],
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ChemFilter = t.ChemFilterPane = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = function (e, t) {
          var n = (0, r.useBackend)(t).act,
            c = e.title,
            i = e.list,
            l = e.reagentName,
            d = e.onReagentInput,
            u = c.toLowerCase();
          return (0, o.createComponentVNode)(2, a.Section, {
            title: c,
            minHeight: "240px",
            buttons: (0, o.createFragment)(
              [
                (0, o.createComponentVNode)(2, a.Input, {
                  placeholder: "Reagent",
                  width: "140px",
                  onInput: function (e, t) {
                    return d(t);
                  },
                }),
                (0, o.createComponentVNode)(2, a.Button, {
                  ml: 1,
                  icon: "plus",
                  onClick: function () {
                    return n("add", { which: u, name: l });
                  },
                }),
              ],
              4
            ),
            children: i.map(function (e) {
              return (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    icon: "minus",
                    content: e,
                    onClick: function () {
                      return n("remove", { which: u, reagent: e });
                    },
                  }),
                ],
                4,
                e
              );
            }),
          });
        };
      t.ChemFilterPane = i;
      t.ChemFilter = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = (n.act, n.data),
          d = l.left,
          u = void 0 === d ? [] : d,
          s = l.right,
          m = void 0 === s ? [] : s,
          p = (0, r.useLocalState)(t, "leftName", ""),
          C = p[0],
          h = p[1],
          N = (0, r.useLocalState)(t, "rightName", ""),
          V = N[0],
          b = N[1];
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 500,
          height: 300,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.Flex, {
              spacing: 1,
              children: [
                (0, o.createComponentVNode)(2, a.Flex.Item, {
                  grow: 1,
                  children: (0, o.createComponentVNode)(2, i, {
                    title: "Left",
                    list: u,
                    reagentName: C,
                    onReagentInput: function (e) {
                      return h(e);
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, a.Flex.Item, {
                  grow: 1,
                  children: (0, o.createComponentVNode)(2, i, {
                    title: "Right",
                    list: m,
                    reagentName: V,
                    onReagentInput: function (e) {
                      return b(e);
                    },
                  }),
                }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ChemHeater = void 0);
      var o = n(0),
        r = n(8),
        a = n(2),
        c = n(1),
        i = n(3),
        l = n(144);
      t.ChemHeater = function (e, t) {
        var n = (0, a.useBackend)(t),
          d = n.act,
          u = n.data,
          s = u.targetTemp,
          m = u.isActive,
          p = u.isBeakerLoaded,
          C = u.currentTemp,
          h = u.beakerCurrentVolume,
          N = u.beakerMaxVolume,
          V = u.beakerContents,
          b = void 0 === V ? [] : V;
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 275,
          height: 320,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Thermostat",
                buttons: (0, o.createComponentVNode)(2, c.Button, {
                  icon: m ? "power-off" : "times",
                  selected: m,
                  content: m ? "On" : "Off",
                  onClick: function () {
                    return d("power");
                  },
                }),
                children: (0, o.createComponentVNode)(2, c.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Target",
                      children: (0, o.createComponentVNode)(2, c.NumberInput, {
                        width: "65px",
                        unit: "K",
                        step: 10,
                        stepPixelSize: 3,
                        value: (0, r.round)(s),
                        minValue: 0,
                        maxValue: 1e3,
                        onDrag: function (e, t) {
                          return d("temperature", { target: t });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Reading",
                      children: (0, o.createComponentVNode)(2, c.Box, {
                        width: "60px",
                        textAlign: "right",
                        children:
                          (p &&
                            (0, o.createComponentVNode)(2, c.AnimatedNumber, {
                              value: C,
                              format: function (e) {
                                return (0, r.toFixed)(e) + " K";
                              },
                            })) ||
                          "\u2014",
                      }),
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Beaker",
                buttons:
                  !!p &&
                  (0, o.createFragment)(
                    [
                      (0, o.createComponentVNode)(2, c.Box, {
                        inline: !0,
                        color: "label",
                        mr: 2,
                        children: [h, " / ", N, " units"],
                      }),
                      (0, o.createComponentVNode)(2, c.Button, {
                        icon: "eject",
                        content: "Eject",
                        onClick: function () {
                          return d("eject");
                        },
                      }),
                    ],
                    4
                  ),
                children: (0, o.createComponentVNode)(2, l.BeakerContents, {
                  beakerLoaded: p,
                  beakerContents: b,
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ChemMaster = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.ChemMaster = function (e, t) {
        var n = (0, r.useBackend)(t).data.screen;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 465,
          height: 550,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children:
              ("analyze" === n && (0, o.createComponentVNode)(2, m)) ||
              (0, o.createComponentVNode)(2, i),
          }),
        });
      };
      var i = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data,
            u = i.screen,
            p = i.beakerContents,
            C = void 0 === p ? [] : p,
            h = i.bufferContents,
            N = void 0 === h ? [] : h,
            V = i.beakerCurrentVolume,
            b = i.beakerMaxVolume,
            f = i.isBeakerLoaded,
            g = i.isPillBottleLoaded,
            v = i.pillBottleCurrentAmount,
            k = i.pillBottleMaxAmount;
          return "analyze" === u
            ? (0, o.createComponentVNode)(2, m)
            : (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, a.Section, {
                    title: "Beaker",
                    buttons:
                      !!i.isBeakerLoaded &&
                      (0, o.createFragment)(
                        [
                          (0, o.createComponentVNode)(2, a.Box, {
                            inline: !0,
                            color: "label",
                            mr: 2,
                            children: [
                              (0, o.createComponentVNode)(2, a.AnimatedNumber, {
                                value: V,
                                initial: 0,
                              }),
                              " / " + b + " units",
                            ],
                          }),
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "eject",
                            content: "Eject",
                            onClick: function () {
                              return c("eject");
                            },
                          }),
                        ],
                        4
                      ),
                    children: [
                      !f &&
                        (0, o.createComponentVNode)(2, a.Box, {
                          color: "label",
                          mt: "3px",
                          mb: "5px",
                          children: "No beaker loaded.",
                        }),
                      !!f &&
                        0 === C.length &&
                        (0, o.createComponentVNode)(2, a.Box, {
                          color: "label",
                          mt: "3px",
                          mb: "5px",
                          children: "Beaker is empty.",
                        }),
                      (0, o.createComponentVNode)(2, l, {
                        children: C.map(function (e) {
                          return (0,
                          o.createComponentVNode)(2, d, { chemical: e, transferTo: "buffer" }, e.id);
                        }),
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.Section, {
                    title: "Buffer",
                    buttons: (0, o.createFragment)(
                      [
                        (0, o.createComponentVNode)(2, a.Box, {
                          inline: !0,
                          color: "label",
                          mr: 1,
                          children: "Mode:",
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          color: i.mode ? "good" : "bad",
                          icon: i.mode ? "exchange-alt" : "times",
                          content: i.mode ? "Transfer" : "Destroy",
                          onClick: function () {
                            return c("toggleMode");
                          },
                        }),
                      ],
                      4
                    ),
                    children: [
                      0 === N.length &&
                        (0, o.createComponentVNode)(2, a.Box, {
                          color: "label",
                          mt: "3px",
                          mb: "5px",
                          children: "Buffer is empty.",
                        }),
                      (0, o.createComponentVNode)(2, l, {
                        children: N.map(function (e) {
                          return (0,
                          o.createComponentVNode)(2, d, { chemical: e, transferTo: "beaker" }, e.id);
                        }),
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.Section, {
                    title: "Packaging",
                    children: (0, o.createComponentVNode)(2, s),
                  }),
                  !!g &&
                    (0, o.createComponentVNode)(2, a.Section, {
                      title: "Pill Bottle",
                      buttons: (0, o.createFragment)(
                        [
                          (0, o.createComponentVNode)(2, a.Box, {
                            inline: !0,
                            color: "label",
                            mr: 2,
                            children: [v, " / ", k, " pills"],
                          }),
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "eject",
                            content: "Eject",
                            onClick: function () {
                              return c("ejectPillBottle");
                            },
                          }),
                        ],
                        4
                      ),
                    }),
                ],
                0
              );
        },
        l = a.Table,
        d = function (e, t) {
          var n = (0, r.useBackend)(t).act,
            c = e.chemical,
            i = e.transferTo;
          return (0, o.createComponentVNode)(
            2,
            a.Table.Row,
            {
              children: [
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  color: "label",
                  children: [
                    (0, o.createComponentVNode)(2, a.AnimatedNumber, {
                      value: c.volume,
                      initial: 0,
                    }),
                    " units of " + c.name,
                  ],
                }),
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  collapsing: !0,
                  children: [
                    (0, o.createComponentVNode)(2, a.Button, {
                      content: "1",
                      onClick: function () {
                        return n("transfer", { id: c.id, amount: 1, to: i });
                      },
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      content: "5",
                      onClick: function () {
                        return n("transfer", { id: c.id, amount: 5, to: i });
                      },
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      content: "10",
                      onClick: function () {
                        return n("transfer", { id: c.id, amount: 10, to: i });
                      },
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      content: "All",
                      onClick: function () {
                        return n("transfer", { id: c.id, amount: 1e3, to: i });
                      },
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      icon: "ellipsis-h",
                      title: "Custom amount",
                      onClick: function () {
                        return n("transfer", { id: c.id, amount: -1, to: i });
                      },
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      icon: "question",
                      title: "Analyze",
                      onClick: function () {
                        return n("analyze", { id: c.id });
                      },
                    }),
                  ],
                }),
              ],
            },
            c.id
          );
        },
        u = function (e) {
          var t = e.label,
            n = e.amountUnit,
            r = e.amount,
            c = e.onChangeAmount,
            i = e.onCreate,
            l = e.sideNote;
          return (0, o.createComponentVNode)(2, a.LabeledList.Item, {
            label: t,
            children: [
              (0, o.createComponentVNode)(2, a.NumberInput, {
                width: "84px",
                unit: n,
                step: 1,
                stepPixelSize: 15,
                value: r,
                minValue: 1,
                maxValue: 10,
                onChange: c,
              }),
              (0, o.createComponentVNode)(2, a.Button, {
                ml: 1,
                content: "Create",
                onClick: i,
              }),
              (0, o.createComponentVNode)(2, a.Box, {
                inline: !0,
                ml: 1,
                color: "label",
                children: l,
              }),
            ],
          });
        },
        s = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data,
            l = (0, r.useSharedState)(t, "pillAmount", 1),
            d = l[0],
            s = l[1],
            m = (0, r.useSharedState)(t, "patchAmount", 1),
            p = m[0],
            C = m[1],
            h = (0, r.useSharedState)(t, "bottleAmount", 1),
            N = h[0],
            V = h[1],
            b = (0, r.useSharedState)(t, "packAmount", 1),
            f = b[0],
            g = b[1],
            v = i.condi,
            k = i.chosenPillStyle,
            w = i.pillStyles,
            B = void 0 === w ? [] : w;
          return (0, o.createComponentVNode)(2, a.LabeledList, {
            children: [
              !v &&
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Pill type",
                  children: B.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      a.Button,
                      {
                        width: "30px",
                        selected: e.id === k,
                        textAlign: "center",
                        color: "transparent",
                        onClick: function () {
                          return c("pillStyle", { id: e.id });
                        },
                        children: (0, o.createComponentVNode)(2, a.Box, {
                          mx: -1,
                          className: e.className,
                        }),
                      },
                      e.id
                    );
                  }),
                }),
              !v &&
                (0, o.createComponentVNode)(2, u, {
                  label: "Pills",
                  amount: d,
                  amountUnit: "pills",
                  sideNote: "max 50u",
                  onChangeAmount: function (e, t) {
                    return s(t);
                  },
                  onCreate: function () {
                    return c("create", {
                      type: "pill",
                      amount: d,
                      volume: "auto",
                    });
                  },
                }),
              !v &&
                (0, o.createComponentVNode)(2, u, {
                  label: "Patches",
                  amount: p,
                  amountUnit: "patches",
                  sideNote: "max 40u",
                  onChangeAmount: function (e, t) {
                    return C(t);
                  },
                  onCreate: function () {
                    return c("create", {
                      type: "patch",
                      amount: p,
                      volume: "auto",
                    });
                  },
                }),
              !v &&
                (0, o.createComponentVNode)(2, u, {
                  label: "Bottles",
                  amount: N,
                  amountUnit: "bottles",
                  sideNote: "max 30u",
                  onChangeAmount: function (e, t) {
                    return V(t);
                  },
                  onCreate: function () {
                    return c("create", {
                      type: "bottle",
                      amount: N,
                      volume: "auto",
                    });
                  },
                }),
              !!v &&
                (0, o.createComponentVNode)(2, u, {
                  label: "Packs",
                  amount: f,
                  amountUnit: "packs",
                  sideNote: "max 10u",
                  onChangeAmount: function (e, t) {
                    return g(t);
                  },
                  onCreate: function () {
                    return c("create", {
                      type: "condimentPack",
                      amount: f,
                      volume: "auto",
                    });
                  },
                }),
              !!v &&
                (0, o.createComponentVNode)(2, u, {
                  label: "Bottles",
                  amount: N,
                  amountUnit: "bottles",
                  sideNote: "max 50u",
                  onChangeAmount: function (e, t) {
                    return V(t);
                  },
                  onCreate: function () {
                    return c("create", {
                      type: "condimentBottle",
                      amount: N,
                      volume: "auto",
                    });
                  },
                }),
            ],
          });
        },
        m = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data.analyzeVars;
          return (0, o.createComponentVNode)(2, a.Section, {
            title: "Analysis Results",
            buttons: (0, o.createComponentVNode)(2, a.Button, {
              icon: "arrow-left",
              content: "Back",
              onClick: function () {
                return c("goScreen", { screen: "home" });
              },
            }),
            children: (0, o.createComponentVNode)(2, a.LabeledList, {
              children: [
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Name",
                  children: i.name,
                }),
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "State",
                  children: i.state,
                }),
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Color",
                  children: [
                    (0, o.createComponentVNode)(2, a.ColorBox, {
                      color: i.color,
                      mr: 1,
                    }),
                    i.color,
                  ],
                }),
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Description",
                  children: i.description,
                }),
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Metabolization Rate",
                  children: [i.metaRate, " u/minute"],
                }),
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Overdose Threshold",
                  children: i.overD,
                }),
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Addiction Threshold",
                  children: i.addicD,
                }),
              ],
            }),
          });
        };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ChemPress = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.ChemPress = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.pill_size,
          u = l.pill_name,
          s = l.pill_style,
          m = l.pill_styles,
          p = void 0 === m ? [] : m;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 300,
          height: 199,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Pill Volume",
                    children: (0, o.createComponentVNode)(2, a.NumberInput, {
                      value: d,
                      unit: "u",
                      width: "43px",
                      minValue: 5,
                      maxValue: 50,
                      step: 1,
                      stepPixelSize: 2,
                      onChange: function (e, t) {
                        return i("change_pill_size", { volume: t });
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Pill Name",
                    children: (0, o.createComponentVNode)(2, a.Input, {
                      value: u,
                      onChange: function (e, t) {
                        return i("change_pill_name", { name: t });
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Pill Style",
                    children: p.map(function (e) {
                      return (0, o.createComponentVNode)(
                        2,
                        a.Button,
                        {
                          width: "30px",
                          selected: e.id === s,
                          textAlign: "center",
                          color: "transparent",
                          onClick: function () {
                            return i("change_pill_style", { id: e.id });
                          },
                          children: (0, o.createComponentVNode)(2, a.Box, {
                            mx: -1,
                            className: e.class_name,
                          }),
                        },
                        e.id
                      );
                    }),
                  }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ChemReactionChamber = void 0);
      var o = n(0),
        r = n(21),
        a = n(6),
        c = n(2),
        i = n(1),
        l = n(3);
      t.ChemReactionChamber = function (e, t) {
        var n = (0, c.useBackend)(t),
          d = n.act,
          u = n.data,
          s = (0, c.useLocalState)(t, "reagentName", ""),
          m = s[0],
          p = s[1],
          C = (0, c.useLocalState)(t, "reagentQuantity", 1),
          h = C[0],
          N = C[1],
          V = u.emptying,
          b = u.reagents || [];
        return (0, o.createComponentVNode)(2, l.Window, {
          resizable: !0,
          width: 250,
          height: 225,
          children: (0, o.createComponentVNode)(2, l.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, i.Section, {
              title: "Reagents",
              buttons: (0, o.createComponentVNode)(2, i.Box, {
                inline: !0,
                bold: !0,
                color: V ? "bad" : "good",
                children: V ? "Emptying" : "Filling",
              }),
              children: (0, o.createComponentVNode)(2, i.LabeledList, {
                children: [
                  (0, o.createVNode)(
                    1,
                    "tr",
                    "LabledList__row",
                    [
                      (0, o.createVNode)(
                        1,
                        "td",
                        "LabeledList__cell",
                        (0, o.createComponentVNode)(2, i.Input, {
                          fluid: !0,
                          value: "",
                          placeholder: "Reagent Name",
                          onInput: function (e, t) {
                            return p(t);
                          },
                        }),
                        2,
                        { colSpan: "2" }
                      ),
                      (0, o.createVNode)(
                        1,
                        "td",
                        (0, a.classes)([
                          "LabeledList__buttons",
                          "LabeledList__cell",
                        ]),
                        [
                          (0, o.createComponentVNode)(2, i.NumberInput, {
                            value: h,
                            minValue: 1,
                            maxValue: 100,
                            step: 1,
                            stepPixelSize: 3,
                            width: "39px",
                            onDrag: function (e, t) {
                              return N(t);
                            },
                          }),
                          (0, o.createComponentVNode)(2, i.Box, {
                            inline: !0,
                            mr: 1,
                          }),
                          (0, o.createComponentVNode)(2, i.Button, {
                            icon: "plus",
                            onClick: function () {
                              return d("add", { chem: m, amount: h });
                            },
                          }),
                        ],
                        4
                      ),
                    ],
                    4
                  ),
                  (0, r.map)(function (e, t) {
                    return (0, o.createComponentVNode)(
                      2,
                      i.LabeledList.Item,
                      {
                        label: t,
                        buttons: (0, o.createComponentVNode)(2, i.Button, {
                          icon: "minus",
                          color: "bad",
                          onClick: function () {
                            return d("remove", { chem: t });
                          },
                        }),
                        children: e,
                      },
                      t
                    );
                  })(b),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ChemSplitter = void 0);
      var o = n(0),
        r = n(8),
        a = n(2),
        c = n(1),
        i = n(3);
      t.ChemSplitter = function (e, t) {
        var n = (0, a.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.straight,
          s = d.side,
          m = d.max_transfer;
        return (0, o.createComponentVNode)(2, i.Window, {
          width: 220,
          height: 105,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: (0, o.createComponentVNode)(2, c.Section, {
              children: (0, o.createComponentVNode)(2, c.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                    label: "Straight",
                    children: (0, o.createComponentVNode)(2, c.NumberInput, {
                      value: u,
                      unit: "u",
                      width: "55px",
                      minValue: 1,
                      maxValue: m,
                      format: function (e) {
                        return (0, r.toFixed)(e, 2);
                      },
                      step: 0.05,
                      stepPixelSize: 4,
                      onChange: function (e, t) {
                        return l("set_amount", {
                          target: "straight",
                          amount: t,
                        });
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                    label: "Side",
                    children: (0, o.createComponentVNode)(2, c.NumberInput, {
                      value: s,
                      unit: "u",
                      width: "55px",
                      minValue: 1,
                      maxValue: m,
                      format: function (e) {
                        return (0, r.toFixed)(e, 2);
                      },
                      step: 0.05,
                      stepPixelSize: 4,
                      onChange: function (e, t) {
                        return l("set_amount", { target: "side", amount: t });
                      },
                    }),
                  }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ChemSynthesizer = void 0);
      var o = n(0),
        r = n(8),
        a = n(2),
        c = n(1),
        i = n(3);
      t.ChemSynthesizer = function (e, t) {
        var n = (0, a.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.amount,
          s = d.current_reagent,
          m = d.chemicals,
          p = void 0 === m ? [] : m,
          C = d.possible_amounts,
          h = void 0 === C ? [] : C;
        return (0, o.createComponentVNode)(2, i.Window, {
          width: 300,
          height: 375,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: (0, o.createComponentVNode)(2, c.Section, {
              children: [
                (0, o.createComponentVNode)(2, c.Box, {
                  children: h.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      c.Button,
                      {
                        icon: "plus",
                        content: (0, r.toFixed)(e, 0),
                        selected: e === u,
                        onClick: function () {
                          return l("amount", { target: e });
                        },
                      },
                      (0, r.toFixed)(e, 0)
                    );
                  }),
                }),
                (0, o.createComponentVNode)(2, c.Box, {
                  mt: 1,
                  children: p.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      c.Button,
                      {
                        icon: "tint",
                        content: e.title,
                        width: "129px",
                        selected: e.id === s,
                        onClick: function () {
                          return l("select", { reagent: e.id });
                        },
                      },
                      e.id
                    );
                  }),
                }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.ClockworkButtonSelection = t.ClockworkOverviewStat = t.ClockworkOverview = t.ClockworkSpellList = t.ClockworkHelp = t.ClockworkSlab = t.convertPower = void 0);
      var o = n(0),
        r = (n(19), n(2)),
        a = n(1),
        c = (n(52), n(3)),
        i = n(141),
        l =
          (n(198),
          function (e) {
            for (
              var t = ["W", "kW", "MW", "GW"], n = 0, o = e;
              o >= 1e3 && n < t.length;

            )
              n++, (o /= 1e3);
            return Math.round(100 * (o + Number.EPSILON)) / 100 + t[n];
          });
      t.convertPower = l;
      t.ClockworkSlab = function (e, t) {
        var n = (0, r.useBackend)(t).data,
          i =
            (n.power,
            n.recollection,
            (0, r.useLocalState)(t, "selectedTab", "Servitude")),
          l = i[0];
        i[1];
        return (0, o.createComponentVNode)(2, c.Window, {
          theme: "clockwork",
          resizable: !0,
          width: 860,
          height: 700,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: (0, o.createComponentVNode)(2, a.Box, {
                  inline: !0,
                  color: "good",
                  children: [
                    (0, o.createComponentVNode)(2, a.Icon, {
                      name: "cog",
                      rotation: 0,
                      spin: 1,
                    }),
                    " Clockwork Slab ",
                    (0, o.createComponentVNode)(2, a.Icon, {
                      name: "cog",
                      rotation: 35,
                      spin: 1,
                    }),
                  ],
                }),
                children: (0, o.createComponentVNode)(2, p),
              }),
              (0, o.createVNode)(
                1,
                "div",
                "ClockSlab__left",
                (0, o.createComponentVNode)(2, a.Section, {
                  height: "100%",
                  overflowY: "scroll",
                  children: (0, o.createComponentVNode)(2, u, {
                    selectedTab: l,
                  }),
                }),
                2
              ),
              (0, o.createVNode)(
                1,
                "div",
                "ClockSlab__right",
                [
                  (0, o.createVNode)(
                    1,
                    "div",
                    "ClockSlab__stats",
                    (0, o.createComponentVNode)(2, a.Section, {
                      height: "100%",
                      scrollable: !0,
                      overflowY: "scroll",
                      children: (0, o.createComponentVNode)(2, s),
                    }),
                    2
                  ),
                  (0, o.createVNode)(
                    1,
                    "div",
                    "ClockSlab__current",
                    (0, o.createComponentVNode)(2, a.Section, {
                      height: "100%",
                      scrollable: !0,
                      overflowY: "scroll",
                      title: "Servants of the Cog vol.1",
                      children: (0, o.createComponentVNode)(2, d),
                    }),
                    2
                  ),
                ],
                4
              ),
            ],
          }),
        });
      };
      var d = function (e, t) {
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, a.Collapsible, {
              title: "Where To Start",
              color: "average",
              open: 1,
              children: (0, o.createComponentVNode)(2, a.Section, {
                children: [
                  "After a long and destructive war, Rat'Var has been imprisoned inside a dimension of suffering.",
                  (0, o.createVNode)(1, "br"),
                  "You are a group of his last remaining, most loyal servants. ",
                  (0, o.createVNode)(1, "br"),
                  "You are very weak and have little power, with most of your scriptures unable to function.",
                  (0, o.createVNode)(1, "br"),
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    [
                      (0, o.createTextVNode)("Use the\xa0"),
                      (0, o.createVNode)(
                        1,
                        "font",
                        null,
                        "Ratvarian Observation Consoles\xa0",
                        16,
                        { color: "#BD78C4" }
                      ),
                      (0, o.createTextVNode)("to warp to the station!"),
                    ],
                    4
                  ),
                  (0, o.createVNode)(1, "br"),
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    [
                      (0, o.createTextVNode)("Install\xa0"),
                      (0, o.createVNode)(
                        1,
                        "font",
                        null,
                        "Integration Cogs\xa0",
                        16,
                        { color: "#DFC69C" }
                      ),
                      (0, o.createTextVNode)(
                        "to unlock more scriptures and siphon power!"
                      ),
                    ],
                    4
                  ),
                  (0, o.createVNode)(1, "br"),
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    [
                      (0, o.createTextVNode)("Unlock\xa0"),
                      (0, o.createVNode)(1, "font", null, "Kindle\xa0", 16, {
                        color: "#D8D98D",
                      }),
                      (0, o.createTextVNode)(",\xa0"),
                      (0, o.createVNode)(
                        1,
                        "font",
                        null,
                        "Hateful Manacles\xa0",
                        16,
                        { color: "#F19096" }
                      ),
                      (0, o.createTextVNode)("and summon a\xa0"),
                      (0, o.createVNode)(
                        1,
                        "font",
                        null,
                        "Sigil of Submission\xa0",
                        16,
                        { color: "#9EA7E5" }
                      ),
                      (0, o.createTextVNode)("to convert any non-believers!"),
                    ],
                    4
                  ),
                  (0, o.createVNode)(1, "br"),
                ],
              }),
            }),
            (0, o.createComponentVNode)(2, a.Collapsible, {
              title: "Unlocking Scriptures",
              color: "average",
              children: (0, o.createComponentVNode)(2, a.Section, {
                children: [
                  "Most scriptures require ",
                  (0, o.createVNode)(1, "b", null, "cogs", 16),
                  " to unlock.",
                  (0, o.createVNode)(1, "br"),
                  "Invoke\xa0",
                  (0, o.createVNode)(
                    1,
                    "font",
                    null,
                    (0, o.createVNode)(1, "b", null, "Integration Cog\xa0", 16),
                    2,
                    { color: "#DFC69C" }
                  ),
                  "to summon an Integration Cog, which can be placed into any\xa0",
                  (0, o.createVNode)(1, "b", null, "APC\xa0", 16),
                  "on the station.",
                  (0, o.createVNode)(1, "br"),
                  "Slice open the\xa0",
                  (0, o.createVNode)(1, "b", null, "APC\xa0", 16),
                  "with the\xa0",
                  (0, o.createVNode)(1, "b", null, "Integration Cog\xa0", 16),
                  ", then insert it in to begin siphoning power.",
                  (0, o.createVNode)(1, "br"),
                ],
              }),
            }),
            (0, o.createComponentVNode)(2, a.Collapsible, {
              title: "Conversion",
              color: "average",
              children: (0, o.createComponentVNode)(2, a.Section, {
                children: [
                  "Invoke",
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    (0, o.createVNode)(1, "font", null, "Kindle\xa0", 16, {
                      color: "#D8D98D",
                    }),
                    2
                  ),
                  "(After you unlock it), to\xa0",
                  (0, o.createVNode)(1, "b", null, "stun\xa0", 16),
                  "and\xa0",
                  (0, o.createVNode)(1, "b", null, "mute\xa0", 16),
                  "any target long enough for you to restrain",
                  (0, o.createVNode)(1, "br"),
                  "Using\xa0",
                  (0, o.createVNode)(1, "b", null, "zipties\xa0", 16),
                  " obtained from the station, or by invoking\xa0",
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    (0, o.createVNode)(
                      1,
                      "font",
                      null,
                      "Hateful Manacles\xa0",
                      16,
                      { color: "#F19096" }
                    ),
                    2
                  ),
                  ", you can restrain targets to keep them from escaping the light.",
                  (0, o.createVNode)(1, "br"),
                  "Invoke\xa0",
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    (0, o.createVNode)(1, "font", null, "Abscond\xa0", 16, {
                      color: "#D5B8DC",
                    }),
                    2
                  ),
                  "to warp back to Reebe, where the being you are dragging will be pulled with you.",
                  (0, o.createVNode)(1, "br"),
                  "From there, summon a\xa0",
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    (0, o.createVNode)(
                      1,
                      "font",
                      null,
                      "Sigil of Submission\xa0",
                      16,
                      { color: "#9EA7E5" }
                    ),
                    2
                  ),
                  "and hold them over it for 8 seconds. ",
                  (0, o.createVNode)(1, "br"),
                  "You cannot enlighten those who have\xa0",
                  (0, o.createVNode)(1, "b", null, "mindshields.", 16),
                  (0, o.createVNode)(1, "br"),
                  "Make sure to take their\xa0",
                  (0, o.createVNode)(1, "b", null, "headset\xa0", 16),
                  "so they don't spread misinformation!",
                  (0, o.createVNode)(1, "br"),
                ],
              }),
            }),
            (0, o.createComponentVNode)(2, a.Collapsible, {
              title: "Defending Reebe",
              color: "average",
              children: (0, o.createComponentVNode)(2, a.Section, {
                children: [
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    "You have a wide range of structures and powers that will be vital in defending the Celestial Gateway.",
                    16
                  ),
                  (0, o.createVNode)(1, "br"),
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    (0, o.createVNode)(
                      1,
                      "font",
                      null,
                      "Replicant Fabricator:\xa0",
                      16,
                      { color: "#B5FD9D" }
                    ),
                    2
                  ),
                  "A powerful tool that can rapidly construct Brass structures, or convert most materials to Brass.",
                  (0, o.createVNode)(1, "br"),
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    (0, o.createVNode)(1, "font", null, "Cogscarab:\xa0", 16, {
                      color: "#DED09F",
                    }),
                    2
                  ),
                  "A small drone possessed by the spirits of the fallen soldiers which will protect Reebe while you go out and spread the truth!",
                  (0, o.createVNode)(1, "br"),
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    (0, o.createVNode)(
                      1,
                      "font",
                      null,
                      "Clockwork Marauder:\xa0",
                      16,
                      { color: "#FF9D9D" }
                    ),
                    2
                  ),
                  "A powerful shell that can deflect ranged attacks and delivers a strong blow in close quarter combat.",
                  (0, o.createVNode)(1, "br"),
                  (0, o.createVNode)(1, "br"),
                ],
              }),
            }),
            (0, o.createComponentVNode)(2, a.Collapsible, {
              title: "Celestial Gateway",
              color: "average",
              children: (0, o.createComponentVNode)(2, a.Section, {
                children: [
                  "To summon Rat'Var the\xa0",
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    (0, o.createVNode)(
                      1,
                      "font",
                      null,
                      "Celestial Gateway\xa0",
                      16,
                      { color: "#E9E094" }
                    ),
                    2
                  ),
                  " must be opened.",
                  (0, o.createVNode)(1, "br"),
                  "This can be done by having enough servants invoke\xa0",
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    (0, o.createVNode)(
                      1,
                      "font",
                      null,
                      "Celestial Gateway.\xa0",
                      16,
                      { color: "#B5FD9D" }
                    ),
                    2
                  ),
                  (0, o.createVNode)(1, "br"),
                  "After you enlighten enough of the crew, the\xa0",
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    (0, o.createVNode)(
                      1,
                      "font",
                      null,
                      "Celestial Gateway\xa0",
                      16,
                      { color: "#E9E094" }
                    ),
                    2
                  ),
                  "will be forced open.",
                  (0, o.createVNode)(1, "br"),
                  (0, o.createVNode)(
                    1,
                    "b",
                    null,
                    "Make sure you are prepared for when the Gateway opens, since the entire crew will swarm to destroy it!",
                    16
                  ),
                  (0, o.createVNode)(1, "br"),
                ],
              }),
            }),
          ],
          4
        );
      };
      t.ClockworkHelp = d;
      var u = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          d = n.data,
          u = e.selectedTab,
          s = d.scriptures,
          m = void 0 === s ? [] : s;
        return (0, o.createComponentVNode)(2, a.Table, {
          children: m.map(function (e) {
            return e.type === u
              ? (0, o.createFragment)(
                  [
                    (0, o.createComponentVNode)(2, i.TableRow, {
                      children: [
                        (0, o.createComponentVNode)(2, a.Table.Cell, {
                          bold: !0,
                          children: e.name,
                        }),
                        (0, o.createComponentVNode)(2, a.Table.Cell, {
                          collapsing: !0,
                          textAlign: "right",
                          children: (0, o.createComponentVNode)(2, a.Button, {
                            fluid: !0,
                            color: e.purchased ? "default" : "average",
                            content: e.purchased
                              ? "Invoke " + l(e.cost)
                              : e.cog_cost + " Cogs",
                            disabled: !1,
                            onClick: function () {
                              return c("invoke", { scriptureName: e.name });
                            },
                          }),
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, i.TableRow, {
                      children: [
                        (0, o.createComponentVNode)(2, a.Table.Cell, {
                          children: e.desc,
                        }),
                        (0, o.createComponentVNode)(2, a.Table.Cell, {
                          collapsing: !0,
                          textAlign: "right",
                          children: (0, o.createComponentVNode)(2, a.Button, {
                            fluid: !0,
                            content: "Quickbind",
                            disabled: !e.purchased,
                            onClick: function () {
                              return c("quickbind", { scriptureName: e.name });
                            },
                          }),
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      children: (0, o.createComponentVNode)(2, a.Divider),
                    }),
                  ],
                  4,
                  e
                )
              : (0, o.createComponentVNode)(2, a.Box, null, e);
          }),
        });
      };
      t.ClockworkSpellList = u;
      var s = function (e, t) {
        var n = (0, r.useBackend)(t).data,
          c = n.power,
          i = n.cogs,
          d = n.vitality;
        return (0, o.createComponentVNode)(2, a.Box, {
          children: [
            (0, o.createComponentVNode)(2, a.Box, {
              color: "good",
              bold: !0,
              fontSize: "16px",
              children: "Celestial Gateway Report",
            }),
            (0, o.createComponentVNode)(2, a.Divider),
            (0, o.createComponentVNode)(2, m, {
              title: "Cogs",
              amount: i,
              maxAmount: i + 50 / i,
              iconName: "cog",
              unit: "",
            }),
            (0, o.createComponentVNode)(2, m, {
              title: "Power",
              amount: c,
              maxAmount: c + 5e5 / c,
              iconName: "battery-half ",
              overrideText: l(c),
            }),
            (0, o.createComponentVNode)(2, m, {
              title: "Vitality",
              amount: d,
              maxAmount: d + 50 / d,
              iconName: "tint",
              unit: "u",
            }),
          ],
        });
      };
      t.ClockworkOverview = s;
      var m = function (e, t) {
        var n = e.title,
          r = e.iconName,
          c = e.amount,
          i = e.maxAmount,
          l = e.unit,
          d = e.overrideText;
        return (0, o.createComponentVNode)(2, a.Box, {
          height: "22px",
          fontSize: "16px",
          children: (0, o.createComponentVNode)(2, a.Grid, {
            children: [
              (0, o.createComponentVNode)(2, a.Grid.Column, {
                children: (0, o.createComponentVNode)(2, a.Icon, {
                  name: r,
                  rotation: 0,
                  spin: 0,
                }),
              }),
              (0, o.createComponentVNode)(2, a.Grid.Column, {
                size: "2",
                children: n,
              }),
              (0, o.createComponentVNode)(2, a.Grid.Column, {
                size: "8",
                children: (0, o.createComponentVNode)(2, a.ProgressBar, {
                  value: c,
                  minValue: 0,
                  maxValue: i,
                  ranges: {
                    good: [i / 2, Infinity],
                    average: [i / 4, i / 2],
                    bad: [-Infinity, i / 4],
                  },
                  children: d || c + " " + l,
                }),
              }),
            ],
          }),
        });
      };
      t.ClockworkOverviewStat = m;
      var p = function (e, t) {
        var n = (0, r.useLocalState)(t, "selectedTab", {}),
          c = (n[0], n[1]);
        return (0, o.createComponentVNode)(2, a.Table, {
          children: (0, o.createComponentVNode)(2, a.Table.Row, {
            children: ["Servitude", "Preservation", "Structures"].map(function (
              e
            ) {
              return (0, o.createComponentVNode)(
                2,
                a.Table.Cell,
                {
                  collapsing: !0,
                  children: (0, o.createComponentVNode)(
                    2,
                    a.Button,
                    {
                      fluid: !0,
                      content: e,
                      onClick: function () {
                        return c(e);
                      },
                    },
                    e
                  ),
                },
                e
              );
            }),
          }),
        });
      };
      t.ClockworkButtonSelection = p;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.CodexGigas = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = ["Dark", "Hellish", "Fallen", "Fiery", "Sinful", "Blood", "Fluffy"],
        l = [
          "Lord",
          "Prelate",
          "Count",
          "Viscount",
          "Vizier",
          "Elder",
          "Adept",
        ],
        d = [
          "hal",
          "ve",
          "odr",
          "neit",
          "ci",
          "quon",
          "mya",
          "folth",
          "wren",
          "geyr",
          "hil",
          "niet",
          "twou",
          "phi",
          "coa",
        ],
        u = [
          "the Red",
          "the Soulless",
          "the Master",
          "the Lord of all things",
          "Jr.",
        ];
      t.CodexGigas = function (e, t) {
        var n = (0, r.useBackend)(t),
          s = n.act,
          m = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 450,
          height: 450,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: [
                m.name,
                (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Prefix",
                      children: i.map(function (e) {
                        return (0, o.createComponentVNode)(
                          2,
                          a.Button,
                          {
                            content: e,
                            disabled: 1 !== m.currentSection,
                            onClick: function () {
                              return s(e + " ");
                            },
                          },
                          e.toLowerCase()
                        );
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Title",
                      children: l.map(function (e) {
                        return (0, o.createComponentVNode)(
                          2,
                          a.Button,
                          {
                            content: e,
                            disabled: m.currentSection > 2,
                            onClick: function () {
                              return s(e + " ");
                            },
                          },
                          e.toLowerCase()
                        );
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Name",
                      children: d.map(function (e) {
                        return (0, o.createComponentVNode)(
                          2,
                          a.Button,
                          {
                            content: e,
                            disabled: m.currentSection > 4,
                            onClick: function () {
                              return s(e);
                            },
                          },
                          e.toLowerCase()
                        );
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Suffix",
                      children: u.map(function (e) {
                        return (0, o.createComponentVNode)(
                          2,
                          a.Button,
                          {
                            content: e,
                            disabled: 4 !== m.currentSection,
                            onClick: function () {
                              return s(" " + e);
                            },
                          },
                          e.toLowerCase()
                        );
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Submit",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        content: "Search",
                        disabled: m.currentSection < 4,
                        onClick: function () {
                          return s("search");
                        },
                      }),
                    }),
                  ],
                }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ComputerFabricator = void 0);
      var o = n(0),
        r = (n(19), n(2)),
        a = n(1),
        c = n(3);
      t.ComputerFabricator = function (e, t) {
        var n = (0, r.useBackend)(t),
          s = n.act,
          m = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 500,
          height: 400,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                italic: !0,
                fontSize: "20px",
                children: "Your perfect device, only three steps away...",
              }),
              0 !== m.state &&
                (0, o.createComponentVNode)(2, a.Button, {
                  fluid: !0,
                  mb: 1,
                  icon: "circle",
                  content: "Clear Order",
                  onClick: function () {
                    return s("clean_order");
                  },
                }),
              0 === m.state && (0, o.createComponentVNode)(2, i),
              1 === m.state && (0, o.createComponentVNode)(2, l),
              2 === m.state && (0, o.createComponentVNode)(2, d),
              3 === m.state && (0, o.createComponentVNode)(2, u),
            ],
          }),
        });
      };
      var i = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act;
          n.data;
          return (0, o.createComponentVNode)(2, a.Section, {
            title: "Step 1",
            minHeight: "306px",
            children: [
              (0, o.createComponentVNode)(2, a.Box, {
                mt: 5,
                bold: !0,
                textAlign: "center",
                fontSize: "40px",
                children: "Choose your Device",
              }),
              (0, o.createComponentVNode)(2, a.Box, {
                mt: 3,
                children: (0, o.createComponentVNode)(2, a.Grid, {
                  width: "100%",
                  children: [
                    (0, o.createComponentVNode)(2, a.Grid.Column, {
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        fluid: !0,
                        icon: "laptop",
                        content: "Laptop",
                        textAlign: "center",
                        fontSize: "30px",
                        lineHeight: "50px",
                        onClick: function () {
                          return c("pick_device", { pick: "1" });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.Grid.Column, {
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        fluid: !0,
                        icon: "tablet-alt",
                        content: "Tablet",
                        textAlign: "center",
                        fontSize: "30px",
                        lineHeight: "50px",
                        onClick: function () {
                          return c("pick_device", { pick: "2" });
                        },
                      }),
                    }),
                  ],
                }),
              }),
            ],
          });
        },
        l = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data;
          return (0, o.createComponentVNode)(2, a.Section, {
            title: "Step 2: Customize your device",
            minHeight: "282px",
            buttons: (0, o.createComponentVNode)(2, a.Box, {
              bold: !0,
              color: "good",
              children: [i.totalprice, " cr"],
            }),
            children: [
              (0, o.createComponentVNode)(2, a.Table, {
                children: [
                  (0, o.createComponentVNode)(2, a.Table.Row, {
                    children: [
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        bold: !0,
                        position: "relative",
                        children: [
                          "Battery:",
                          (0, o.createComponentVNode)(2, a.Tooltip, {
                            content:
                              "Allows your device to operate without external utility power\nsource. Advanced batteries increase battery life.",
                            position: "right",
                          }),
                        ],
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "Standard",
                          selected: 1 === i.hw_battery,
                          onClick: function () {
                            return c("hw_battery", { battery: "1" });
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "Upgraded",
                          selected: 2 === i.hw_battery,
                          onClick: function () {
                            return c("hw_battery", { battery: "2" });
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "Advanced",
                          selected: 3 === i.hw_battery,
                          onClick: function () {
                            return c("hw_battery", { battery: "3" });
                          },
                        }),
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.Table.Row, {
                    children: [
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        bold: !0,
                        position: "relative",
                        children: [
                          "Hard Drive:",
                          (0, o.createComponentVNode)(2, a.Tooltip, {
                            content:
                              "Stores file on your device. Advanced drives can store more\nfiles, but use more power, shortening battery life.",
                            position: "right",
                          }),
                        ],
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "Standard",
                          selected: 1 === i.hw_disk,
                          onClick: function () {
                            return c("hw_disk", { disk: "1" });
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "Upgraded",
                          selected: 2 === i.hw_disk,
                          onClick: function () {
                            return c("hw_disk", { disk: "2" });
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "Advanced",
                          selected: 3 === i.hw_disk,
                          onClick: function () {
                            return c("hw_disk", { disk: "3" });
                          },
                        }),
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.Table.Row, {
                    children: [
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        bold: !0,
                        position: "relative",
                        children: [
                          "Network Card:",
                          (0, o.createComponentVNode)(2, a.Tooltip, {
                            content:
                              "Allows your device to wirelessly connect to stationwide NTNet\nnetwork. Basic cards are limited to on-station use, while\nadvanced cards can operate anywhere near the station, which\nincludes asteroid outposts",
                            position: "right",
                          }),
                        ],
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "None",
                          selected: 0 === i.hw_netcard,
                          onClick: function () {
                            return c("hw_netcard", { netcard: "0" });
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "Standard",
                          selected: 1 === i.hw_netcard,
                          onClick: function () {
                            return c("hw_netcard", { netcard: "1" });
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "Advanced",
                          selected: 2 === i.hw_netcard,
                          onClick: function () {
                            return c("hw_netcard", { netcard: "2" });
                          },
                        }),
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.Table.Row, {
                    children: [
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        bold: !0,
                        position: "relative",
                        children: [
                          "Nano Printer:",
                          (0, o.createComponentVNode)(2, a.Tooltip, {
                            content:
                              "A device that allows for various paperwork manipulations,\nsuch as, scanning of documents or printing new ones.\nThis device was certified EcoFriendlyPlus and is capable of\nrecycling existing paper for printing purposes.",
                            position: "right",
                          }),
                        ],
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "None",
                          selected: 0 === i.hw_nanoprint,
                          onClick: function () {
                            return c("hw_nanoprint", { print: "0" });
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "Standard",
                          selected: 1 === i.hw_nanoprint,
                          onClick: function () {
                            return c("hw_nanoprint", { print: "1" });
                          },
                        }),
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.Table.Row, {
                    children: [
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        bold: !0,
                        position: "relative",
                        children: [
                          "Card Reader:",
                          (0, o.createComponentVNode)(2, a.Tooltip, {
                            content:
                              "Adds a slot that allows you to manipulate RFID cards.\nPlease note that this is not necessary to allow the device\nto read your identification, it is just necessary to\nmanipulate other cards.",
                            position: "right",
                          }),
                        ],
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "None",
                          selected: 0 === i.hw_card,
                          onClick: function () {
                            return c("hw_card", { card: "0" });
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "Standard",
                          selected: 1 === i.hw_card,
                          onClick: function () {
                            return c("hw_card", { card: "1" });
                          },
                        }),
                      }),
                    ],
                  }),
                  2 !== i.devtype &&
                    (0, o.createFragment)(
                      [
                        (0, o.createComponentVNode)(2, a.Table.Row, {
                          children: [
                            (0, o.createComponentVNode)(2, a.Table.Cell, {
                              bold: !0,
                              position: "relative",
                              children: [
                                "Processor Unit:",
                                (0, o.createComponentVNode)(2, a.Tooltip, {
                                  content:
                                    "A component critical for your device's functionality.\nIt allows you to run programs from your hard drive.\nAdvanced CPUs use more power, but allow you to run\nmore programs on background at once.",
                                  position: "right",
                                }),
                              ],
                            }),
                            (0, o.createComponentVNode)(2, a.Table.Cell, {
                              children: (0, o.createComponentVNode)(
                                2,
                                a.Button,
                                {
                                  content: "Standard",
                                  selected: 1 === i.hw_cpu,
                                  onClick: function () {
                                    return c("hw_cpu", { cpu: "1" });
                                  },
                                }
                              ),
                            }),
                            (0, o.createComponentVNode)(2, a.Table.Cell, {
                              children: (0, o.createComponentVNode)(
                                2,
                                a.Button,
                                {
                                  content: "Advanced",
                                  selected: 2 === i.hw_cpu,
                                  onClick: function () {
                                    return c("hw_cpu", { cpu: "2" });
                                  },
                                }
                              ),
                            }),
                          ],
                        }),
                        (0, o.createComponentVNode)(2, a.Table.Row, {
                          children: [
                            (0, o.createComponentVNode)(2, a.Table.Cell, {
                              bold: !0,
                              position: "relative",
                              children: [
                                "Tesla Relay:",
                                (0, o.createComponentVNode)(2, a.Tooltip, {
                                  content:
                                    "An advanced wireless power relay that allows your device\nto connect to nearby area power controller to provide\nalternative power source. This component is currently\nunavailable on tablet computers due to size restrictions.",
                                  position: "right",
                                }),
                              ],
                            }),
                            (0, o.createComponentVNode)(2, a.Table.Cell, {
                              children: (0, o.createComponentVNode)(
                                2,
                                a.Button,
                                {
                                  content: "None",
                                  selected: 0 === i.hw_tesla,
                                  onClick: function () {
                                    return c("hw_tesla", { tesla: "0" });
                                  },
                                }
                              ),
                            }),
                            (0, o.createComponentVNode)(2, a.Table.Cell, {
                              children: (0, o.createComponentVNode)(
                                2,
                                a.Button,
                                {
                                  content: "Standard",
                                  selected: 1 === i.hw_tesla,
                                  onClick: function () {
                                    return c("hw_tesla", { tesla: "1" });
                                  },
                                }
                              ),
                            }),
                          ],
                        }),
                      ],
                      4
                    ),
                ],
              }),
              (0, o.createComponentVNode)(2, a.Button, {
                fluid: !0,
                mt: 3,
                content: "Confirm Order",
                color: "good",
                textAlign: "center",
                fontSize: "18px",
                lineHeight: "26px",
                onClick: function () {
                  return c("confirm_order");
                },
              }),
            ],
          });
        },
        d = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data;
          return (0, o.createComponentVNode)(2, a.Section, {
            title: "Step 3: Payment",
            minHeight: "282px",
            children: [
              (0, o.createComponentVNode)(2, a.Box, {
                italic: !0,
                textAlign: "center",
                fontSize: "20px",
                children: "Your device is ready for fabrication...",
              }),
              (0, o.createComponentVNode)(2, a.Box, {
                bold: !0,
                mt: 2,
                textAlign: "center",
                fontSize: "16px",
                children: [
                  (0, o.createComponentVNode)(2, a.Box, {
                    inline: !0,
                    children: "Please insert the required",
                  }),
                  " ",
                  (0, o.createComponentVNode)(2, a.Box, {
                    inline: !0,
                    color: "good",
                    children: [i.totalprice, " cr"],
                  }),
                ],
              }),
              (0, o.createComponentVNode)(2, a.Box, {
                bold: !0,
                mt: 1,
                textAlign: "center",
                fontSize: "18px",
                children: "Current:",
              }),
              (0, o.createComponentVNode)(2, a.Box, {
                bold: !0,
                mt: 0.5,
                textAlign: "center",
                fontSize: "18px",
                color: i.credits >= i.totalprice ? "good" : "bad",
                children: [i.credits, " cr"],
              }),
              (0, o.createComponentVNode)(2, a.Button, {
                fluid: !0,
                content: "Purchase",
                disabled: i.credits < i.totalprice,
                mt: 8,
                color: "good",
                textAlign: "center",
                fontSize: "20px",
                lineHeight: "28px",
                onClick: function () {
                  return c("purchase");
                },
              }),
            ],
          });
        },
        u = function (e, t) {
          return (0, o.createComponentVNode)(2, a.Section, {
            minHeight: "282px",
            children: [
              (0, o.createComponentVNode)(2, a.Box, {
                bold: !0,
                textAlign: "center",
                fontSize: "28px",
                mt: 10,
                children: "Thank you for your purchase!",
              }),
              (0, o.createComponentVNode)(2, a.Box, {
                italic: !0,
                mt: 1,
                textAlign: "center",
                children:
                  "If you experience any difficulties with your new device, please contact your local network administrator.",
              }),
            ],
          });
        };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Crayon = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.Crayon = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.has_cap || l.can_change_colour,
          u = l.drawables || [];
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 600,
          height: 600,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              !!d &&
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "Basic",
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList, {
                      children: (0, o.createComponentVNode)(
                        2,
                        a.LabeledList.Item,
                        {
                          label: "Cap",
                          children: (0, o.createComponentVNode)(2, a.Button, {
                            icon: l.is_capped ? "power-off" : "times",
                            content: l.is_capped ? "On" : "Off",
                            selected: l.is_capped,
                            onClick: function () {
                              return i("toggle_cap");
                            },
                          }),
                        }
                      ),
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      content: "Select New Color",
                      onClick: function () {
                        return i("select_colour");
                      },
                    }),
                  ],
                }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Stencil",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: u.map(function (e) {
                    var t = e.items || [];
                    return (0, o.createComponentVNode)(
                      2,
                      a.LabeledList.Item,
                      {
                        label: e.name,
                        children: t.map(function (e) {
                          return (0, o.createComponentVNode)(
                            2,
                            a.Button,
                            {
                              content: e.item,
                              selected: e.item === l.selected_stencil,
                              onClick: function () {
                                return i("select_stencil", { item: e.item });
                              },
                            },
                            e.item
                          );
                        }),
                      },
                      e.name
                    );
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Text",
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList, {
                    children: (0, o.createComponentVNode)(
                      2,
                      a.LabeledList.Item,
                      { label: "Current Buffer", children: l.text_buffer }
                    ),
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    content: "New Text",
                    onClick: function () {
                      return i("enter_text");
                    },
                  }),
                ],
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.CrewConsole = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(44),
        i = n(3),
        l = ["#17d568", "#2ecc71", "#e67e22", "#ed5100", "#e74c3c", "#ed2814"],
        d = function (e) {
          return 0 === e
            ? c.COLORS.department.captain
            : e >= 10 && e < 20
            ? c.COLORS.department.security
            : e >= 20 && e < 30
            ? c.COLORS.department.medbay
            : e >= 30 && e < 40
            ? c.COLORS.department.science
            : e >= 40 && e < 50
            ? c.COLORS.department.engineering
            : e >= 50 && e < 60
            ? c.COLORS.department.cargo
            : e >= 200 && e < 230
            ? c.COLORS.department.centcom
            : c.COLORS.department.other;
        },
        u = function (e) {
          var t = e.type,
            n = e.value;
          return (0, o.createComponentVNode)(2, a.Box, {
            inline: !0,
            width: 2,
            color: c.COLORS.damageType[t],
            textAlign: "center",
            children: n,
          });
        };
      t.CrewConsole = function () {
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 800,
          height: 600,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.Section, {
              minHeight: "540px",
              children: (0, o.createComponentVNode)(2, s),
            }),
          }),
        });
      };
      var s = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          s = i.sensors || [];
        return (0, o.createComponentVNode)(2, a.Table, {
          children: [
            (0, o.createComponentVNode)(2, a.Table.Row, {
              children: [
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  bold: !0,
                  children: "Name",
                }),
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  bold: !0,
                  collapsing: !0,
                }),
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  bold: !0,
                  collapsing: !0,
                  textAlign: "center",
                  children: "Vitals",
                }),
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  bold: !0,
                  children: "Position",
                }),
                !!i.link_allowed &&
                  (0, o.createComponentVNode)(2, a.Table.Cell, {
                    bold: !0,
                    collapsing: !0,
                    children: "Tracking",
                  }),
              ],
            }),
            s.map(function (e) {
              return (0, o.createComponentVNode)(
                2,
                a.Table.Row,
                {
                  children: [
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      bold: ((C = e.ijob), C % 10 == 0),
                      color: d(e.ijob),
                      children: [e.name, " (", e.assignment, ")"],
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      collapsing: !0,
                      textAlign: "center",
                      children: (0, o.createComponentVNode)(2, a.ColorBox, {
                        color:
                          ((t = e.oxydam),
                          (n = e.toxdam),
                          (r = e.burndam),
                          (s = e.brutedam),
                          (m = t + n + r + s),
                          (p = Math.min(Math.max(Math.ceil(m / 25), 0), 5)),
                          l[p]),
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      collapsing: !0,
                      textAlign: "center",
                      children:
                        null !== e.oxydam
                          ? (0, o.createComponentVNode)(2, a.Box, {
                              inline: !0,
                              children: [
                                (0, o.createComponentVNode)(2, u, {
                                  type: "oxy",
                                  value: e.oxydam,
                                }),
                                "/",
                                (0, o.createComponentVNode)(2, u, {
                                  type: "toxin",
                                  value: e.toxdam,
                                }),
                                "/",
                                (0, o.createComponentVNode)(2, u, {
                                  type: "burn",
                                  value: e.burndam,
                                }),
                                "/",
                                (0, o.createComponentVNode)(2, u, {
                                  type: "brute",
                                  value: e.brutedam,
                                }),
                              ],
                            })
                          : e.life_status
                          ? "Alive"
                          : "Dead",
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      children: null !== e.pos_x ? e.area : "N/A",
                    }),
                    !!i.link_allowed &&
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        collapsing: !0,
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          content: "Track",
                          disabled: !e.can_track,
                          onClick: function () {
                            return c("select_person", { name: e.name });
                          },
                        }),
                      }),
                  ],
                },
                e.name
              );
              var t, n, r, s, m, p, C;
            }),
          ],
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Cryo = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(144),
        i = n(3),
        l = [
          { label: "Brute", type: "bruteLoss" },
          { label: "Respiratory", type: "oxyLoss" },
          { label: "Toxin", type: "toxLoss" },
          { label: "Burn", type: "fireLoss" },
        ];
      t.Cryo = function () {
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 400,
          height: 550,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, d),
          }),
        });
      };
      var d = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          d = n.data;
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, a.Section, {
              title: "Occupant",
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Occupant",
                    children: d.occupant.name || "No Occupant",
                  }),
                  !!d.hasOccupant &&
                    (0, o.createFragment)(
                      [
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "State",
                          color: d.occupant.statstate,
                          children: d.occupant.stat,
                        }),
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Temperature",
                          color: d.occupant.temperaturestatus,
                          children: [
                            (0, o.createComponentVNode)(2, a.AnimatedNumber, {
                              value: d.occupant.bodyTemperature,
                            }),
                            " K",
                          ],
                        }),
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Health",
                          children: (0, o.createComponentVNode)(
                            2,
                            a.ProgressBar,
                            {
                              value: d.occupant.health / d.occupant.maxHealth,
                              color: d.occupant.health > 0 ? "good" : "average",
                              children: (0, o.createComponentVNode)(
                                2,
                                a.AnimatedNumber,
                                { value: d.occupant.health }
                              ),
                            }
                          ),
                        }),
                        l.map(function (e) {
                          return (0,
                          o.createComponentVNode)(2, a.LabeledList.Item, { label: e.label, children: (0, o.createComponentVNode)(2, a.ProgressBar, { value: d.occupant[e.type] / 100, children: (0, o.createComponentVNode)(2, a.AnimatedNumber, { value: d.occupant[e.type] }) }) }, e.id);
                        }),
                      ],
                      0
                    ),
                ],
              }),
            }),
            (0, o.createComponentVNode)(2, a.Section, {
              title: "Cell",
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Power",
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      icon: d.isOperating ? "power-off" : "times",
                      disabled: d.isOpen,
                      onClick: function () {
                        return i("power");
                      },
                      color: d.isOperating && "green",
                      children: d.isOperating ? "On" : "Off",
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Temperature",
                    children: [
                      (0, o.createComponentVNode)(2, a.AnimatedNumber, {
                        value: d.cellTemperature,
                      }),
                      " K",
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Door",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        icon: d.isOpen ? "unlock" : "lock",
                        onClick: function () {
                          return i("door");
                        },
                        content: d.isOpen ? "Open" : "Closed",
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        icon: d.autoEject ? "sign-out-alt" : "sign-in-alt",
                        onClick: function () {
                          return i("autoeject");
                        },
                        content: d.autoEject ? "Auto" : "Manual",
                      }),
                    ],
                  }),
                ],
              }),
            }),
            (0, o.createComponentVNode)(2, a.Section, {
              title: "Beaker",
              buttons: (0, o.createComponentVNode)(2, a.Button, {
                icon: "eject",
                disabled: !d.isBeakerLoaded,
                onClick: function () {
                  return i("ejectbeaker");
                },
                content: "Eject",
              }),
              children: (0, o.createComponentVNode)(2, c.BeakerContents, {
                beakerLoaded: d.isBeakerLoaded,
                beakerContents: d.beakerContents,
              }),
            }),
          ],
          4
        );
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.DecalPainter = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.DecalPainter = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.decal_list || [],
          u = l.color_list || [],
          s = l.dir_list || [];
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 400,
          height: 400,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Decal Type",
                children: d.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    a.Button,
                    {
                      content: e.name,
                      selected: e.decal === l.decal_style,
                      onClick: function () {
                        return i("select decal", { decals: e.decal });
                      },
                    },
                    e.decal
                  );
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Decal Color",
                children: u.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    a.Button,
                    {
                      content:
                        "red" === e.colors
                          ? "Red"
                          : "white" === e.colors
                          ? "White"
                          : "Yellow",
                      selected: e.colors === l.decal_color,
                      onClick: function () {
                        return i("select color", { colors: e.colors });
                      },
                    },
                    e.colors
                  );
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Decal Direction",
                children: s.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    a.Button,
                    {
                      content:
                        1 === e.dirs
                          ? "North"
                          : 2 === e.dirs
                          ? "South"
                          : 4 === e.dirs
                          ? "East"
                          : "West",
                      selected: e.dirs === l.decal_direction,
                      onClick: function () {
                        return i("selected direction", { dirs: e.dirs });
                      },
                    },
                    e.dirs
                  );
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.DisposalUnit = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.DisposalUnit = function (e, t) {
        var n,
          i,
          l = (0, r.useBackend)(t),
          d = l.act,
          u = l.data;
        return (
          u.full_pressure
            ? ((n = "good"), (i = "Ready"))
            : u.panel_open
            ? ((n = "bad"), (i = "Power Disabled"))
            : u.pressure_charging
            ? ((n = "average"), (i = "Pressurizing"))
            : ((n = "bad"), (i = "Off")),
          (0, o.createComponentVNode)(2, c.Window, {
            width: 300,
            height: 180,
            children: (0, o.createComponentVNode)(2, c.Window.Content, {
              children: (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "State",
                      color: n,
                      children: i,
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Pressure",
                      children: (0, o.createComponentVNode)(2, a.ProgressBar, {
                        value: u.per,
                        color: "good",
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Handle",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: u.flush ? "toggle-on" : "toggle-off",
                        disabled: u.isai || u.panel_open,
                        content: u.flush ? "Disengage" : "Engage",
                        onClick: function () {
                          return d(u.flush ? "handle-0" : "handle-1");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Eject",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: "sign-out-alt",
                        disabled: u.isai,
                        content: "Eject Contents",
                        onClick: function () {
                          return d("eject");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Power",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: "power-off",
                        disabled: u.panel_open,
                        selected: u.pressure_charging,
                        onClick: function () {
                          return d(u.pressure_charging ? "pump-0" : "pump-1");
                        },
                      }),
                    }),
                  ],
                }),
              }),
            }),
          })
        );
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.DnaVault = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.DnaVault = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.completed,
          u = l.used,
          s = l.choiceA,
          m = l.choiceB,
          p = l.dna,
          C = l.dna_max,
          h = l.plants,
          N = l.plants_max,
          V = l.animals,
          b = l.animals_max;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 350,
          height: 400,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "DNA Vault Database",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Human DNA",
                      children: (0, o.createComponentVNode)(2, a.ProgressBar, {
                        value: p / C,
                        children: p + " / " + C + " Samples",
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Plant DNA",
                      children: (0, o.createComponentVNode)(2, a.ProgressBar, {
                        value: h / N,
                        children: h + " / " + N + " Samples",
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Animal DNA",
                      children: (0, o.createComponentVNode)(2, a.ProgressBar, {
                        value: V / V,
                        children: V + " / " + b + " Samples",
                      }),
                    }),
                  ],
                }),
              }),
              !(!d || u) &&
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "Personal Gene Therapy",
                  children: [
                    (0, o.createComponentVNode)(2, a.Box, {
                      bold: !0,
                      textAlign: "center",
                      mb: 1,
                      children: "Applicable Gene Therapy Treatments",
                    }),
                    (0, o.createComponentVNode)(2, a.Grid, {
                      children: [
                        (0, o.createComponentVNode)(2, a.Grid.Column, {
                          children: (0, o.createComponentVNode)(2, a.Button, {
                            fluid: !0,
                            bold: !0,
                            content: s,
                            textAlign: "center",
                            onClick: function () {
                              return i("gene", { choice: s });
                            },
                          }),
                        }),
                        (0, o.createComponentVNode)(2, a.Grid.Column, {
                          children: (0, o.createComponentVNode)(2, a.Button, {
                            fluid: !0,
                            bold: !0,
                            content: m,
                            textAlign: "center",
                            onClick: function () {
                              return i("gene", { choice: m });
                            },
                          }),
                        }),
                      ],
                    }),
                  ],
                }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.EightBallVote = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(19),
        i = n(3);
      t.EightBallVote = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = (n.act, n.data.shaking);
        return (0, o.createComponentVNode)(2, i.Window, {
          width: 400,
          height: 600,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children:
              (!c &&
                (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children: "No question is currently being asked.",
                })) ||
              (0, o.createComponentVNode)(2, l),
          }),
        });
      };
      var l = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.question,
          u = l.answers,
          s = void 0 === u ? [] : u;
        return (0, o.createComponentVNode)(2, a.Section, {
          children: [
            (0, o.createComponentVNode)(2, a.Box, {
              bold: !0,
              textAlign: "center",
              fontSize: "16px",
              m: 1,
              children: ['"', d, '"'],
            }),
            (0, o.createComponentVNode)(2, a.Grid, {
              children: s.map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  a.Grid.Column,
                  {
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        fluid: !0,
                        bold: !0,
                        content: (0, c.toTitleCase)(e.answer),
                        selected: e.selected,
                        fontSize: "16px",
                        lineHeight: "24px",
                        textAlign: "center",
                        mb: 1,
                        onClick: function () {
                          return i("vote", { answer: e.answer });
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Box, {
                        bold: !0,
                        textAlign: "center",
                        fontSize: "30px",
                        children: e.amount,
                      }),
                    ],
                  },
                  e.answer
                );
              }),
            }),
          ],
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Electropack = void 0);
      var o = n(0),
        r = n(8),
        a = n(2),
        c = n(1),
        i = n(3);
      t.Electropack = function (e, t) {
        var n = (0, a.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.power,
          s = d.code,
          m = d.frequency,
          p = d.minFrequency,
          C = d.maxFrequency;
        return (0, o.createComponentVNode)(2, i.Window, {
          width: 260,
          height: 137,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: (0, o.createComponentVNode)(2, c.Section, {
              children: (0, o.createComponentVNode)(2, c.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                    label: "Power",
                    children: (0, o.createComponentVNode)(2, c.Button, {
                      icon: u ? "power-off" : "times",
                      content: u ? "On" : "Off",
                      selected: u,
                      onClick: function () {
                        return l("power");
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                    label: "Frequency",
                    buttons: (0, o.createComponentVNode)(2, c.Button, {
                      icon: "sync",
                      content: "Reset",
                      onClick: function () {
                        return l("reset", { reset: "freq" });
                      },
                    }),
                    children: (0, o.createComponentVNode)(2, c.NumberInput, {
                      animate: !0,
                      unit: "kHz",
                      step: 0.2,
                      stepPixelSize: 6,
                      minValue: p / 10,
                      maxValue: C / 10,
                      value: m / 10,
                      format: function (e) {
                        return (0, r.toFixed)(e, 1);
                      },
                      width: "80px",
                      onDrag: function (e, t) {
                        return l("freq", { freq: t });
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                    label: "Code",
                    buttons: (0, o.createComponentVNode)(2, c.Button, {
                      icon: "sync",
                      content: "Reset",
                      onClick: function () {
                        return l("reset", { reset: "code" });
                      },
                    }),
                    children: (0, o.createComponentVNode)(2, c.NumberInput, {
                      animate: !0,
                      step: 1,
                      stepPixelSize: 6,
                      minValue: 1,
                      maxValue: 100,
                      value: s,
                      width: "80px",
                      onDrag: function (e, t) {
                        return l("code", { code: t });
                      },
                    }),
                  }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.EmergencyShuttleConsole = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.EmergencyShuttleConsole = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.timer_str,
          u = l.enabled,
          s = l.emagged,
          m = l.engines_started,
          p = l.authorizations_remaining,
          C = l.authorizations,
          h = void 0 === C ? [] : C;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 400,
          height: 350,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: [
                (0, o.createComponentVNode)(2, a.Box, {
                  bold: !0,
                  fontSize: "40px",
                  textAlign: "center",
                  fontFamily: "monospace",
                  children: d,
                }),
                (0, o.createComponentVNode)(2, a.Box, {
                  textAlign: "center",
                  fontSize: "16px",
                  mb: 1,
                  children: [
                    (0, o.createComponentVNode)(2, a.Box, {
                      inline: !0,
                      bold: !0,
                      children: "ENGINES:",
                    }),
                    (0, o.createComponentVNode)(2, a.Box, {
                      inline: !0,
                      color: m ? "good" : "average",
                      ml: 1,
                      children: m ? "Online" : "Idle",
                    }),
                  ],
                }),
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "Early Launch Authorization",
                  level: 2,
                  buttons: (0, o.createComponentVNode)(2, a.Button, {
                    icon: "times",
                    content: "Repeal All",
                    color: "bad",
                    disabled: !u,
                    onClick: function () {
                      return i("abort");
                    },
                  }),
                  children: [
                    (0, o.createComponentVNode)(2, a.Grid, {
                      children: [
                        (0, o.createComponentVNode)(2, a.Grid.Column, {
                          children: (0, o.createComponentVNode)(2, a.Button, {
                            fluid: !0,
                            icon: "exclamation-triangle",
                            color: "good",
                            content: "AUTHORIZE",
                            disabled: !u,
                            onClick: function () {
                              return i("authorize");
                            },
                          }),
                        }),
                        (0, o.createComponentVNode)(2, a.Grid.Column, {
                          children: (0, o.createComponentVNode)(2, a.Button, {
                            fluid: !0,
                            icon: "minus",
                            content: "REPEAL",
                            disabled: !u,
                            onClick: function () {
                              return i("repeal");
                            },
                          }),
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.Section, {
                      title: "Authorizations",
                      level: 3,
                      minHeight: "150px",
                      buttons: (0, o.createComponentVNode)(2, a.Box, {
                        inline: !0,
                        bold: !0,
                        color: s ? "bad" : "good",
                        children: s ? "ERROR" : "Remaining: " + p,
                      }),
                      children:
                        h.length > 0
                          ? h.map(function (e) {
                              return (0,
                              o.createComponentVNode)(2, a.Box, { bold: !0, fontSize: "16px", className: "candystripe", children: [e.name, " (", e.job, ")"] }, e.name);
                            })
                          : (0, o.createComponentVNode)(2, a.Box, {
                              bold: !0,
                              textAlign: "center",
                              fontSize: "16px",
                              color: "average",
                              children: "No Active Authorizations",
                            }),
                    }),
                  ],
                }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.EngravedMessage = void 0);
      var o = n(0),
        r = n(19),
        a = n(2),
        c = n(1),
        i = n(3);
      t.EngravedMessage = function (e, t) {
        var n = (0, a.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.admin_mode,
          s = d.creator_key,
          m = d.creator_name,
          p = d.has_liked,
          C = d.has_disliked,
          h = d.hidden_message,
          N = d.is_creator,
          V = d.num_likes,
          b = d.num_dislikes,
          f = d.realdate;
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 600,
          height: 300,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, c.Section, {
                children: [
                  (0, o.createComponentVNode)(2, c.Box, {
                    bold: !0,
                    textAlign: "center",
                    fontSize: "20px",
                    mb: 2,
                    children: (0, r.decodeHtmlEntities)(h),
                  }),
                  (0, o.createComponentVNode)(2, c.Grid, {
                    children: [
                      (0, o.createComponentVNode)(2, c.Grid.Column, {
                        children: (0, o.createComponentVNode)(2, c.Button, {
                          fluid: !0,
                          icon: "arrow-up",
                          content: " " + V,
                          disabled: N,
                          selected: p,
                          textAlign: "center",
                          fontSize: "16px",
                          lineHeight: "24px",
                          onClick: function () {
                            return l("like");
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, c.Grid.Column, {
                        children: (0, o.createComponentVNode)(2, c.Button, {
                          fluid: !0,
                          icon: "circle",
                          disabled: N,
                          selected: !C && !p,
                          textAlign: "center",
                          fontSize: "16px",
                          lineHeight: "24px",
                          onClick: function () {
                            return l("neutral");
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, c.Grid.Column, {
                        children: (0, o.createComponentVNode)(2, c.Button, {
                          fluid: !0,
                          icon: "arrow-down",
                          content: " " + b,
                          disabled: N,
                          selected: C,
                          textAlign: "center",
                          fontSize: "16px",
                          lineHeight: "24px",
                          onClick: function () {
                            return l("dislike");
                          },
                        }),
                      }),
                    ],
                  }),
                ],
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                children: (0, o.createComponentVNode)(2, c.LabeledList, {
                  children: (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                    label: "Created On",
                    children: f,
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, c.Section),
              !!u &&
                (0, o.createComponentVNode)(2, c.Section, {
                  title: "Admin Panel",
                  buttons: (0, o.createComponentVNode)(2, c.Button, {
                    icon: "times",
                    content: "Delete",
                    color: "bad",
                    onClick: function () {
                      return l("delete");
                    },
                  }),
                  children: (0, o.createComponentVNode)(2, c.LabeledList, {
                    children: [
                      (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                        label: "Creator Ckey",
                        children: s,
                      }),
                      (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                        label: "Creator Character Name",
                        children: m,
                      }),
                    ],
                  }),
                }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ExosuitControlConsole = void 0);
      var o = n(0),
        r = n(8),
        a = n(2),
        c = n(1),
        i = n(3);
      t.ExosuitControlConsole = function (e, t) {
        var n = (0, a.useBackend)(t),
          l = n.act,
          d = n.data.mechs,
          u = void 0 === d ? [] : d;
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 500,
          height: 500,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: [
              0 === u.length &&
                (0, o.createComponentVNode)(2, c.NoticeBox, {
                  children: "No exosuits detected",
                }),
              u.map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  c.Section,
                  {
                    title: e.name,
                    buttons: (0, o.createFragment)(
                      [
                        (0, o.createComponentVNode)(2, c.Button, {
                          icon: "envelope",
                          content: "Send Message",
                          disabled: !e.pilot,
                          onClick: function () {
                            return l("send_message", {
                              tracker_ref: e.tracker_ref,
                            });
                          },
                        }),
                        (0, o.createComponentVNode)(2, c.Button, {
                          icon: "wifi",
                          content: e.emp_recharging
                            ? "Recharging..."
                            : "EMP Burst",
                          color: "bad",
                          disabled: e.emp_recharging,
                          onClick: function () {
                            return l("shock", { tracker_ref: e.tracker_ref });
                          },
                        }),
                      ],
                      4
                    ),
                    children: (0, o.createComponentVNode)(2, c.LabeledList, {
                      children: [
                        (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                          label: "Integrity",
                          children: (0, o.createComponentVNode)(2, c.Box, {
                            color:
                              (e.integrity <= 30
                                ? "bad"
                                : e.integrity <= 70 && "average") || "good",
                            children: [e.integrity, "%"],
                          }),
                        }),
                        (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                          label: "Charge",
                          children: (0, o.createComponentVNode)(2, c.Box, {
                            color:
                              (e.charge <= 30
                                ? "bad"
                                : e.charge <= 70 && "average") || "good",
                            children:
                              ("number" == typeof e.charge && e.charge + "%") ||
                              "Not Found",
                          }),
                        }),
                        (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                          label: "Airtank",
                          children:
                            ("number" == typeof e.airtank &&
                              (0, o.createComponentVNode)(2, c.AnimatedNumber, {
                                value: e.airtank,
                                format: function (e) {
                                  return (0, r.toFixed)(e, 2) + " kPa";
                                },
                              })) ||
                            "Not Equipped",
                        }),
                        (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                          label: "Pilot",
                          children: e.pilot || "None",
                        }),
                        (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                          label: "Location",
                          children: e.location || "Unknown",
                        }),
                        (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                          label: "Active Equipment",
                          children: e.active_equipment || "None",
                        }),
                        e.cargo_space >= 0 &&
                          (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                            label: "Used Cargo Space",
                            children: (0, o.createComponentVNode)(2, c.Box, {
                              color:
                                (e.cargo_space <= 30
                                  ? "good"
                                  : e.cargo_space <= 70 && "average") || "bad",
                              children: [e.cargo_space, "%"],
                            }),
                          }),
                      ],
                    }),
                  },
                  e.tracker_ref
                );
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ForbiddenLore = void 0);
      var o = n(0),
        r = n(2),
        a = n(50),
        c = n(21),
        i = n(1),
        l = n(3);
      t.ForbiddenLore = function (e, t) {
        var n = (0, r.useBackend)(t),
          d = n.act,
          u = n.data,
          s = u.charges,
          m =
            (u.to_know,
            (0, a.flow)([
              (0, c.sortBy)(
                function (e) {
                  return "Research" !== e.state;
                },
                function (e) {
                  return "Side" === e.path;
                }
              ),
            ])(u.to_know || []));
        return (0, o.createComponentVNode)(2, l.Window, {
          resizable: !0,
          width: 500,
          height: 900,
          children: (0, o.createComponentVNode)(2, l.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, i.Section, {
              title: "Research Eldritch Knowledge",
              children: [
                "Charges left : ",
                s,
                null !== m
                  ? m.map(function (e) {
                      return (0, o.createComponentVNode)(
                        2,
                        i.Section,
                        {
                          title: e.name,
                          level: 2,
                          children: [
                            (0, o.createComponentVNode)(2, i.Box, {
                              bold: !0,
                              mb: 1,
                              mt: 1,
                              children: [e.path, " path"],
                            }),
                            (0, o.createComponentVNode)(2, i.Box, {
                              mb: 1,
                              mt: 1,
                              children: [
                                (0, o.createComponentVNode)(2, i.Button, {
                                  content: e.state,
                                  disabled: e.disabled,
                                  onClick: function () {
                                    return d("research", {
                                      name: e.name,
                                      cost: e.cost,
                                    });
                                  },
                                }),
                                " ",
                                "Cost : ",
                                e.cost,
                              ],
                            }),
                            (0, o.createComponentVNode)(2, i.Box, {
                              italic: !0,
                              mb: 1,
                              mt: 1,
                              children: e.flavour,
                            }),
                            (0, o.createComponentVNode)(2, i.Box, {
                              mb: 1,
                              mt: 1,
                              children: e.desc,
                            }),
                          ],
                        },
                        e.name
                      );
                    })
                  : (0, o.createComponentVNode)(2, i.Box, {
                      children: "No more knowledge can be found",
                    }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Gps = void 0);
      var o = n(0),
        r = n(21),
        a = n(50),
        c = n(8),
        i = n(102),
        l = n(2),
        d = n(1),
        u = n(3),
        s = function (e) {
          return (0, r.map)(parseFloat)(e.split(", "));
        };
      t.Gps = function (e, t) {
        var n = (0, l.useBackend)(t),
          m = n.act,
          p = n.data,
          C = p.currentArea,
          h = p.currentCoords,
          N = p.globalmode,
          V = p.power,
          b = p.tag,
          f = p.updating,
          g = (0, a.flow)([
            (0, r.map)(function (e, t) {
              var n =
                e.dist &&
                Math.round(
                  (0, i.vecLength)((0, i.vecSubtract)(s(h), s(e.coords)))
                );
              return Object.assign({}, e, { dist: n, index: t });
            }),
            (0, r.sortBy)(
              function (e) {
                return e.dist === undefined;
              },
              function (e) {
                return e.entrytag;
              }
            ),
          ])(p.signals || []);
        return (0, o.createComponentVNode)(2, u.Window, {
          resizable: !0,
          width: 470,
          height: (0, c.clamp)(325 + 14 * g.length, 325, 700),
          children: (0, o.createComponentVNode)(2, u.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, d.Section, {
                title: "Control",
                buttons: (0, o.createComponentVNode)(2, d.Button, {
                  icon: "power-off",
                  content: V ? "On" : "Off",
                  selected: V,
                  onClick: function () {
                    return m("power");
                  },
                }),
                children: (0, o.createComponentVNode)(2, d.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, d.LabeledList.Item, {
                      label: "Tag",
                      children: (0, o.createComponentVNode)(2, d.Button, {
                        icon: "pencil-alt",
                        content: b,
                        onClick: function () {
                          return m("rename");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, d.LabeledList.Item, {
                      label: "Scan Mode",
                      children: (0, o.createComponentVNode)(2, d.Button, {
                        icon: f ? "unlock" : "lock",
                        content: f ? "AUTO" : "MANUAL",
                        color: !f && "bad",
                        onClick: function () {
                          return m("updating");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, d.LabeledList.Item, {
                      label: "Range",
                      children: (0, o.createComponentVNode)(2, d.Button, {
                        icon: "sync",
                        content: N ? "MAXIMUM" : "LOCAL",
                        selected: !N,
                        onClick: function () {
                          return m("globalmode");
                        },
                      }),
                    }),
                  ],
                }),
              }),
              !!V &&
                (0, o.createFragment)(
                  [
                    (0, o.createComponentVNode)(2, d.Section, {
                      title: "Current Location",
                      children: (0, o.createComponentVNode)(2, d.Box, {
                        fontSize: "18px",
                        children: [C, " (", h, ")"],
                      }),
                    }),
                    (0, o.createComponentVNode)(2, d.Section, {
                      title: "Detected Signals",
                      children: (0, o.createComponentVNode)(2, d.Table, {
                        children: [
                          (0, o.createComponentVNode)(2, d.Table.Row, {
                            bold: !0,
                            children: [
                              (0, o.createComponentVNode)(2, d.Table.Cell, {
                                content: "Name",
                              }),
                              (0, o.createComponentVNode)(2, d.Table.Cell, {
                                collapsing: !0,
                                content: "Direction",
                              }),
                              (0, o.createComponentVNode)(2, d.Table.Cell, {
                                collapsing: !0,
                                content: "Coordinates",
                              }),
                            ],
                          }),
                          g.map(function (e) {
                            return (0,
                            o.createComponentVNode)(2, d.Table.Row, { className: "candystripe", children: [(0, o.createComponentVNode)(2, d.Table.Cell, { bold: !0, color: "label", children: e.entrytag }), (0, o.createComponentVNode)(2, d.Table.Cell, { collapsing: !0, opacity: e.dist !== undefined && (0, c.clamp)(1.2 / Math.log(Math.E + e.dist / 20), 0.4, 1), children: [e.degrees !== undefined && (0, o.createComponentVNode)(2, d.Icon, { mr: 1, size: 1.2, name: "arrow-up", rotation: e.degrees }), e.dist !== undefined && e.dist + "m"] }), (0, o.createComponentVNode)(2, d.Table.Cell, { collapsing: !0, children: e.coords })] }, e.entrytag + e.coords + e.index);
                          }),
                        ],
                      }),
                    }),
                  ],
                  4
                ),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.GravityGenerator = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.GravityGenerator = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = (n.act, n.data),
          d = l.charging_state,
          u = l.operational;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 400,
          height: 600,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              !u &&
                (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children: "No data available",
                }),
              !!u &&
                0 !== d &&
                (0, o.createComponentVNode)(2, a.NoticeBox, {
                  danger: !0,
                  children: "WARNING - Radiation detected",
                }),
              !!u &&
                0 === d &&
                (0, o.createComponentVNode)(2, a.NoticeBox, {
                  success: !0,
                  children: "No radiation detected",
                }),
              !!u && (0, o.createComponentVNode)(2, i),
            ],
          }),
        });
      };
      var i = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          l = i.breaker,
          d = i.charge_count,
          u = i.charging_state,
          s = i.on,
          m = i.operational;
        return (0, o.createComponentVNode)(2, a.Section, {
          children: (0, o.createComponentVNode)(2, a.LabeledList, {
            children: [
              (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                label: "Power",
                children: (0, o.createComponentVNode)(2, a.Button, {
                  icon: l ? "power-off" : "times",
                  content: l ? "On" : "Off",
                  selected: l,
                  disabled: !m,
                  onClick: function () {
                    return c("gentoggle");
                  },
                }),
              }),
              (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                label: "Gravity Charge",
                children: (0, o.createComponentVNode)(2, a.ProgressBar, {
                  value: d / 100,
                  ranges: {
                    good: [0.7, Infinity],
                    average: [0.3, 0.7],
                    bad: [-Infinity, 0.3],
                  },
                }),
              }),
              (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                label: "Charge Mode",
                children: [
                  0 === u &&
                    ((s &&
                      (0, o.createComponentVNode)(2, a.Box, {
                        color: "good",
                        children: "Fully Charged",
                      })) ||
                      (0, o.createComponentVNode)(2, a.Box, {
                        color: "bad",
                        children: "Not Charging",
                      })),
                  1 === u &&
                    (0, o.createComponentVNode)(2, a.Box, {
                      color: "average",
                      children: "Charging",
                    }),
                  2 === u &&
                    (0, o.createComponentVNode)(2, a.Box, {
                      color: "average",
                      children: "Discharging",
                    }),
                ],
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Guardian = void 0);
      var o = n(0),
        r = n(3),
        a = n(2),
        c = n(1);
      t.Guardian = function (e, t) {
        var n = (0, a.useBackend)(t),
          m = (n.act, n.data),
          p = (0, a.useLocalState)(t, "tab", "general"),
          C = p[0],
          h = p[1];
        return (0, o.createComponentVNode)(2, r.Window, {
          width: 500,
          height: 600,
          children: (0, o.createComponentVNode)(2, r.Window.Content, {
            scrollable: !0,
            children: [
              !!m.waiting &&
                (0, o.createComponentVNode)(2, c.Dimmer, {
                  fontSize: "32px",
                  children: (0, o.createComponentVNode)(2, c.Icon, {
                    name: "spinner",
                    spin: 1,
                  }),
                }),
              (0, o.createComponentVNode)(2, c.Section, {
                children: (0, o.createComponentVNode)(2, c.LabeledList, {
                  children: (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                    label: "Points",
                    color: m.points > 0 ? "good" : "bad",
                    children: m.points,
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, c.Tabs, {
                children: [
                  (0, o.createComponentVNode)(2, c.Tabs.Tab, {
                    icon: "list",
                    selected: "general" === C,
                    onClick: function () {
                      return h("general");
                    },
                    children: "General",
                  }),
                  (0, o.createComponentVNode)(2, c.Tabs.Tab, {
                    icon: "fist-raised",
                    selected: "stats" === C,
                    onClick: function () {
                      return h("stats");
                    },
                    children: "Stats",
                  }),
                  (0, o.createComponentVNode)(2, c.Tabs.Tab, {
                    icon: "fire-alt",
                    selected: "major" === C,
                    onClick: function () {
                      return h("major");
                    },
                    children: "Primary Ability",
                  }),
                  (0, o.createComponentVNode)(2, c.Tabs.Tab, {
                    icon: "burn",
                    selected: "minor" === C,
                    onClick: function () {
                      return h("minor");
                    },
                    children: "Secondary Abilities",
                  }),
                  (0, o.createComponentVNode)(2, c.Tabs.Tab, {
                    icon: "plus-square",
                    selected: "create" === C,
                    onClick: function () {
                      return h("create");
                    },
                    children: "Create/Overview",
                  }),
                ],
              }),
              "general" === C && (0, o.createComponentVNode)(2, i),
              "stats" === C && (0, o.createComponentVNode)(2, l),
              "major" === C && (0, o.createComponentVNode)(2, d),
              "minor" === C && (0, o.createComponentVNode)(2, u),
              "create" === C && (0, o.createComponentVNode)(2, s),
            ],
          }),
        });
      };
      var i = function (e, t) {
          var n = (0, a.useBackend)(t),
            r = n.act,
            i = n.data;
          return (0, o.createComponentVNode)(2, c.Section, {
            children: (0, o.createComponentVNode)(2, c.LabeledList, {
              children: [
                (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                  label: "Name",
                  children: (0, o.createComponentVNode)(2, c.Input, {
                    value: i.guardian_name,
                    placeholder: i.name,
                    onChange: function (e, t) {
                      return r("name", { name: t });
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                  label: "Color",
                  children: (0, o.createComponentVNode)(2, c.ColorBox, {
                    color: i.guardian_color || "#FFFFFF",
                    mr: 1,
                    onClick: function () {
                      return r("color");
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                  children: (0, o.createComponentVNode)(2, c.Button, {
                    icon: "undo",
                    content: "Reset All",
                    onClick: function () {
                      return r("reset");
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                  label: "Attack Type",
                  children: [
                    (0, o.createComponentVNode)(2, c.Button, {
                      content: "Melee",
                      selected: i.melee,
                      onClick: function () {
                        return r("melee");
                      },
                    }),
                    (0, o.createComponentVNode)(2, c.Button, {
                      content: "Ranged",
                      selected: !i.melee,
                      disabled: i.melee && i.points < 3,
                      onClick: function () {
                        return r("ranged");
                      },
                    }),
                  ],
                }),
              ],
            }),
          });
        },
        l = function (e, t) {
          var n = (0, a.useBackend)(t),
            r = n.act,
            i = n.data;
          return (0, o.createComponentVNode)(2, c.Section, {
            children: (0, o.createComponentVNode)(2, c.LabeledList, {
              children: i.ratedskills.map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  c.LabeledList.Item,
                  {
                    className: "candystripe",
                    label: (0, o.createComponentVNode)(2, c.Box, {
                      position: "relative",
                      children: [
                        e.name,
                        (0, o.createComponentVNode)(2, c.Tooltip, {
                          content: e.desc,
                          position: "bottom-right",
                        }),
                      ],
                    }),
                    children: [
                      (0, o.createComponentVNode)(2, c.Button, {
                        content: "A",
                        selected: 5 === e.level,
                        disabled: e.level < 5 && i.points < 4,
                        onClick: function () {
                          return r("set", { name: e.name, level: 5 });
                        },
                      }),
                      (0, o.createComponentVNode)(2, c.Button, {
                        content: "B",
                        selected: 4 === e.level,
                        disabled: e.level < 4 && i.points < 3,
                        onClick: function () {
                          return r("set", { name: e.name, level: 4 });
                        },
                      }),
                      (0, o.createComponentVNode)(2, c.Button, {
                        content: "C",
                        selected: 3 === e.level,
                        disabled: e.level < 3 && i.points < 2,
                        onClick: function () {
                          return r("set", { name: e.name, level: 3 });
                        },
                      }),
                      (0, o.createComponentVNode)(2, c.Button, {
                        content: "D",
                        selected: 2 === e.level,
                        disabled: e.level < 2 && i.points < 1,
                        onClick: function () {
                          return r("set", { name: e.name, level: 2 });
                        },
                      }),
                      (0, o.createComponentVNode)(2, c.Button, {
                        content: "F",
                        selected: 1 === e.level,
                        onClick: function () {
                          return r("set", { name: e.name, level: 1 });
                        },
                      }),
                    ],
                  },
                  e.name
                );
              }),
            }),
          });
        },
        d = function (e, t) {
          var n = (0, a.useBackend)(t),
            r = n.act,
            i = n.data;
          return (0, o.createComponentVNode)(2, c.Section, {
            children: (0, o.createComponentVNode)(2, c.Flex.Item, {
              grow: 1,
              basis: 0,
              children: i.abilities_major.map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  c.Box,
                  {
                    className: "candystripe",
                    p: 1,
                    pb: 2,
                    children: [
                      (0, o.createComponentVNode)(2, c.Flex, {
                        spacing: 1,
                        align: "baseline",
                        children: [
                          (0, o.createComponentVNode)(2, c.Flex.Item, {
                            bold: !0,
                            grow: 1,
                            color: e.requiem ? "gold" : "label",
                            children: [
                              e.icon &&
                                (0, o.createComponentVNode)(2, c.Icon, {
                                  name: e.icon,
                                }),
                              " ",
                              e.name,
                            ],
                          }),
                          (0, o.createComponentVNode)(2, c.Flex.Item, {
                            children: (0, o.createComponentVNode)(2, c.Button, {
                              content: e.cost + " points",
                              selected: e.selected,
                              disabled:
                                !e.selected &&
                                (i.points < e.cost || !e.available),
                              onClick: function () {
                                return r("ability_major", { path: e.path });
                              },
                            }),
                          }),
                        ],
                      }),
                      e.desc,
                    ],
                  },
                  e.name
                );
              }),
            }),
          });
        },
        u = function (e, t) {
          var n = (0, a.useBackend)(t),
            r = n.act,
            i = n.data;
          return (0, o.createComponentVNode)(2, c.Section, {
            children: (0, o.createComponentVNode)(2, c.Flex.Item, {
              grow: 1,
              basis: 0,
              children: i.abilities_minor.map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  c.Box,
                  {
                    className: "candystripe",
                    p: 1,
                    pb: 2,
                    children: [
                      (0, o.createComponentVNode)(2, c.Flex, {
                        spacing: 1,
                        align: "baseline",
                        children: [
                          (0, o.createComponentVNode)(2, c.Flex.Item, {
                            bold: !0,
                            grow: 1,
                            color: "label",
                            children: [
                              e.icon &&
                                (0, o.createComponentVNode)(2, c.Icon, {
                                  name: e.icon,
                                }),
                              " ",
                              e.name,
                            ],
                          }),
                          (0, o.createComponentVNode)(2, c.Flex.Item, {
                            children: (0, o.createComponentVNode)(2, c.Button, {
                              content: e.cost + " points",
                              selected: e.selected,
                              disabled:
                                !e.selected &&
                                (i.points < e.cost || !e.available),
                              onClick: function () {
                                return r("ability_minor", { path: e.path });
                              },
                            }),
                          }),
                        ],
                      }),
                      e.desc,
                    ],
                  },
                  e.name
                );
              }),
            }),
          });
        },
        s = function (e, t) {
          var n = (0, a.useBackend)(t),
            r = n.act,
            i = n.data,
            l = { 1: "F", 2: "D", 3: "C", 4: "B", 5: "A" };
          return (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Appearance",
                children: (0, o.createComponentVNode)(2, c.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Name",
                      children: i.guardian_name || i.name,
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Color",
                      children: (0, o.createComponentVNode)(2, c.ColorBox, {
                        color: i.guardian_color || "#FFFFFF",
                        mr: 1,
                      }),
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Stats",
                children: (0, o.createComponentVNode)(2, c.LabeledList, {
                  children: i.ratedskills.map(function (e) {
                    return (0,
                    o.createComponentVNode)(2, c.LabeledList.Item, { className: "candystripe", label: e.name, children: l[e.level] }, e.name);
                  }),
                }),
              }),
              !i.no_ability &&
                (0, o.createComponentVNode)(2, c.Section, {
                  title: "Major Ability",
                  children: (0, o.createComponentVNode)(2, c.LabeledList, {
                    children: i.abilities_major.map(function (e) {
                      return (
                        !!e.selected &&
                        (0, o.createComponentVNode)(
                          2,
                          c.LabeledList.Item,
                          { label: e.name, children: e.desc },
                          e.name
                        )
                      );
                    }),
                  }),
                }),
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Minor Abilities",
                children: (0, o.createComponentVNode)(2, c.LabeledList, {
                  children: i.abilities_minor.map(function (e) {
                    return (
                      !!e.selected &&
                      (0, o.createComponentVNode)(
                        2,
                        c.LabeledList.Item,
                        {
                          className: "candystripe",
                          label: e.name,
                          children: e.desc,
                        },
                        e.name
                      )
                    );
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, c.Button, {
                content: "Summon " + i.name,
                style: {
                  width: "100%",
                  "text-align": "center",
                  position: "fixed",
                  bottom: "12px",
                },
                onClick: function () {
                  return r("spawn");
                },
              }),
            ],
            0
          );
        };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.GulagItemReclaimer = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.GulagItemReclaimer = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.mobs,
          u = void 0 === d ? [] : d;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 325,
          height: 400,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              0 === u.length &&
                (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children: "No stored items",
                }),
              u.length > 0 &&
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "Stored Items",
                  children: (0, o.createComponentVNode)(2, a.Table, {
                    children: u.map(function (e) {
                      return (0, o.createComponentVNode)(
                        2,
                        a.Table.Row,
                        {
                          children: [
                            (0, o.createComponentVNode)(2, a.Table.Cell, {
                              children: e.name,
                            }),
                            (0, o.createComponentVNode)(2, a.Table.Cell, {
                              textAlign: "right",
                              children: (0, o.createComponentVNode)(
                                2,
                                a.Button,
                                {
                                  content: "Retrieve Items",
                                  disabled: !l.can_reclaim,
                                  onClick: function () {
                                    return i("release_items", {
                                      mobref: e.mob,
                                    });
                                  },
                                }
                              ),
                            }),
                          ],
                        },
                        e.mob
                      );
                    }),
                  }),
                }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.GulagTeleporterConsole = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.GulagTeleporterConsole = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.teleporter,
          u = l.teleporter_lock,
          s = l.teleporter_state_open,
          m = l.teleporter_location,
          p = l.beacon,
          C = l.beacon_location,
          h = l.id,
          N = l.id_name,
          V = l.can_teleport,
          b = l.goal,
          f = void 0 === b ? 0 : b,
          g = l.prisoner,
          v = void 0 === g ? {} : g;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 350,
          height: 295,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Teleporter Console",
                buttons: (0, o.createFragment)(
                  [
                    (0, o.createComponentVNode)(2, a.Button, {
                      content: s ? "Open" : "Closed",
                      disabled: u,
                      selected: s,
                      onClick: function () {
                        return i("toggle_open");
                      },
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      icon: u ? "lock" : "unlock",
                      content: u ? "Locked" : "Unlocked",
                      selected: u,
                      disabled: s,
                      onClick: function () {
                        return i("teleporter_lock");
                      },
                    }),
                  ],
                  4
                ),
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Teleporter Unit",
                      color: d ? "good" : "bad",
                      buttons:
                        !d &&
                        (0, o.createComponentVNode)(2, a.Button, {
                          content: "Reconnect",
                          onClick: function () {
                            return i("scan_teleporter");
                          },
                        }),
                      children: d ? m : "Not Connected",
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Receiver Beacon",
                      color: p ? "good" : "bad",
                      buttons:
                        !p &&
                        (0, o.createComponentVNode)(2, a.Button, {
                          content: "Reconnect",
                          onClick: function () {
                            return i("scan_beacon");
                          },
                        }),
                      children: p ? C : "Not Connected",
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Prisoner Details",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Prisoner ID",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        fluid: !0,
                        content: h ? N : "No ID",
                        onClick: function () {
                          return i("handle_id");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Point Goal",
                      children: (0, o.createComponentVNode)(2, a.NumberInput, {
                        value: f,
                        width: "48px",
                        minValue: 1,
                        maxValue: 1e3,
                        onChange: function (e, t) {
                          return i("set_goal", { value: t });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Occupant",
                      children: v.name || "No Occupant",
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Criminal Status",
                      children: v.crimstat || "No Status",
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Button, {
                fluid: !0,
                content: "Process Prisoner",
                disabled: !V,
                textAlign: "center",
                color: "bad",
                onClick: function () {
                  return i("teleport");
                },
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Holodeck = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.Holodeck = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.can_toggle_safety,
          u = l.default_programs,
          s = void 0 === u ? [] : u,
          m = l.emag_programs,
          p = void 0 === m ? [] : m,
          C = l.emagged,
          h = l.program;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 400,
          height: 500,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Default Programs",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: C ? "unlock" : "lock",
                  content: "Safeties",
                  color: "bad",
                  disabled: !d,
                  selected: !C,
                  onClick: function () {
                    return i("safety");
                  },
                }),
                children: s.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    a.Button,
                    {
                      fluid: !0,
                      content: e.name.substring(11),
                      textAlign: "center",
                      selected: e.type === h,
                      onClick: function () {
                        return i("load_program", { type: e.type });
                      },
                    },
                    e.type
                  );
                }),
              }),
              !!C &&
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "Dangerous Programs",
                  children: p.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      a.Button,
                      {
                        fluid: !0,
                        content: e.name.substring(11),
                        color: "bad",
                        textAlign: "center",
                        selected: e.type === h,
                        onClick: function () {
                          return i("load_program", { type: e.type });
                        },
                      },
                      e.type
                    );
                  }),
                }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.HypnoChair = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.HypnoChair = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 500,
          height: 500,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Information",
                backgroundColor: "#450F44",
                children:
                  "The Enhanced Interrogation Chamber is designed to induce a deep-rooted trance trigger into the subject. Once the procedure is complete, by using the implanted trigger phrase, the authorities are able to ensure immediate and complete obedience and truthfulness.",
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Occupant Information",
                textAlign: "center",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Name",
                      children: l.occupant.name
                        ? l.occupant.name
                        : "No Occupant",
                    }),
                    !!l.occupied &&
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Status",
                        color:
                          0 === l.occupant.stat
                            ? "good"
                            : 1 === l.occupant.stat
                            ? "average"
                            : "bad",
                        children:
                          0 === l.occupant.stat
                            ? "Conscious"
                            : 1 === l.occupant.stat
                            ? "Unconcious"
                            : "Dead",
                      }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Operations",
                textAlign: "center",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Door",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: l.open ? "unlock" : "lock",
                        color: l.open ? "default" : "red",
                        content: l.open ? "Open" : "Closed",
                        onClick: function () {
                          return i("door");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Trigger Phrase",
                      children: (0, o.createComponentVNode)(2, a.Input, {
                        value: l.trigger,
                        onChange: function (e, t) {
                          return i("set_phrase", { phrase: t });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Interrogate Occupant",
                      children: [
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "code-branch",
                          content: l.interrogating
                            ? "Interrupt Interrogation"
                            : "Begin Enhanced Interrogation",
                          onClick: function () {
                            return i("interrogate");
                          },
                        }),
                        1 === l.interrogating &&
                          (0, o.createComponentVNode)(2, a.Icon, {
                            name: "cog",
                            color: "orange",
                            spin: !0,
                          }),
                      ],
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ImplantChair = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.ImplantChair = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 375,
          height: 280,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Occupant Information",
                textAlign: "center",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Name",
                      children: l.occupant.name || "No Occupant",
                    }),
                    !!l.occupied &&
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Status",
                        color:
                          0 === l.occupant.stat
                            ? "good"
                            : 1 === l.occupant.stat
                            ? "average"
                            : "bad",
                        children:
                          0 === l.occupant.stat
                            ? "Conscious"
                            : 1 === l.occupant.stat
                            ? "Unconcious"
                            : "Dead",
                      }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Operations",
                textAlign: "center",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Door",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: l.open ? "unlock" : "lock",
                        color: l.open ? "default" : "red",
                        content: l.open ? "Open" : "Closed",
                        onClick: function () {
                          return i("door");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Implant Occupant",
                      children: [
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "code-branch",
                          content: l.ready
                            ? l.special_name || "Implant"
                            : "Recharging",
                          onClick: function () {
                            return i("implant");
                          },
                        }),
                        0 === l.ready &&
                          (0, o.createComponentVNode)(2, a.Icon, {
                            name: "cog",
                            color: "orange",
                            spin: !0,
                          }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Implants Remaining",
                      children: [
                        l.ready_implants,
                        1 === l.replenishing &&
                          (0, o.createComponentVNode)(2, a.Icon, {
                            name: "sync",
                            color: "red",
                            spin: !0,
                          }),
                      ],
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.InfraredEmitter = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.InfraredEmitter = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.on,
          u = l.visible;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 225,
          height: 110,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Status",
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      icon: d ? "power-off" : "times",
                      content: d ? "On" : "Off",
                      selected: d,
                      onClick: function () {
                        return i("power");
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Visibility",
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      icon: u ? "eye" : "eye-slash",
                      content: u ? "Visible" : "Invisible",
                      selected: u,
                      onClick: function () {
                        return i("visibility");
                      },
                    }),
                  }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Intellicard = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.Intellicard = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.name,
          u = l.isDead,
          s = l.isBraindead,
          m = l.health,
          p = l.wireless,
          C = l.radio,
          h = l.wiping,
          N = l.laws,
          V = void 0 === N ? [] : N,
          b = u || s;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 500,
          height: 500,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.Section, {
              title: d || "Empty Card",
              buttons:
                !!d &&
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "trash",
                  content: h ? "Stop Wiping" : "Wipe",
                  disabled: u,
                  onClick: function () {
                    return i("wipe");
                  },
                }),
              children:
                !!d &&
                (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Status",
                      color: b ? "bad" : "good",
                      children: b ? "Offline" : "Operation",
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Software Integrity",
                      children: (0, o.createComponentVNode)(2, a.ProgressBar, {
                        value: m,
                        minValue: 0,
                        maxValue: 100,
                        ranges: {
                          good: [70, Infinity],
                          average: [50, 70],
                          bad: [-Infinity, 50],
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Settings",
                      children: [
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "signal",
                          content: "Wireless Activity",
                          selected: p,
                          onClick: function () {
                            return i("wireless");
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "microphone",
                          content: "Subspace Radio",
                          selected: C,
                          onClick: function () {
                            return i("radio");
                          },
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Laws",
                      children: V.map(function (e) {
                        return (0,
                        o.createComponentVNode)(2, a.BlockQuote, { children: e }, e);
                      }),
                    }),
                  ],
                }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.KeycardAuth = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.KeycardAuth = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 375,
          height: 125,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: [
                (0, o.createComponentVNode)(2, a.Box, {
                  children:
                    1 === l.waiting &&
                    (0, o.createVNode)(
                      1,
                      "span",
                      null,
                      "Waiting for another device to confirm your request...",
                      16
                    ),
                }),
                (0, o.createComponentVNode)(2, a.Box, {
                  children:
                    0 === l.waiting &&
                    (0, o.createFragment)(
                      [
                        !!l.auth_required &&
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "check-square",
                            color: "red",
                            textAlign: "center",
                            lineHeight: "60px",
                            fluid: !0,
                            onClick: function () {
                              return i("auth_swipe");
                            },
                            content: "Authorize",
                          }),
                        0 === l.auth_required &&
                          (0, o.createFragment)(
                            [
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "exclamation-triangle",
                                fluid: !0,
                                onClick: function () {
                                  return i("red_alert");
                                },
                                content: "Red Alert",
                              }),
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "wrench",
                                fluid: !0,
                                onClick: function () {
                                  return i("emergency_maint");
                                },
                                content: "Emergency Maintenance Access",
                              }),
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "meteor",
                                fluid: !0,
                                onClick: function () {
                                  return i("bsa_unlock");
                                },
                                content: "Bluespace Artillery Unlock",
                              }),
                            ],
                            4
                          ),
                      ],
                      0
                    ),
                }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.LaborClaimConsole = void 0);
      var o = n(0),
        r = n(19),
        a = n(2),
        c = n(1),
        i = n(3);
      t.LaborClaimConsole = function (e, t) {
        var n = (0, a.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.can_go_home,
          s = d.id_points,
          m = d.ores,
          p = d.status_info,
          C = d.unclaimed_points;
        return (0, o.createComponentVNode)(2, i.Window, {
          width: 315,
          height: 430,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, c.Section, {
                children: (0, o.createComponentVNode)(2, c.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Status",
                      children: p,
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Shuttle controls",
                      children: (0, o.createComponentVNode)(2, c.Button, {
                        content: "Move shuttle",
                        disabled: !u,
                        onClick: function () {
                          return l("move_shuttle");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Points",
                      children: s,
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Unclaimed points",
                      buttons: (0, o.createComponentVNode)(2, c.Button, {
                        content: "Claim points",
                        disabled: !C,
                        onClick: function () {
                          return l("claim_points");
                        },
                      }),
                      children: C,
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Material values",
                children: (0, o.createComponentVNode)(2, c.Table, {
                  children: [
                    (0, o.createComponentVNode)(2, c.Table.Row, {
                      header: !0,
                      children: [
                        (0, o.createComponentVNode)(2, c.Table.Cell, {
                          children: "Material",
                        }),
                        (0, o.createComponentVNode)(2, c.Table.Cell, {
                          collapsing: !0,
                          textAlign: "right",
                          children: "Value",
                        }),
                      ],
                    }),
                    m.map(function (e) {
                      return (0,
                      o.createComponentVNode)(2, c.Table.Row, { children: [(0, o.createComponentVNode)(2, c.Table.Cell, { children: (0, r.toTitleCase)(e.ore) }), (0, o.createComponentVNode)(2, c.Table.Cell, { collapsing: !0, textAlign: "right", children: (0, o.createComponentVNode)(2, c.Box, { color: "label", inline: !0, children: e.value }) })] }, e.ore);
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.LanguageMenu = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.LanguageMenu = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.admin_mode,
          u = l.is_living,
          s = l.omnitongue,
          m = l.languages,
          p = void 0 === m ? [] : m,
          C = l.unknown_languages,
          h = void 0 === C ? [] : C;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 700,
          height: 600,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Known Languages",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: p.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      a.LabeledList.Item,
                      {
                        label: e.name,
                        buttons: (0, o.createFragment)(
                          [
                            !!u &&
                              (0, o.createComponentVNode)(2, a.Button, {
                                content: e.is_default
                                  ? "Default Language"
                                  : "Select as Default",
                                disabled: !e.can_speak,
                                selected: e.is_default,
                                onClick: function () {
                                  return i("select_default", {
                                    language_name: e.name,
                                  });
                                },
                              }),
                            !!d &&
                              (0, o.createFragment)(
                                [
                                  (0, o.createComponentVNode)(2, a.Button, {
                                    content: "Grant",
                                    onClick: function () {
                                      return i("grant_language", {
                                        language_name: e.name,
                                      });
                                    },
                                  }),
                                  (0, o.createComponentVNode)(2, a.Button, {
                                    content: "Remove",
                                    onClick: function () {
                                      return i("remove_language", {
                                        language_name: e.name,
                                      });
                                    },
                                  }),
                                ],
                                4
                              ),
                          ],
                          0
                        ),
                        children: [
                          e.desc,
                          " ",
                          "Key: ,",
                          e.key,
                          " ",
                          e.can_understand
                            ? "Can understand."
                            : "Cannot understand.",
                          " ",
                          e.can_speak ? "Can speak." : "Cannot speak.",
                        ],
                      },
                      e.name
                    );
                  }),
                }),
              }),
              !!d &&
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "Unknown Languages",
                  buttons: (0, o.createComponentVNode)(2, a.Button, {
                    content: "Omnitongue " + (s ? "Enabled" : "Disabled"),
                    selected: s,
                    onClick: function () {
                      return i("toggle_omnitongue");
                    },
                  }),
                  children: (0, o.createComponentVNode)(2, a.LabeledList, {
                    children: h.map(function (e) {
                      return (0, o.createComponentVNode)(
                        2,
                        a.LabeledList.Item,
                        {
                          label: e.name,
                          buttons: (0, o.createComponentVNode)(2, a.Button, {
                            content: "Grant",
                            onClick: function () {
                              return i("grant_language", {
                                language_name: e.name,
                              });
                            },
                          }),
                          children: [
                            e.desc,
                            " ",
                            "Key: ,",
                            e.key,
                            " ",
                            !!e.shadow && "(gained from mob)",
                            " ",
                            e.can_understand
                              ? "Can understand."
                              : "Cannot understand.",
                            " ",
                            e.can_speak ? "Can speak." : "Cannot speak.",
                          ],
                        },
                        e.name
                      );
                    }),
                  }),
                }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.LaunchpadRemote = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = n(206);
      t.LaunchpadRemote = function (e, t) {
        var n = (0, r.useBackend)(t).data,
          l = n.has_pad,
          d = n.pad_closed;
        return (0, o.createComponentVNode)(2, c.Window, {
          theme: "syndicate",
          width: 300,
          height: 240,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children:
              (!l &&
                (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children: "No Launchpad Connected",
                })) ||
              (d &&
                (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children: "Launchpad Closed",
                })) ||
              (0, o.createComponentVNode)(2, i.LaunchpadControl, {
                topLevel: !0,
              }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.MechBayPowerConsole = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.MechBayPowerConsole = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data.recharge_port,
          d = l && l.mech,
          u = d && d.cell;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 400,
          height: 200,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              title: "Mech status",
              textAlign: "center",
              buttons: (0, o.createComponentVNode)(2, a.Button, {
                icon: "sync",
                content: "Sync",
                onClick: function () {
                  return i("reconnect");
                },
              }),
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Integrity",
                    children:
                      (!l &&
                        (0, o.createComponentVNode)(2, a.NoticeBox, {
                          children: "No power port detected. Please re-sync.",
                        })) ||
                      (!d &&
                        (0, o.createComponentVNode)(2, a.NoticeBox, {
                          children: "No mech detected.",
                        })) ||
                      (0, o.createComponentVNode)(2, a.ProgressBar, {
                        value: d.health / d.maxhealth,
                        ranges: {
                          good: [0.7, Infinity],
                          average: [0.3, 0.7],
                          bad: [-Infinity, 0.3],
                        },
                      }),
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Power",
                    children:
                      (!l &&
                        (0, o.createComponentVNode)(2, a.NoticeBox, {
                          children: "No power port detected. Please re-sync.",
                        })) ||
                      (!d &&
                        (0, o.createComponentVNode)(2, a.NoticeBox, {
                          children: "No mech detected.",
                        })) ||
                      (!u &&
                        (0, o.createComponentVNode)(2, a.NoticeBox, {
                          children: "No cell is installed.",
                        })) ||
                      (0, o.createComponentVNode)(2, a.ProgressBar, {
                        value: u.charge / u.maxcharge,
                        ranges: {
                          good: [0.7, Infinity],
                          average: [0.3, 0.7],
                          bad: [-Infinity, 0.3],
                        },
                        children: [
                          (0, o.createComponentVNode)(2, a.AnimatedNumber, {
                            value: u.charge,
                          }),
                          " / " + u.maxcharge,
                        ],
                      }),
                  }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.MiningVendor = void 0);
      var o = n(0),
        r = n(6),
        a = n(2),
        c = n(1),
        i = n(3);
      t.MiningVendor = function (e, t) {
        var n = (0, a.useBackend)(t),
          l = n.act,
          d = n.data,
          u = [].concat(d.product_records);
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 425,
          height: 600,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, c.Section, {
                title: "User",
                children:
                  (d.user &&
                    (0, o.createComponentVNode)(2, c.Box, {
                      children: [
                        "Welcome, ",
                        (0, o.createVNode)(
                          1,
                          "b",
                          null,
                          d.user.name || "Unknown",
                          0
                        ),
                        ",",
                        " ",
                        (0, o.createVNode)(
                          1,
                          "b",
                          null,
                          d.user.job || "Unemployed",
                          0
                        ),
                        "!",
                        (0, o.createVNode)(1, "br"),
                        "Your balance is ",
                        (0, o.createVNode)(
                          1,
                          "b",
                          null,
                          [
                            d.user.points,
                            (0, o.createTextVNode)(" mining points"),
                          ],
                          0
                        ),
                        ".",
                      ],
                    })) ||
                  (0, o.createComponentVNode)(2, c.Box, {
                    color: "light-gray",
                    children: [
                      "No registered ID card!",
                      (0, o.createVNode)(1, "br"),
                      "Please contact your local HoP!",
                    ],
                  }),
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Equipment",
                children: (0, o.createComponentVNode)(2, c.Table, {
                  children: u.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      c.Table.Row,
                      {
                        children: [
                          (0, o.createComponentVNode)(2, c.Table.Cell, {
                            children: [
                              (0, o.createVNode)(
                                1,
                                "span",
                                (0, r.classes)(["vending32x32", e.path]),
                                null,
                                1,
                                { style: { "vertical-align": "middle" } }
                              ),
                              " ",
                              (0, o.createVNode)(1, "b", null, e.name, 0),
                            ],
                          }),
                          (0, o.createComponentVNode)(2, c.Table.Cell, {
                            children: (0, o.createComponentVNode)(2, c.Button, {
                              style: {
                                "min-width": "95px",
                                "text-align": "center",
                              },
                              disabled: !d.user || e.price > d.user.points,
                              content: e.price + " points",
                              onClick: function () {
                                return l("purchase", { ref: e.ref });
                              },
                            }),
                          }),
                        ],
                      },
                      e.name
                    );
                  }),
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Mint = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.Mint = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.inserted_materials || [];
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 300,
          height: 250,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Materials",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: l.processing ? "times" : "power-off",
                  content: l.processing ? "Stop" : "Start",
                  selected: l.processing,
                  onClick: function () {
                    return i(l.processing ? "stoppress" : "startpress");
                  },
                }),
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: d.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      a.LabeledList.Item,
                      {
                        label: e.material,
                        buttons: (0, o.createComponentVNode)(
                          2,
                          a.Button.Checkbox,
                          {
                            checked: l.chosen_material === e.material,
                            onClick: function () {
                              return i("changematerial", {
                                material_name: e.material,
                              });
                            },
                          }
                        ),
                        children: [e.amount, " cm\xb3"],
                      },
                      e.material
                    );
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                children: ["Pressed ", l.produced_coins, " coins this cycle."],
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.ModFabDataDisk = t.FabricationQueue = t.ProcessingBar = t.SidePanel = t.MaterialData = t.OutputDir = t.ModFabData = t.ModFabCategoryItems = t.ModFabCategoryList = t.ModFabMain = t.ModularFabricator = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = n(19),
        l = n(8);
      t.ModularFabricator = function (e, t) {
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 1e3,
          height: 714,
          resizable: !0,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createVNode)(
                1,
                "div",
                "ModularFabricator__top",
                (0, o.createComponentVNode)(2, m),
                2
              ),
              (0, o.createVNode)(
                1,
                "div",
                "ModularFabricator__bottom",
                [
                  (0, o.createVNode)(
                    1,
                    "div",
                    "ModularFabricator__main",
                    (0, o.createComponentVNode)(2, d),
                    2
                  ),
                  (0, o.createVNode)(
                    1,
                    "div",
                    "ModularFabricator__sidebar",
                    (0, o.createComponentVNode)(2, h),
                    2
                  ),
                ],
                4
              ),
            ],
          }),
        });
      };
      var d = function (e, t) {
        var n,
          c = (0, r.useBackend)(t),
          l = (c.act, c.data),
          d = (0, r.useLocalState)(t, "category", ""),
          m = d[0],
          p = (d[1], l.items),
          C = void 0 === p ? [] : p,
          h = (0, r.useLocalState)(t, "search", ""),
          N = h[0],
          V =
            (h[1],
            (0, i.createSearch)(N, function (e) {
              return e.name;
            }));
        if (N)
          n = C.flatMap(function (e) {
            return e.category_items || [];
          })
            .filter(V)
            .filter(function (e, t) {
              return t < 25;
            });
        else
          for (var b = 0; b < C.length; b++)
            C[b].category_name === m && (n = C[b].category_items);
        return (0, o.createComponentVNode)(2, a.Section, {
          overflowY: "scroll",
          height: "100%",
          width: "100%",
          children: [
            (0, o.createComponentVNode)(2, u, { categories: C }),
            (0, o.createComponentVNode)(2, a.Divider),
            n ? (0, o.createComponentVNode)(2, s, { items: n }) : "",
          ],
        });
      };
      t.ModFabMain = d;
      var u = function (e, t) {
        var n = e.categories,
          c = (0, r.useLocalState)(t, "category", ""),
          i = (c[0], c[1]),
          l = (0, r.useLocalState)(t, "search", ""),
          d = l[0],
          u = l[1];
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, a.Box, {
              bold: !0,
              children: (0, o.createComponentVNode)(2, a.Grid, {
                children: [
                  (0, o.createComponentVNode)(2, a.Grid.Column, {
                    children: "Categories",
                  }),
                  (0, o.createComponentVNode)(2, a.Grid.Column, {
                    textAlign: "right",
                    children: [
                      "Search: ",
                      (0, o.createComponentVNode)(2, a.Input, {
                        align: "right",
                        value: d,
                        onInput: function (e, t) {
                          u(t);
                        },
                      }),
                    ],
                  }),
                ],
              }),
            }),
            (0, o.createComponentVNode)(2, a.Divider),
            n.map(function (e) {
              return (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, a.Button, {
                    width: "200px",
                    content: e.category_name,
                    icon: "angle-right",
                    onClick: function () {
                      i(e.category_name), u("");
                    },
                  }),
                ],
                4,
                e.category_name
              );
            }),
          ],
          0
        );
      };
      t.ModFabCategoryList = u;
      var s = function (e, t) {
        var n = (0, r.useBackend)(t).act,
          c = e.items,
          i = (0, r.useLocalState)(t, "category", ""),
          l = (i[0], i[1]),
          d = (0, r.useLocalState)(t, "amount", 1),
          u = d[0],
          s = d[1];
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, a.Button, {
              content: "Return",
              icon: "backspace",
              onClick: function () {
                l("");
              },
            }),
            (0, o.createComponentVNode)(2, a.Table, {
              height: "100%",
              children: c.map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  a.Table.Row,
                  {
                    height: "100%",
                    children: [
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: e.name,
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        children: [
                          e.material_cost.map(function (e) {
                            return (0,
                            o.createComponentVNode)(2, a.Box, { children: [e.name, " (", e.amount, ")"] }, e.name);
                          }),
                          (0, o.createComponentVNode)(2, a.Divider),
                        ],
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        collapsing: !0,
                        verticalAlign: "middle",
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          icon: "minus",
                          onClick: function () {
                            return s(u - 1);
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        collapsing: !0,
                        verticalAlign: "middle",
                        children: (0, o.createComponentVNode)(
                          2,
                          a.NumberInput,
                          {
                            value: u,
                            minValue: 0,
                            maxValue: 50,
                            onChange: function (e, t) {
                              return s(t);
                            },
                          }
                        ),
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        collapsing: !0,
                        verticalAlign: "middle",
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          icon: "plus",
                          onClick: function () {
                            return s(u + 1);
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        collapsing: !0,
                        verticalAlign: "middle",
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          icon: "hammer",
                          content: "Create",
                          onClick: function () {
                            return n("build_item", {
                              design_id: e.design_id,
                              amount: u,
                              item_name: e.name,
                            });
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Table.Cell, {
                        collapsing: !0,
                        verticalAlign: "middle",
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          icon: "plus-circle",
                          content: "Queue",
                          onClick: function () {
                            return n("queue_item", {
                              design_id: e.design_id,
                              amount: u,
                              item_name: e.name,
                            });
                          },
                        }),
                      }),
                    ],
                  },
                  e
                );
              }),
            }),
          ],
          4
        );
      };
      t.ModFabCategoryItems = s;
      var m = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          l = i.hacked,
          d = i.sec_interface_unlock;
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, a.NoticeBox, {
              color: d ? "green" : "red",
              children: (0, o.createComponentVNode)(2, a.Flex, {
                align: "center",
                children: [
                  (0, o.createComponentVNode)(2, a.Flex.Item, {
                    grow: 1,
                    children: [
                      "Security protocol ",
                      l ? "disengaged" : "engaged",
                      ". Swipe a valid ID to unlock safety controls.",
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.Flex.Item, {
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      m: 0,
                      color: d ? "green" : "red",
                      icon: d ? "unlock" : "lock",
                      content: l ? "Reactivate" : "Deactivate",
                      onClick: function () {
                        return c("toggle_safety");
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.Flex.Item, {
                    mx: 1,
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      m: 0,
                      color: d ? "green" : "red",
                      icon: d ? "unlock" : "lock",
                      content: d ? "Unlock" : "Lock",
                      onClick: function () {
                        return c("toggle_lock");
                      },
                    }),
                  }),
                ],
              }),
            }),
            (0, o.createComponentVNode)(2, a.Section, {
              height: "100px",
              children: [
                (0, o.createComponentVNode)(2, b),
                (0, o.createComponentVNode)(2, a.Box, {
                  width: "150px",
                  inline: !0,
                  children: [
                    (0, o.createComponentVNode)(2, a.Box, {
                      bold: !0,
                      align: "center",
                      height: 1.5,
                      children: "Output Direction",
                    }),
                    (0, o.createComponentVNode)(2, p),
                  ],
                }),
              ],
            }),
          ],
          4
        );
      };
      t.ModFabData = m;
      var p = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data.outputDir,
          l = void 0 === i ? 0 : i;
        return (0, o.createComponentVNode)(2, a.Table, {
          width: "80px",
          align: "center",
          children: [
            (0, o.createComponentVNode)(2, a.Table.Row, {
              children: [
                (0, o.createComponentVNode)(2, a.Table.Cell),
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  children: (0, o.createComponentVNode)(2, a.Button, {
                    icon: "arrow-up",
                    color: 1 === l ? "green" : "red",
                    onClick: function () {
                      return c("output_dir", { direction: 1 });
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, a.Table.Cell),
              ],
            }),
            (0, o.createComponentVNode)(2, a.Table.Row, {
              children: [
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  children: (0, o.createComponentVNode)(2, a.Button, {
                    icon: "arrow-left",
                    color: 8 === l ? "green" : "red",
                    onClick: function () {
                      return c("output_dir", { direction: 8 });
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  children: (0, o.createComponentVNode)(2, a.Button, {
                    icon: "circle",
                    color: 0 === l ? "green" : "red",
                    onClick: function () {
                      return c("output_dir", { direction: 0 });
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  children: (0, o.createComponentVNode)(2, a.Button, {
                    icon: "arrow-right",
                    color: 4 === l ? "green" : "red",
                    onClick: function () {
                      return c("output_dir", { direction: 4 });
                    },
                  }),
                }),
              ],
            }),
            (0, o.createComponentVNode)(2, a.Table.Row, {
              children: [
                (0, o.createComponentVNode)(2, a.Table.Cell),
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  children: (0, o.createComponentVNode)(2, a.Button, {
                    icon: "arrow-down",
                    color: 2 === l ? "green" : "red",
                    onClick: function () {
                      return c("output_dir", { direction: 2 });
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, a.Table.Cell),
              ],
            }),
          ],
        });
      };
      t.OutputDir = p;
      var C = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          l = n.data.materials,
          d = void 0 === l ? [] : l;
        return (0, o.createComponentVNode)(2, a.Table, {
          children: d.map(function (e) {
            return (0, o.createFragment)(
              [
                (0, o.createComponentVNode)(2, a.Table.Row, {
                  children: [
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      children: (0, i.capitalize)(e.name),
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      children: [e.amount, " sheets"],
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        color: "green",
                        disabled: e.amount < 1,
                        content: "x1",
                        onClick: function () {
                          return c("eject_material", {
                            material_datum: e.datum,
                            amount: 1,
                          });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        color: "green",
                        disabled: e.amount < 10,
                        content: "x10",
                        onClick: function () {
                          return c("eject_material", {
                            material_datum: e.datum,
                            amount: 10,
                          });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        color: "green",
                        disabled: e.amount < 50,
                        content: "x50",
                        onClick: function () {
                          return c("eject_material", {
                            material_datum: e.datum,
                            amount: 50,
                          });
                        },
                      }),
                    }),
                  ],
                }),
              ],
              4,
              e.name
            );
          }),
        });
      };
      t.MaterialData = C;
      var h = function (e, t) {
        var n = (0, r.useBackend)(t).act,
          c = (0, r.useLocalState)(t, "queueRepeat", 0),
          i = c[0],
          l = c[1];
        return (0, o.createComponentVNode)(2, a.Section, {
          width: "100%",
          height: "100%",
          children: [
            (0, o.createComponentVNode)(2, C),
            (0, o.createComponentVNode)(2, a.Divider),
            (0, o.createComponentVNode)(2, a.Flex, {
              align: "center",
              children: [
                (0, o.createComponentVNode)(2, a.Flex.Item, {
                  bold: !0,
                  grow: 1,
                  children: "Queue",
                }),
                (0, o.createComponentVNode)(2, a.Flex.Item, {
                  children: (0, o.createComponentVNode)(2, a.Button, {
                    m: 0,
                    color: i ? "green" : "red",
                    icon: "redo-alt",
                    content: i ? "Continuous" : "Linear",
                    onClick: function () {
                      n("queue_repeat", { repeating: 1 - i }), l(1 - i);
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, a.Flex.Item, {
                  mx: 1,
                  children: (0, o.createComponentVNode)(2, a.Button, {
                    m: 0,
                    color: "red",
                    icon: "times",
                    content: "Clear",
                    onClick: function () {
                      return n("clear_queue");
                    },
                  }),
                }),
              ],
            }),
            (0, o.createComponentVNode)(2, a.Divider),
            (0, o.createComponentVNode)(2, V),
            (0, o.createComponentVNode)(2, N),
          ],
        });
      };
      t.SidePanel = h;
      var N = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data.being_build;
        return (0, o.createVNode)(
          1,
          "div",
          "ModularFabricator__sidebar_bottom",
          [
            (0, o.createComponentVNode)(2, a.Button, {
              content: "Process",
              color: "green",
              icon: "caret-right",
              onClick: function () {
                return c("begin_process");
              },
            }),
            i
              ? (0, o.createComponentVNode)(2, a.ProgressBar, {
                  value: i.progress,
                  minValue: 0,
                  maxValue: 100,
                  color: "green",
                  width: "75%",
                  children: [
                    i.name,
                    " - ",
                    Math.min((0, l.round)(i.progress), 100),
                    "%",
                  ],
                })
              : (0, o.createComponentVNode)(2, a.NoticeBox, {
                  bold: !0,
                  width: "75%",
                  inline: !0,
                  children: "Not Processing.",
                }),
          ],
          0
        );
      };
      t.ProcessingBar = N;
      var V = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data.queue,
          l = void 0 === i ? [] : i;
        return (0, o.createComponentVNode)(2, a.Table, {
          children: l.map(function (e) {
            return (0, o.createComponentVNode)(
              2,
              a.Table.Row,
              {
                children: [
                  (0, o.createComponentVNode)(2, a.Table.Cell, {
                    bold: !0,
                    children: e.name,
                  }),
                  (0, o.createComponentVNode)(2, a.Table.Cell, {
                    children: ["x", e.amount],
                  }),
                  (0, o.createComponentVNode)(2, a.Table.Cell, {
                    collapsing: !0,
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      icon: "redo-alt",
                      color: e.build_queue
                        ? "grey"
                        : e.repeat
                        ? "green"
                        : "red",
                      onClick: function () {
                        return c("item_repeat", {
                          design_id: e.design_id,
                          repeating: 1 - e.repeat,
                        });
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.Table.Cell, {
                    collapsing: !0,
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      icon: "times",
                      color: "red",
                      onClick: function () {
                        return c("clear_item", {
                          design_id: e.design_id,
                          build_queue: e.build_queue,
                        });
                      },
                    }),
                  }),
                ],
              },
              e
            );
          }),
        });
      };
      t.FabricationQueue = V;
      var b = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          l = i.acceptsDisk,
          d = i.diskInserted;
        return (0, o.createComponentVNode)(2, a.Box, {
          inline: !0,
          children: [
            (0, o.createComponentVNode)(2, a.Box, {
              bold: !0,
              textAlign: "center",
              children: "Data Disk Drive",
            }),
            (0, o.createComponentVNode)(2, a.Table, {
              children: [
                (0, o.createComponentVNode)(2, a.Table.Row, {
                  children: [
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      children: "Status:",
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      bold: !0,
                      color: l ? (d ? "green" : "yellow") : "red",
                      children: l ? (d ? "Ready" : "Empty") : "Inactive",
                    }),
                  ],
                }),
                (0, o.createComponentVNode)(2, a.Table.Row, {
                  children: (0, o.createComponentVNode)(2, a.Table.Cell, {
                    colspan: 2,
                    textAlign: "center",
                    bold: !0,
                    children: "Actions",
                  }),
                }),
                (0, o.createComponentVNode)(2, a.Table.Row, {
                  children: (0, o.createComponentVNode)(2, a.Table.Cell, {
                    colspan: 2,
                    textAlign: "center",
                    bold: !0,
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      color: l && d ? "green" : "grey",
                      content: "Install",
                      icon: "upload",
                      onClick: function () {
                        return c("upload_disk");
                      },
                    }),
                  }),
                }),
                (0, o.createComponentVNode)(2, a.Table.Row, {
                  children: (0, o.createComponentVNode)(2, a.Table.Cell, {
                    colspan: 2,
                    textAlign: "center",
                    bold: !0,
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      color: l && d ? "green" : "grey",
                      content: "Eject",
                      icon: "folder-open",
                      onClick: function () {
                        return c("eject_disk");
                      },
                    }),
                  }),
                }),
              ],
            }),
          ],
        });
      };
      t.ModFabDataDisk = b;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Mule = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = n(59);
      t.Mule = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.on,
          s = d.cell,
          m = d.cellPercent,
          p = d.load,
          C = d.mode,
          h = d.modeStatus,
          N = d.haspai,
          V = d.autoReturn,
          b = d.autoPickup,
          f = d.reportDelivery,
          g = d.destination,
          v = d.home,
          k = d.id,
          w = d.destinations,
          B = void 0 === w ? [] : w,
          x = d.locked && !d.siliconUser;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 350,
          height: 425,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, i.InterfaceLockNoticeBox),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Status",
                minHeight: "110px",
                buttons:
                  !x &&
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: u ? "power-off" : "times",
                    content: u ? "On" : "Off",
                    selected: u,
                    onClick: function () {
                      return l("power");
                    },
                  }),
                children: [
                  (0, o.createComponentVNode)(2, a.ProgressBar, {
                    value: s ? m / 100 : 0,
                    color: s ? "good" : "bad",
                  }),
                  (0, o.createComponentVNode)(2, a.Flex, {
                    mt: 1,
                    children: [
                      (0, o.createComponentVNode)(2, a.Flex.Item, {
                        grow: 1,
                        basis: 0,
                        children: (0, o.createComponentVNode)(
                          2,
                          a.LabeledList,
                          {
                            children: (0, o.createComponentVNode)(
                              2,
                              a.LabeledList.Item,
                              { label: "Mode", color: h, children: C }
                            ),
                          }
                        ),
                      }),
                      (0, o.createComponentVNode)(2, a.Flex.Item, {
                        grow: 1,
                        basis: 0,
                        children: (0, o.createComponentVNode)(
                          2,
                          a.LabeledList,
                          {
                            children: (0, o.createComponentVNode)(
                              2,
                              a.LabeledList.Item,
                              {
                                label: "Load",
                                color: p ? "good" : "average",
                                children: p || "None",
                              }
                            ),
                          }
                        ),
                      }),
                    ],
                  }),
                ],
              }),
              !x &&
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "Controls",
                  buttons: (0, o.createFragment)(
                    [
                      !!p &&
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "eject",
                          content: "Unload",
                          onClick: function () {
                            return l("unload");
                          },
                        }),
                      !!N &&
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "eject",
                          content: "Eject PAI",
                          onClick: function () {
                            return l("ejectpai");
                          },
                        }),
                    ],
                    0
                  ),
                  children: (0, o.createComponentVNode)(2, a.LabeledList, {
                    children: [
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "ID",
                        children: (0, o.createComponentVNode)(2, a.Input, {
                          value: k,
                          onChange: function (e, t) {
                            return l("setid", { value: t });
                          },
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Destination",
                        children: [
                          (0, o.createComponentVNode)(2, a.Dropdown, {
                            over: !0,
                            selected: g || "None",
                            options: B,
                            width: "150px",
                            onSelected: function (e) {
                              return l("destination", { value: e });
                            },
                          }),
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "stop",
                            content: "Stop",
                            onClick: function () {
                              return l("stop");
                            },
                          }),
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "play",
                            content: "Go",
                            onClick: function () {
                              return l("go");
                            },
                          }),
                        ],
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Home",
                        children: [
                          (0, o.createComponentVNode)(2, a.Dropdown, {
                            over: !0,
                            selected: v,
                            options: B,
                            width: "150px",
                            onSelected: function (e) {
                              return l("destination", { value: e });
                            },
                          }),
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "home",
                            content: "Go Home",
                            onClick: function () {
                              return l("home");
                            },
                          }),
                        ],
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Settings",
                        children: [
                          (0, o.createComponentVNode)(2, a.Button.Checkbox, {
                            checked: V,
                            content: "Auto-Return",
                            onClick: function () {
                              return l("autored");
                            },
                          }),
                          (0, o.createVNode)(1, "br"),
                          (0, o.createComponentVNode)(2, a.Button.Checkbox, {
                            checked: b,
                            content: "Auto-Pickup",
                            onClick: function () {
                              return l("autopick");
                            },
                          }),
                          (0, o.createVNode)(1, "br"),
                          (0, o.createComponentVNode)(2, a.Button.Checkbox, {
                            checked: f,
                            content: "Report Delivery",
                            onClick: function () {
                              return l("report");
                            },
                          }),
                        ],
                      }),
                    ],
                  }),
                }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.NaniteChamberControlContent = t.NaniteChamberControl = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.NaniteChamberControl = function (e, t) {
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 380,
          height: 570,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, i),
          }),
        });
      };
      var i = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          l = i.status_msg,
          d = i.locked,
          u = i.occupant_name,
          s = i.has_nanites,
          m = i.nanite_volume,
          p = i.regen_rate,
          C = i.safety_threshold,
          h = i.cloud_id,
          N = i.scan_level;
        if (l)
          return (0, o.createComponentVNode)(2, a.NoticeBox, {
            textAlign: "center",
            children: l,
          });
        var V = i.mob_programs || [];
        return (0, o.createComponentVNode)(2, a.Section, {
          title: "Chamber: " + u,
          buttons: (0, o.createComponentVNode)(2, a.Button, {
            icon: d ? "lock" : "lock-open",
            content: d ? "Locked" : "Unlocked",
            color: d ? "bad" : "default",
            onClick: function () {
              return c("toggle_lock");
            },
          }),
          children: s
            ? (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, a.Section, {
                    title: "Status",
                    level: 2,
                    buttons: (0, o.createComponentVNode)(2, a.Button, {
                      icon: "exclamation-triangle",
                      content: "Destroy Nanites",
                      color: "bad",
                      onClick: function () {
                        return c("remove_nanites");
                      },
                    }),
                    children: (0, o.createComponentVNode)(2, a.Grid, {
                      children: [
                        (0, o.createComponentVNode)(2, a.Grid.Column, {
                          children: (0, o.createComponentVNode)(
                            2,
                            a.LabeledList,
                            {
                              children: [
                                (0, o.createComponentVNode)(
                                  2,
                                  a.LabeledList.Item,
                                  { label: "Nanite Volume", children: m }
                                ),
                                (0, o.createComponentVNode)(
                                  2,
                                  a.LabeledList.Item,
                                  { label: "Growth Rate", children: p }
                                ),
                              ],
                            }
                          ),
                        }),
                        (0, o.createComponentVNode)(2, a.Grid.Column, {
                          children: (0, o.createComponentVNode)(
                            2,
                            a.LabeledList,
                            {
                              children: [
                                (0, o.createComponentVNode)(
                                  2,
                                  a.LabeledList.Item,
                                  {
                                    label: "Safety Threshold",
                                    children: (0, o.createComponentVNode)(
                                      2,
                                      a.NumberInput,
                                      {
                                        value: C,
                                        minValue: 0,
                                        maxValue: 500,
                                        width: "39px",
                                        onChange: function (e, t) {
                                          return c("set_safety", { value: t });
                                        },
                                      }
                                    ),
                                  }
                                ),
                                (0, o.createComponentVNode)(
                                  2,
                                  a.LabeledList.Item,
                                  {
                                    label: "Cloud ID",
                                    children: (0, o.createComponentVNode)(
                                      2,
                                      a.NumberInput,
                                      {
                                        value: h,
                                        minValue: 0,
                                        maxValue: 100,
                                        step: 1,
                                        stepPixelSize: 3,
                                        width: "39px",
                                        onChange: function (e, t) {
                                          return c("set_cloud", { value: t });
                                        },
                                      }
                                    ),
                                  }
                                ),
                              ],
                            }
                          ),
                        }),
                      ],
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.Section, {
                    title: "Programs",
                    level: 2,
                    children: V.map(function (e) {
                      var t = e.extra_settings || [],
                        n = e.rules || [];
                      return (0, o.createComponentVNode)(
                        2,
                        a.Collapsible,
                        {
                          title: e.name,
                          children: (0, o.createComponentVNode)(2, a.Section, {
                            children: [
                              (0, o.createComponentVNode)(2, a.Grid, {
                                children: [
                                  (0, o.createComponentVNode)(
                                    2,
                                    a.Grid.Column,
                                    { children: e.desc }
                                  ),
                                  N >= 2 &&
                                    (0, o.createComponentVNode)(
                                      2,
                                      a.Grid.Column,
                                      {
                                        size: 0.6,
                                        children: (0, o.createComponentVNode)(
                                          2,
                                          a.LabeledList,
                                          {
                                            children: [
                                              (0, o.createComponentVNode)(
                                                2,
                                                a.LabeledList.Item,
                                                {
                                                  label: "Activation Status",
                                                  children: (0,
                                                  o.createComponentVNode)(
                                                    2,
                                                    a.Box,
                                                    {
                                                      color: e.activated
                                                        ? "good"
                                                        : "bad",
                                                      children: e.activated
                                                        ? "Active"
                                                        : "Inactive",
                                                    }
                                                  ),
                                                }
                                              ),
                                              (0, o.createComponentVNode)(
                                                2,
                                                a.LabeledList.Item,
                                                {
                                                  label: "Nanites Consumed",
                                                  children: [e.use_rate, "/s"],
                                                }
                                              ),
                                            ],
                                          }
                                        ),
                                      }
                                    ),
                                ],
                              }),
                              N >= 2 &&
                                (0, o.createComponentVNode)(2, a.Grid, {
                                  children: [
                                    !!e.can_trigger &&
                                      (0, o.createComponentVNode)(
                                        2,
                                        a.Grid.Column,
                                        {
                                          children: (0,
                                          o.createComponentVNode)(
                                            2,
                                            a.Section,
                                            {
                                              title: "Triggers",
                                              level: 2,
                                              children: (0,
                                              o.createComponentVNode)(
                                                2,
                                                a.LabeledList,
                                                {
                                                  children: [
                                                    (0,
                                                    o.createComponentVNode)(
                                                      2,
                                                      a.LabeledList.Item,
                                                      {
                                                        label: "Trigger Cost",
                                                        children:
                                                          e.trigger_cost,
                                                      }
                                                    ),
                                                    (0,
                                                    o.createComponentVNode)(
                                                      2,
                                                      a.LabeledList.Item,
                                                      {
                                                        label:
                                                          "Trigger Cooldown",
                                                        children:
                                                          e.trigger_cooldown,
                                                      }
                                                    ),
                                                    !!e.timer_trigger_delay &&
                                                      (0,
                                                      o.createComponentVNode)(
                                                        2,
                                                        a.LabeledList.Item,
                                                        {
                                                          label:
                                                            "Trigger Delay",
                                                          children: [
                                                            e.timer_trigger_delay,
                                                            " s",
                                                          ],
                                                        }
                                                      ),
                                                    !!e.timer_trigger &&
                                                      (0,
                                                      o.createComponentVNode)(
                                                        2,
                                                        a.LabeledList.Item,
                                                        {
                                                          label:
                                                            "Trigger Repeat Timer",
                                                          children: [
                                                            e.timer_trigger,
                                                            " s",
                                                          ],
                                                        }
                                                      ),
                                                  ],
                                                }
                                              ),
                                            }
                                          ),
                                        }
                                      ),
                                    !(!e.timer_restart && !e.timer_shutdown) &&
                                      (0, o.createComponentVNode)(
                                        2,
                                        a.Grid.Column,
                                        {
                                          children: (0,
                                          o.createComponentVNode)(
                                            2,
                                            a.Section,
                                            {
                                              children: (0,
                                              o.createComponentVNode)(
                                                2,
                                                a.LabeledList,
                                                {
                                                  children: [
                                                    e.timer_restart &&
                                                      (0,
                                                      o.createComponentVNode)(
                                                        2,
                                                        a.LabeledList.Item,
                                                        {
                                                          label:
                                                            "Restart Timer",
                                                          children: [
                                                            e.timer_restart,
                                                            " s",
                                                          ],
                                                        }
                                                      ),
                                                    e.timer_shutdown &&
                                                      (0,
                                                      o.createComponentVNode)(
                                                        2,
                                                        a.LabeledList.Item,
                                                        {
                                                          label:
                                                            "Shutdown Timer",
                                                          children: [
                                                            e.timer_shutdown,
                                                            " s",
                                                          ],
                                                        }
                                                      ),
                                                  ],
                                                }
                                              ),
                                            }
                                          ),
                                        }
                                      ),
                                  ],
                                }),
                              N >= 3 &&
                                !!e.has_extra_settings &&
                                (0, o.createComponentVNode)(2, a.Section, {
                                  title: "Extra Settings",
                                  level: 2,
                                  children: (0, o.createComponentVNode)(
                                    2,
                                    a.LabeledList,
                                    {
                                      children: t.map(function (e) {
                                        return (0,
                                        o.createComponentVNode)(2, a.LabeledList.Item, { label: e.name, children: e.value }, e.name);
                                      }),
                                    }
                                  ),
                                }),
                              N >= 4 &&
                                (0, o.createComponentVNode)(2, a.Grid, {
                                  children: [
                                    (0, o.createComponentVNode)(
                                      2,
                                      a.Grid.Column,
                                      {
                                        children: (0, o.createComponentVNode)(
                                          2,
                                          a.Section,
                                          {
                                            title: "Codes",
                                            level: 2,
                                            children: (0,
                                            o.createComponentVNode)(
                                              2,
                                              a.LabeledList,
                                              {
                                                children: [
                                                  !!e.activation_code &&
                                                    (0,
                                                    o.createComponentVNode)(
                                                      2,
                                                      a.LabeledList.Item,
                                                      {
                                                        label: "Activation",
                                                        children:
                                                          e.activation_code,
                                                      }
                                                    ),
                                                  !!e.deactivation_code &&
                                                    (0,
                                                    o.createComponentVNode)(
                                                      2,
                                                      a.LabeledList.Item,
                                                      {
                                                        label: "Deactivation",
                                                        children:
                                                          e.deactivation_code,
                                                      }
                                                    ),
                                                  !!e.kill_code &&
                                                    (0,
                                                    o.createComponentVNode)(
                                                      2,
                                                      a.LabeledList.Item,
                                                      {
                                                        label: "Kill",
                                                        children: e.kill_code,
                                                      }
                                                    ),
                                                  !!e.can_trigger &&
                                                    !!e.trigger_code &&
                                                    (0,
                                                    o.createComponentVNode)(
                                                      2,
                                                      a.LabeledList.Item,
                                                      {
                                                        label: "Trigger",
                                                        children:
                                                          e.trigger_code,
                                                      }
                                                    ),
                                                ],
                                              }
                                            ),
                                          }
                                        ),
                                      }
                                    ),
                                    e.has_rules &&
                                      (0, o.createComponentVNode)(
                                        2,
                                        a.Grid.Column,
                                        {
                                          children: (0, o.createComponentVNode)(
                                            2,
                                            a.Section,
                                            {
                                              title: "Rules",
                                              level: 2,
                                              children: n.map(function (e) {
                                                return (0,
                                                o.createFragment)([e.display, (0, o.createVNode)(1, "br")], 0, e.display);
                                              }),
                                            }
                                          ),
                                        }
                                      ),
                                  ],
                                }),
                            ],
                          }),
                        },
                        e.name
                      );
                    }),
                  }),
                ],
                4
              )
            : (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, a.Box, {
                    bold: !0,
                    color: "bad",
                    textAlign: "center",
                    fontSize: "30px",
                    mb: 1,
                    children: "No Nanites Detected",
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    bold: !0,
                    icon: "syringe",
                    content: " Implant Nanites",
                    color: "green",
                    textAlign: "center",
                    fontSize: "30px",
                    lineHeight: "50px",
                    onClick: function () {
                      return c("nanite_injection");
                    },
                  }),
                ],
                4
              ),
        });
      };
      t.NaniteChamberControlContent = i;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.NaniteCloudControl = t.NaniteCloudBackupDetails = t.NaniteCloudBackupList = t.NaniteInfoBox = t.NaniteDiskBox = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = function (e, t) {
          var n = (0, r.useBackend)(t).data,
            c = n.has_disk,
            i = n.has_program,
            d = n.disk;
          return c
            ? i
              ? (0, o.createComponentVNode)(2, l, { program: d })
              : (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children: "Inserted disk has no program",
                })
            : (0, o.createComponentVNode)(2, a.NoticeBox, {
                children: "No disk inserted",
              });
        };
      t.NaniteDiskBox = i;
      var l = function (e, t) {
        var n = e.program,
          r = n.name,
          c = n.desc,
          i = n.activated,
          l = n.use_rate,
          d = n.can_trigger,
          u = n.trigger_cost,
          s = n.trigger_cooldown,
          m = n.activation_code,
          p = n.deactivation_code,
          C = n.kill_code,
          h = n.trigger_code,
          N = n.timer_restart,
          V = n.timer_shutdown,
          b = n.timer_trigger,
          f = n.timer_trigger_delay,
          g = n.extra_settings || [];
        return (0, o.createComponentVNode)(2, a.Section, {
          title: r,
          level: 2,
          buttons: (0, o.createComponentVNode)(2, a.Box, {
            inline: !0,
            bold: !0,
            color: i ? "good" : "bad",
            children: i ? "Activated" : "Deactivated",
          }),
          children: [
            (0, o.createComponentVNode)(2, a.Grid, {
              children: [
                (0, o.createComponentVNode)(2, a.Grid.Column, {
                  mr: 1,
                  children: c,
                }),
                (0, o.createComponentVNode)(2, a.Grid.Column, {
                  size: 0.5,
                  children: (0, o.createComponentVNode)(2, a.LabeledList, {
                    children: [
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Use Rate",
                        children: l,
                      }),
                      !!d &&
                        (0, o.createFragment)(
                          [
                            (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                              label: "Trigger Cost",
                              children: u,
                            }),
                            (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                              label: "Trigger Cooldown",
                              children: s,
                            }),
                          ],
                          4
                        ),
                    ],
                  }),
                }),
              ],
            }),
            (0, o.createComponentVNode)(2, a.Grid, {
              children: [
                (0, o.createComponentVNode)(2, a.Grid.Column, {
                  children: (0, o.createComponentVNode)(2, a.Section, {
                    title: "Codes",
                    level: 3,
                    mr: 1,
                    children: (0, o.createComponentVNode)(2, a.LabeledList, {
                      children: [
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Activation",
                          children: m,
                        }),
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Deactivation",
                          children: p,
                        }),
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Kill",
                          children: C,
                        }),
                        !!d &&
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Trigger",
                            children: h,
                          }),
                      ],
                    }),
                  }),
                }),
                (0, o.createComponentVNode)(2, a.Grid.Column, {
                  children: (0, o.createComponentVNode)(2, a.Section, {
                    title: "Delays",
                    level: 3,
                    mr: 1,
                    children: (0, o.createComponentVNode)(2, a.LabeledList, {
                      children: [
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Restart",
                          children: [N, " s"],
                        }),
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Shutdown",
                          children: [V, " s"],
                        }),
                        !!d &&
                          (0, o.createFragment)(
                            [
                              (0, o.createComponentVNode)(
                                2,
                                a.LabeledList.Item,
                                { label: "Trigger", children: [b, " s"] }
                              ),
                              (0, o.createComponentVNode)(
                                2,
                                a.LabeledList.Item,
                                { label: "Trigger Delay", children: [f, " s"] }
                              ),
                            ],
                            4
                          ),
                      ],
                    }),
                  }),
                }),
              ],
            }),
            (0, o.createComponentVNode)(2, a.Section, {
              title: "Extra Settings",
              level: 3,
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: g.map(function (e) {
                  var t = {
                    number: (0, o.createFragment)([e.value, e.unit], 0),
                    text: e.value,
                    type: e.value,
                    boolean: e.value ? e.true_text : e.false_text,
                  };
                  return (0,
                  o.createComponentVNode)(2, a.LabeledList.Item, { label: e.name, children: t[e.type] }, e.name);
                }),
              }),
            }),
          ],
        });
      };
      t.NaniteInfoBox = l;
      var d = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act;
        return (n.data.cloud_backups || []).map(function (e) {
          return (0, o.createComponentVNode)(
            2,
            a.Button,
            {
              fluid: !0,
              content: "Backup #" + e.cloud_id,
              textAlign: "center",
              onClick: function () {
                return c("set_view", { view: e.cloud_id });
              },
            },
            e.cloud_id
          );
        });
      };
      t.NaniteCloudBackupList = d;
      var u = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          d = i.current_view,
          u = i.disk,
          s = i.has_program,
          m = i.cloud_backup,
          p = (u && u.can_rule) || !1;
        if (!m)
          return (0, o.createComponentVNode)(2, a.NoticeBox, {
            children: "ERROR: Backup not found",
          });
        var C = i.cloud_programs || [];
        return (0, o.createComponentVNode)(2, a.Section, {
          title: "Backup #" + d,
          level: 2,
          buttons:
            !!s &&
            (0, o.createComponentVNode)(2, a.Button, {
              icon: "upload",
              content: "Upload From Disk",
              color: "good",
              onClick: function () {
                return c("upload_program");
              },
            }),
          children: C.map(function (e) {
            var t = e.rules || [];
            return (0, o.createComponentVNode)(
              2,
              a.Collapsible,
              {
                title: e.name,
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: "minus-circle",
                  color: "bad",
                  onClick: function () {
                    return c("remove_program", { program_id: e.id });
                  },
                }),
                children: (0, o.createComponentVNode)(2, a.Section, {
                  children: [
                    (0, o.createComponentVNode)(2, l, { program: e }),
                    !!p &&
                      (0, o.createComponentVNode)(2, a.Section, {
                        mt: -2,
                        title: "Rules",
                        level: 2,
                        buttons: (0, o.createComponentVNode)(2, a.Button, {
                          icon: "plus",
                          content: "Add Rule from Disk",
                          color: "good",
                          onClick: function () {
                            return c("add_rule", { program_id: e.id });
                          },
                        }),
                        children: e.has_rules
                          ? t.map(function (t) {
                              return (0, o.createFragment)(
                                [
                                  (0, o.createComponentVNode)(2, a.Button, {
                                    icon: "minus-circle",
                                    color: "bad",
                                    onClick: function () {
                                      return c("remove_rule", {
                                        program_id: e.id,
                                        rule_id: t.id,
                                      });
                                    },
                                  }),
                                  t.display,
                                ],
                                0,
                                t.display
                              );
                            })
                          : (0, o.createComponentVNode)(2, a.Box, {
                              color: "bad",
                              children: "No Active Rules",
                            }),
                      }),
                  ],
                }),
              },
              e.name
            );
          }),
        });
      };
      t.NaniteCloudBackupDetails = u;
      t.NaniteCloudControl = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          s = n.data,
          m = s.has_disk,
          p = s.current_view,
          C = s.new_backup_id;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 375,
          height: 700,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Program Disk",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: "eject",
                  content: "Eject",
                  disabled: !m,
                  onClick: function () {
                    return l("eject");
                  },
                }),
                children: (0, o.createComponentVNode)(2, i),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Cloud Storage",
                buttons: p
                  ? (0, o.createComponentVNode)(2, a.Button, {
                      icon: "arrow-left",
                      content: "Return",
                      onClick: function () {
                        return l("set_view", { view: 0 });
                      },
                    })
                  : (0, o.createFragment)(
                      [
                        "New Backup: ",
                        (0, o.createComponentVNode)(2, a.NumberInput, {
                          value: C,
                          minValue: 1,
                          maxValue: 100,
                          stepPixelSize: 4,
                          width: "39px",
                          onChange: function (e, t) {
                            return l("update_new_backup_value", { value: t });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "plus",
                          onClick: function () {
                            return l("create_backup");
                          },
                        }),
                      ],
                      0
                    ),
                children: s.current_view
                  ? (0, o.createComponentVNode)(2, u)
                  : (0, o.createComponentVNode)(2, d),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NaniteProgramHub = void 0);
      var o = n(0),
        r = n(21),
        a = n(2),
        c = n(1),
        i = n(3);
      t.NaniteProgramHub = function (e, t) {
        var n = (0, a.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.detail_view,
          s = d.disk,
          m = d.has_disk,
          p = d.has_program,
          C = d.programs,
          h = void 0 === C ? {} : C,
          N = (0, a.useSharedState)(t, "category"),
          V = N[0],
          b = N[1],
          f = (h && h[V]) || [];
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 500,
          height: 700,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Program Disk",
                buttons: (0, o.createFragment)(
                  [
                    (0, o.createComponentVNode)(2, c.Button, {
                      icon: "eject",
                      content: "Eject",
                      onClick: function () {
                        return l("eject");
                      },
                    }),
                    (0, o.createComponentVNode)(2, c.Button, {
                      icon: "minus-circle",
                      content: "Delete Program",
                      onClick: function () {
                        return l("clear");
                      },
                    }),
                  ],
                  4
                ),
                children: m
                  ? p
                    ? (0, o.createComponentVNode)(2, c.LabeledList, {
                        children: [
                          (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                            label: "Program Name",
                            children: s.name,
                          }),
                          (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                            label: "Description",
                            children: s.desc,
                          }),
                        ],
                      })
                    : (0, o.createComponentVNode)(2, c.NoticeBox, {
                        children: "No Program Installed",
                      })
                  : (0, o.createComponentVNode)(2, c.NoticeBox, {
                      children: "Insert Disk",
                    }),
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Programs",
                buttons: (0, o.createFragment)(
                  [
                    (0, o.createComponentVNode)(2, c.Button, {
                      icon: u ? "info" : "list",
                      content: u ? "Detailed" : "Compact",
                      onClick: function () {
                        return l("toggle_details");
                      },
                    }),
                    (0, o.createComponentVNode)(2, c.Button, {
                      icon: "sync",
                      content: "Sync Research",
                      onClick: function () {
                        return l("refresh");
                      },
                    }),
                  ],
                  4
                ),
                children:
                  null !== h
                    ? (0, o.createComponentVNode)(2, c.Flex, {
                        children: [
                          (0, o.createComponentVNode)(2, c.Flex.Item, {
                            minWidth: "110px",
                            children: (0, o.createComponentVNode)(2, c.Tabs, {
                              vertical: !0,
                              children: (0, r.map)(function (e, t) {
                                var n = t.substring(0, t.length - 8);
                                return (0, o.createComponentVNode)(
                                  2,
                                  c.Tabs.Tab,
                                  {
                                    selected: t === V,
                                    onClick: function () {
                                      return b(t);
                                    },
                                    children: n,
                                  },
                                  t
                                );
                              })(h),
                            }),
                          }),
                          (0, o.createComponentVNode)(2, c.Flex.Item, {
                            grow: 1,
                            basis: 0,
                            children: u
                              ? f.map(function (e) {
                                  return (0, o.createComponentVNode)(
                                    2,
                                    c.Section,
                                    {
                                      title: e.name,
                                      level: 2,
                                      buttons: (0, o.createComponentVNode)(
                                        2,
                                        c.Button,
                                        {
                                          icon: "download",
                                          content: "Download",
                                          disabled: !m,
                                          onClick: function () {
                                            return l("download", {
                                              program_id: e.id,
                                            });
                                          },
                                        }
                                      ),
                                      children: e.desc,
                                    },
                                    e.id
                                  );
                                })
                              : (0, o.createComponentVNode)(2, c.LabeledList, {
                                  children: f.map(function (e) {
                                    return (0, o.createComponentVNode)(
                                      2,
                                      c.LabeledList.Item,
                                      {
                                        label: e.name,
                                        buttons: (0, o.createComponentVNode)(
                                          2,
                                          c.Button,
                                          {
                                            icon: "download",
                                            content: "Download",
                                            disabled: !m,
                                            onClick: function () {
                                              return l("download", {
                                                program_id: e.id,
                                              });
                                            },
                                          }
                                        ),
                                      },
                                      e.id
                                    );
                                  }),
                                }),
                          }),
                        ],
                      })
                    : (0, o.createComponentVNode)(2, c.NoticeBox, {
                        children:
                          "No nanite programs are currently researched.",
                      }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.NaniteProgrammerContent = t.NaniteProgrammer = t.NaniteExtraBoolean = t.NaniteExtraType = t.NaniteExtraText = t.NaniteExtraNumber = t.NaniteExtraEntry = t.NaniteDelays = t.NaniteCodes = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data;
          return (0, o.createComponentVNode)(2, a.Section, {
            title: "Codes",
            level: 3,
            mr: 1,
            children: (0, o.createComponentVNode)(2, a.LabeledList, {
              children: [
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Activation",
                  children: (0, o.createComponentVNode)(2, a.NumberInput, {
                    value: i.activation_code,
                    width: "47px",
                    minValue: 0,
                    maxValue: 9999,
                    onChange: function (e, t) {
                      return c("set_code", {
                        target_code: "activation",
                        code: t,
                      });
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Deactivation",
                  children: (0, o.createComponentVNode)(2, a.NumberInput, {
                    value: i.deactivation_code,
                    width: "47px",
                    minValue: 0,
                    maxValue: 9999,
                    onChange: function (e, t) {
                      return c("set_code", {
                        target_code: "deactivation",
                        code: t,
                      });
                    },
                  }),
                }),
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Kill",
                  children: (0, o.createComponentVNode)(2, a.NumberInput, {
                    value: i.kill_code,
                    width: "47px",
                    minValue: 0,
                    maxValue: 9999,
                    onChange: function (e, t) {
                      return c("set_code", { target_code: "kill", code: t });
                    },
                  }),
                }),
                !!i.can_trigger &&
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Trigger",
                    children: (0, o.createComponentVNode)(2, a.NumberInput, {
                      value: i.trigger_code,
                      width: "47px",
                      minValue: 0,
                      maxValue: 9999,
                      onChange: function (e, t) {
                        return c("set_code", {
                          target_code: "trigger",
                          code: t,
                        });
                      },
                    }),
                  }),
              ],
            }),
          });
        };
      t.NaniteCodes = i;
      var l = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data;
        return (0, o.createComponentVNode)(2, a.Section, {
          title: "Delays",
          level: 3,
          ml: 1,
          children: (0, o.createComponentVNode)(2, a.LabeledList, {
            children: [
              (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                label: "Restart Timer",
                children: (0, o.createComponentVNode)(2, a.NumberInput, {
                  value: i.timer_restart,
                  unit: "s",
                  width: "57px",
                  minValue: 0,
                  maxValue: 3600,
                  onChange: function (e, t) {
                    return c("set_restart_timer", { delay: t });
                  },
                }),
              }),
              (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                label: "Shutdown Timer",
                children: (0, o.createComponentVNode)(2, a.NumberInput, {
                  value: i.timer_shutdown,
                  unit: "s",
                  width: "57px",
                  minValue: 0,
                  maxValue: 3600,
                  onChange: function (e, t) {
                    return c("set_shutdown_timer", { delay: t });
                  },
                }),
              }),
              !!i.can_trigger &&
                (0, o.createFragment)(
                  [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Trigger Repeat Timer",
                      children: (0, o.createComponentVNode)(2, a.NumberInput, {
                        value: i.timer_trigger,
                        unit: "s",
                        width: "57px",
                        minValue: 0,
                        maxValue: 3600,
                        onChange: function (e, t) {
                          return c("set_trigger_timer", { delay: t });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Trigger Delay",
                      children: (0, o.createComponentVNode)(2, a.NumberInput, {
                        value: i.timer_trigger_delay,
                        unit: "s",
                        width: "57px",
                        minValue: 0,
                        maxValue: 3600,
                        onChange: function (e, t) {
                          return c("set_timer_trigger_delay", { delay: t });
                        },
                      }),
                    }),
                  ],
                  4
                ),
            ],
          }),
        });
      };
      t.NaniteDelays = l;
      var d = function (e, t) {
        var n = e.extra_setting,
          r = n.name,
          c = n.type,
          i = {
            number: (0, o.createComponentVNode)(2, u, { extra_setting: n }),
            text: (0, o.createComponentVNode)(2, s, { extra_setting: n }),
            type: (0, o.createComponentVNode)(2, m, { extra_setting: n }),
            boolean: (0, o.createComponentVNode)(2, p, { extra_setting: n }),
          };
        return (0, o.createComponentVNode)(2, a.LabeledList.Item, {
          label: r,
          children: i[c],
        });
      };
      t.NaniteExtraEntry = d;
      var u = function (e, t) {
        var n = e.extra_setting,
          c = (0, r.useBackend)(t).act,
          i = n.name,
          l = n.value,
          d = n.min,
          u = n.max,
          s = n.unit;
        return (0, o.createComponentVNode)(2, a.NumberInput, {
          value: l,
          width: "64px",
          minValue: d,
          maxValue: u,
          unit: s,
          onChange: function (e, t) {
            return c("set_extra_setting", { target_setting: i, value: t });
          },
        });
      };
      t.NaniteExtraNumber = u;
      var s = function (e, t) {
        var n = e.extra_setting,
          c = (0, r.useBackend)(t).act,
          i = n.name,
          l = n.value;
        return (0, o.createComponentVNode)(2, a.Input, {
          value: l,
          width: "200px",
          onInput: function (e, t) {
            return c("set_extra_setting", { target_setting: i, value: t });
          },
        });
      };
      t.NaniteExtraText = s;
      var m = function (e, t) {
        var n = e.extra_setting,
          c = (0, r.useBackend)(t).act,
          i = n.name,
          l = n.value,
          d = n.types;
        return (0, o.createComponentVNode)(2, a.Dropdown, {
          over: !0,
          selected: l,
          width: "150px",
          options: d,
          onSelected: function (e) {
            return c("set_extra_setting", { target_setting: i, value: e });
          },
        });
      };
      t.NaniteExtraType = m;
      var p = function (e, t) {
        var n = e.extra_setting,
          c = (0, r.useBackend)(t).act,
          i = n.name,
          l = n.value,
          d = n.true_text,
          u = n.false_text;
        return (0, o.createComponentVNode)(2, a.Button.Checkbox, {
          content: l ? d : u,
          checked: l,
          onClick: function () {
            return c("set_extra_setting", { target_setting: i });
          },
        });
      };
      t.NaniteExtraBoolean = p;
      t.NaniteProgrammer = function (e, t) {
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 420,
          height: 550,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, C),
          }),
        });
      };
      var C = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          u = n.data,
          s = u.has_disk,
          m = u.has_program,
          p = u.name,
          C = u.desc,
          h = u.use_rate,
          N = u.can_trigger,
          V = u.trigger_cost,
          b = u.trigger_cooldown,
          f = u.activated,
          g = u.has_extra_settings,
          v = u.extra_settings,
          k = void 0 === v ? {} : v;
        return s
          ? m
            ? (0, o.createComponentVNode)(2, a.Section, {
                title: p,
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: "eject",
                  content: "Eject",
                  onClick: function () {
                    return c("eject");
                  },
                }),
                children: [
                  (0, o.createComponentVNode)(2, a.Section, {
                    title: "Info",
                    level: 2,
                    children: (0, o.createComponentVNode)(2, a.Grid, {
                      children: [
                        (0, o.createComponentVNode)(2, a.Grid.Column, {
                          children: C,
                        }),
                        (0, o.createComponentVNode)(2, a.Grid.Column, {
                          size: 0.7,
                          children: (0, o.createComponentVNode)(
                            2,
                            a.LabeledList,
                            {
                              children: [
                                (0, o.createComponentVNode)(
                                  2,
                                  a.LabeledList.Item,
                                  { label: "Use Rate", children: h }
                                ),
                                !!N &&
                                  (0, o.createFragment)(
                                    [
                                      (0, o.createComponentVNode)(
                                        2,
                                        a.LabeledList.Item,
                                        { label: "Trigger Cost", children: V }
                                      ),
                                      (0, o.createComponentVNode)(
                                        2,
                                        a.LabeledList.Item,
                                        {
                                          label: "Trigger Cooldown",
                                          children: b,
                                        }
                                      ),
                                    ],
                                    4
                                  ),
                              ],
                            }
                          ),
                        }),
                      ],
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.Section, {
                    title: "Settings",
                    level: 2,
                    buttons: (0, o.createComponentVNode)(2, a.Button, {
                      icon: f ? "power-off" : "times",
                      content: f ? "Active" : "Inactive",
                      selected: f,
                      color: "bad",
                      bold: !0,
                      onClick: function () {
                        return c("toggle_active");
                      },
                    }),
                    children: [
                      (0, o.createComponentVNode)(2, a.Grid, {
                        children: [
                          (0, o.createComponentVNode)(2, a.Grid.Column, {
                            children: (0, o.createComponentVNode)(2, i),
                          }),
                          (0, o.createComponentVNode)(2, a.Grid.Column, {
                            children: (0, o.createComponentVNode)(2, l),
                          }),
                        ],
                      }),
                      !!g &&
                        (0, o.createComponentVNode)(2, a.Section, {
                          title: "Special",
                          level: 3,
                          children: (0, o.createComponentVNode)(
                            2,
                            a.LabeledList,
                            {
                              children: k.map(function (e) {
                                return (0,
                                o.createComponentVNode)(2, d, { extra_setting: e }, e.name);
                              }),
                            }
                          ),
                        }),
                    ],
                  }),
                ],
              })
            : (0, o.createComponentVNode)(2, a.Section, {
                title: "Blank Disk",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: "eject",
                  content: "Eject",
                  onClick: function () {
                    return c("eject");
                  },
                }),
              })
          : (0, o.createComponentVNode)(2, a.NoticeBox, {
              textAlign: "center",
              children: "Insert a nanite program disk",
            });
      };
      t.NaniteProgrammerContent = C;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NaniteRemoteContent = t.NaniteRemote = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.NaniteRemote = function (e, t) {
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 420,
          height: 500,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, i),
          }),
        });
      };
      var i = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          l = i.code,
          d = i.locked,
          u = i.mode,
          s = i.program_name,
          m = i.relay_code,
          p = i.comms,
          C = i.message,
          h = i.saved_settings,
          N = void 0 === h ? [] : h;
        return d
          ? (0, o.createComponentVNode)(2, a.NoticeBox, {
              children: "This interface is locked.",
            })
          : (0, o.createFragment)(
              [
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "Nanite Control",
                  buttons: (0, o.createComponentVNode)(2, a.Button, {
                    icon: "lock",
                    content: "Lock Interface",
                    onClick: function () {
                      return c("lock");
                    },
                  }),
                  children: (0, o.createComponentVNode)(2, a.LabeledList, {
                    children: [
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Name",
                        children: [
                          (0, o.createComponentVNode)(2, a.Input, {
                            value: s,
                            maxLength: 14,
                            width: "130px",
                            onChange: function (e, t) {
                              return c("update_name", { name: t });
                            },
                          }),
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "save",
                            content: "Save",
                            onClick: function () {
                              return c("save");
                            },
                          }),
                        ],
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: p ? "Comm Code" : "Signal Code",
                        children: (0, o.createComponentVNode)(
                          2,
                          a.NumberInput,
                          {
                            value: l,
                            minValue: 0,
                            maxValue: 9999,
                            width: "47px",
                            step: 1,
                            stepPixelSize: 2,
                            onChange: function (e, t) {
                              return c("set_code", { code: t });
                            },
                          }
                        ),
                      }),
                      !!p &&
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Message",
                          children: (0, o.createComponentVNode)(2, a.Input, {
                            value: C,
                            width: "270px",
                            onChange: function (e, t) {
                              return c("set_message", { value: t });
                            },
                          }),
                        }),
                      "Relay" === u &&
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Relay Code",
                          children: (0, o.createComponentVNode)(
                            2,
                            a.NumberInput,
                            {
                              value: m,
                              minValue: 0,
                              maxValue: 9999,
                              width: "47px",
                              step: 1,
                              stepPixelSize: 2,
                              onChange: function (e, t) {
                                return c("set_relay_code", { code: t });
                              },
                            }
                          ),
                        }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Signal Mode",
                        children: [
                          "Off",
                          "Local",
                          "Targeted",
                          "Area",
                          "Relay",
                        ].map(function (e) {
                          return (0, o.createComponentVNode)(
                            2,
                            a.Button,
                            {
                              content: e,
                              selected: u === e,
                              onClick: function () {
                                return c("select_mode", { mode: e });
                              },
                            },
                            e
                          );
                        }),
                      }),
                    ],
                  }),
                }),
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "Saved Settings",
                  children:
                    N.length > 0
                      ? (0, o.createComponentVNode)(2, a.Table, {
                          children: [
                            (0, o.createComponentVNode)(2, a.Table.Row, {
                              header: !0,
                              children: [
                                (0, o.createComponentVNode)(2, a.Table.Cell, {
                                  width: "35%",
                                  children: "Name",
                                }),
                                (0, o.createComponentVNode)(2, a.Table.Cell, {
                                  width: "20%",
                                  children: "Mode",
                                }),
                                (0, o.createComponentVNode)(2, a.Table.Cell, {
                                  collapsing: !0,
                                  children: "Code",
                                }),
                                (0, o.createComponentVNode)(2, a.Table.Cell, {
                                  collapsing: !0,
                                  children: "Relay",
                                }),
                              ],
                            }),
                            N.map(function (e) {
                              return (0, o.createComponentVNode)(
                                2,
                                a.Table.Row,
                                {
                                  className: "candystripe",
                                  children: [
                                    (0, o.createComponentVNode)(
                                      2,
                                      a.Table.Cell,
                                      {
                                        bold: !0,
                                        color: "label",
                                        children: [e.name, ":"],
                                      }
                                    ),
                                    (0, o.createComponentVNode)(
                                      2,
                                      a.Table.Cell,
                                      { children: e.mode }
                                    ),
                                    (0, o.createComponentVNode)(
                                      2,
                                      a.Table.Cell,
                                      { children: e.code }
                                    ),
                                    (0, o.createComponentVNode)(
                                      2,
                                      a.Table.Cell,
                                      {
                                        children:
                                          "Relay" === e.mode && e.relay_code,
                                      }
                                    ),
                                    (0, o.createComponentVNode)(
                                      2,
                                      a.Table.Cell,
                                      {
                                        textAlign: "right",
                                        children: [
                                          (0, o.createComponentVNode)(
                                            2,
                                            a.Button,
                                            {
                                              icon: "upload",
                                              color: "good",
                                              onClick: function () {
                                                return c("load", {
                                                  save_id: e.id,
                                                });
                                              },
                                            }
                                          ),
                                          (0, o.createComponentVNode)(
                                            2,
                                            a.Button,
                                            {
                                              icon: "minus",
                                              color: "bad",
                                              onClick: function () {
                                                return c("remove_save", {
                                                  save_id: e.id,
                                                });
                                              },
                                            }
                                          ),
                                        ],
                                      }
                                    ),
                                  ],
                                },
                                e.id
                              );
                            }),
                          ],
                        })
                      : (0, o.createComponentVNode)(2, a.NoticeBox, {
                          children: "No settings currently saved",
                        }),
                }),
              ],
              4
            );
      };
      t.NaniteRemoteContent = i;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NotificationPreferences = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.NotificationPreferences = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = (n.data.ignore || []).sort(function (e, t) {
            var n = e.desc.toLowerCase(),
              o = t.desc.toLowerCase();
            return n < o ? -1 : n > o ? 1 : 0;
          });
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 270,
          height: 360,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.Section, {
              title: "Ghost Role Notifications",
              children: l.map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  a.Button,
                  {
                    fluid: !0,
                    icon: e.enabled ? "times" : "check",
                    content: e.desc,
                    color: e.enabled ? "bad" : "good",
                    onClick: function () {
                      return i("toggle_ignore", { key: e.key });
                    },
                  },
                  e.key
                );
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtnetRelay = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.NtnetRelay = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.enabled,
          u = l.dos_capacity,
          s = l.dos_overload,
          m = l.dos_crashed;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 400,
          height: 300,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              title: "Network Buffer",
              buttons: (0, o.createComponentVNode)(2, a.Button, {
                icon: "power-off",
                selected: d,
                content: d ? "ENABLED" : "DISABLED",
                onClick: function () {
                  return i("toggle");
                },
              }),
              children: m
                ? (0, o.createComponentVNode)(2, a.Box, {
                    fontFamily: "monospace",
                    children: [
                      (0, o.createComponentVNode)(2, a.Box, {
                        fontSize: "20px",
                        children: "NETWORK BUFFER OVERFLOW",
                      }),
                      (0, o.createComponentVNode)(2, a.Box, {
                        fontSize: "16px",
                        children: "OVERLOAD RECOVERY MODE",
                      }),
                      (0, o.createComponentVNode)(2, a.Box, {
                        children:
                          "This system is suffering temporary outage due to overflow of traffic buffers. Until buffered traffic is processed, all further requests will be dropped. Frequent occurences of this error may indicate insufficient hardware capacity of your network. Please contact your network planning department for instructions on how to resolve this issue.",
                      }),
                      (0, o.createComponentVNode)(2, a.Box, {
                        fontSize: "20px",
                        color: "bad",
                        children: "ADMINISTRATOR OVERRIDE",
                      }),
                      (0, o.createComponentVNode)(2, a.Box, {
                        fontSize: "16px",
                        color: "bad",
                        children: "CAUTION - DATA LOSS MAY OCCUR",
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        icon: "signal",
                        content: "PURGE BUFFER",
                        mt: 1,
                        color: "bad",
                        onClick: function () {
                          return i("restart");
                        },
                      }),
                    ],
                  })
                : (0, o.createComponentVNode)(2, a.ProgressBar, {
                    value: s,
                    minValue: 0,
                    maxValue: u,
                    children: [
                      (0, o.createComponentVNode)(2, a.AnimatedNumber, {
                        value: s,
                      }),
                      " GQ",
                      " / ",
                      u,
                      " GQ",
                    ],
                  }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosAiRestorer = void 0);
      var o = n(0),
        r = n(3),
        a = n(203);
      t.NtosAiRestorer = function () {
        return (0, o.createComponentVNode)(2, r.NtosWindow, {
          resizable: !0,
          width: 360,
          height: 400,
          children: (0, o.createComponentVNode)(2, r.NtosWindow.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.AiRestorerContent),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosArcade = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.NtosArcade = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          width: 450,
          height: 350,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              title: "Outbomb Cuban Pete Ultra",
              textAlign: "center",
              children: [
                (0, o.createComponentVNode)(2, a.Box, {
                  children: [
                    (0, o.createComponentVNode)(2, a.Grid, {
                      children: [
                        (0, o.createComponentVNode)(2, a.Grid.Column, {
                          size: 2,
                          children: [
                            (0, o.createComponentVNode)(2, a.Box, { m: 1 }),
                            (0, o.createComponentVNode)(2, a.LabeledList, {
                              children: [
                                (0, o.createComponentVNode)(
                                  2,
                                  a.LabeledList.Item,
                                  {
                                    label: "Player Health",
                                    children: (0, o.createComponentVNode)(
                                      2,
                                      a.ProgressBar,
                                      {
                                        value: l.PlayerHitpoints,
                                        minValue: 0,
                                        maxValue: 30,
                                        ranges: {
                                          olive: [31, Infinity],
                                          good: [20, 31],
                                          average: [10, 20],
                                          bad: [-Infinity, 10],
                                        },
                                        children: [l.PlayerHitpoints, "HP"],
                                      }
                                    ),
                                  }
                                ),
                                (0, o.createComponentVNode)(
                                  2,
                                  a.LabeledList.Item,
                                  {
                                    label: "Player Magic",
                                    children: (0, o.createComponentVNode)(
                                      2,
                                      a.ProgressBar,
                                      {
                                        value: l.PlayerMP,
                                        minValue: 0,
                                        maxValue: 10,
                                        ranges: {
                                          purple: [11, Infinity],
                                          violet: [3, 11],
                                          bad: [-Infinity, 3],
                                        },
                                        children: [l.PlayerMP, "MP"],
                                      }
                                    ),
                                  }
                                ),
                              ],
                            }),
                            (0, o.createComponentVNode)(2, a.Box, {
                              my: 1,
                              mx: 4,
                            }),
                            (0, o.createComponentVNode)(2, a.Section, {
                              backgroundColor:
                                1 === l.PauseState ? "#1b3622" : "#471915",
                              children: l.Status,
                            }),
                          ],
                        }),
                        (0, o.createComponentVNode)(2, a.Grid.Column, {
                          children: [
                            (0, o.createComponentVNode)(2, a.ProgressBar, {
                              value: l.Hitpoints,
                              minValue: 0,
                              maxValue: 45,
                              ranges: {
                                good: [30, Infinity],
                                average: [5, 30],
                                bad: [-Infinity, 5],
                              },
                              children: [
                                (0, o.createComponentVNode)(
                                  2,
                                  a.AnimatedNumber,
                                  { value: l.Hitpoints }
                                ),
                                "HP",
                              ],
                            }),
                            (0, o.createComponentVNode)(2, a.Box, { m: 1 }),
                            (0, o.createComponentVNode)(2, a.Section, {
                              inline: !0,
                              width: "156px",
                              textAlign: "center",
                              children: (0, o.createVNode)(
                                1,
                                "img",
                                null,
                                null,
                                1,
                                { src: l.BossID }
                              ),
                            }),
                          ],
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.Box, { my: 1, mx: 4 }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      icon: "fist-raised",
                      tooltip: "Go in for the kill!",
                      tooltipPosition: "top",
                      disabled: 0 === l.GameActive || 1 === l.PauseState,
                      onClick: function () {
                        return i("Attack");
                      },
                      content: "Attack!",
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      icon: "band-aid",
                      tooltip: "Heal yourself!",
                      tooltipPosition: "top",
                      disabled: 0 === l.GameActive || 1 === l.PauseState,
                      onClick: function () {
                        return i("Heal");
                      },
                      content: "Heal!",
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      icon: "magic",
                      tooltip: "Recharge your magic!",
                      tooltipPosition: "top",
                      disabled: 0 === l.GameActive || 1 === l.PauseState,
                      onClick: function () {
                        return i("Recharge_Power");
                      },
                      content: "Recharge!",
                    }),
                  ],
                }),
                (0, o.createComponentVNode)(2, a.Box, {
                  children: (0, o.createComponentVNode)(2, a.Button, {
                    icon: "sync-alt",
                    tooltip: "One more game couldn't hurt.",
                    tooltipPosition: "top",
                    disabled: 1 === l.GameActive,
                    onClick: function () {
                      return i("Start_Game");
                    },
                    content: "Begin Game",
                  }),
                }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosAtmos = void 0);
      var o = n(0),
        r = n(21),
        a = n(50),
        c = n(8),
        i = n(2),
        l = n(1),
        d = n(44),
        u = n(3);
      t.NtosAtmos = function (e, t) {
        var n = (0, i.useBackend)(t),
          s = (n.act, n.data),
          m = s.AirTemp,
          p = s.AirPressure,
          C = (0, a.flow)([
            (0, r.filter)(function (e) {
              return e.percentage >= 0.01;
            }),
            (0, r.sortBy)(function (e) {
              return -e.percentage;
            }),
          ])(s.AirData || []),
          h = Math.max.apply(
            Math,
            [1].concat(
              C.map(function (e) {
                return e.percentage;
              })
            )
          );
        return (0, o.createComponentVNode)(2, u.NtosWindow, {
          resizable: !0,
          width: 300,
          height: 350,
          children: (0, o.createComponentVNode)(2, u.NtosWindow.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, l.Section, {
                children: (0, o.createComponentVNode)(2, l.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, l.LabeledList.Item, {
                      label: "Temperature",
                      children: [m, "\xb0C"],
                    }),
                    (0, o.createComponentVNode)(2, l.LabeledList.Item, {
                      label: "Pressure",
                      children: [p, " kPa"],
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, l.Section, {
                children: (0, o.createComponentVNode)(2, l.LabeledList, {
                  children: C.map(function (e) {
                    return (0,
                    o.createComponentVNode)(2, l.LabeledList.Item, { label: (0, d.getGasLabel)(e.name), children: (0, o.createComponentVNode)(2, l.ProgressBar, { color: (0, d.getGasColor)(e.name), value: e.percentage, minValue: 0, maxValue: h, children: (0, c.toFixed)(e.percentage, 2) + "%" }) }, e.name);
                  }),
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosCardContent = t.NtosCard = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = n(204);
      t.NtosCard = function (e, t) {
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          resizable: !0,
          width: 450,
          height: 520,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, l),
          }),
        });
      };
      var l = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          l = n.data,
          d = (0, r.useLocalState)(t, "tab", 1),
          u = d[0],
          s = d[1],
          m = l.authenticated,
          p = l.regions,
          C = void 0 === p ? [] : p,
          h = l.access_on_card,
          N = void 0 === h ? [] : h,
          V = l.jobs,
          b = void 0 === V ? {} : V,
          f = l.id_rank,
          g = l.id_owner,
          v = l.has_id,
          k = l.have_printer,
          w = l.have_id_slot,
          B = l.id_name,
          x = (0, r.useLocalState)(t, "department", Object.keys(b)[0]),
          _ = x[0],
          L = x[1];
        if (!w)
          return (0, o.createComponentVNode)(2, a.NoticeBox, {
            children: "This program requires an ID slot in order to function",
          });
        var y = b[_] || [];
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, a.Section, {
              title:
                v && m
                  ? (0, o.createComponentVNode)(2, a.Input, {
                      value: g,
                      width: "250px",
                      onInput: function (e, t) {
                        return c("PRG_edit", { name: t });
                      },
                    })
                  : g || "No Card Inserted",
              buttons: (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: "print",
                    content: "Print",
                    disabled: !k || !v,
                    onClick: function () {
                      return c("PRG_print");
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: m ? "sign-out-alt" : "sign-in-alt",
                    content: m ? "Log Out" : "Log In",
                    color: m ? "bad" : "good",
                    onClick: function () {
                      c(m ? "PRG_logout" : "PRG_authenticate");
                    },
                  }),
                ],
                4
              ),
              children: (0, o.createComponentVNode)(2, a.Button, {
                fluid: !0,
                icon: "eject",
                content: B,
                onClick: function () {
                  return c("PRG_eject");
                },
              }),
            }),
            !!v &&
              !!m &&
              (0, o.createComponentVNode)(2, a.Box, {
                children: [
                  (0, o.createComponentVNode)(2, a.Tabs, {
                    children: [
                      (0, o.createComponentVNode)(2, a.Tabs.Tab, {
                        selected: 1 === u,
                        onClick: function () {
                          return s(1);
                        },
                        children: "Access",
                      }),
                      (0, o.createComponentVNode)(2, a.Tabs.Tab, {
                        selected: 2 === u,
                        onClick: function () {
                          return s(2);
                        },
                        children: "Jobs",
                      }),
                    ],
                  }),
                  1 === u &&
                    (0, o.createComponentVNode)(2, i.AccessList, {
                      accesses: C,
                      selectedList: N,
                      accessMod: function (e) {
                        return c("PRG_access", { access_target: e });
                      },
                      grantAll: function () {
                        return c("PRG_grantall");
                      },
                      denyAll: function () {
                        return c("PRG_denyall");
                      },
                      grantDep: function (e) {
                        return c("PRG_grantregion", { region: e });
                      },
                      denyDep: function (e) {
                        return c("PRG_denyregion", { region: e });
                      },
                    }),
                  2 === u &&
                    (0, o.createComponentVNode)(2, a.Section, {
                      title: f,
                      buttons: (0, o.createComponentVNode)(
                        2,
                        a.Button.Confirm,
                        {
                          icon: "exclamation-triangle",
                          content: "Terminate",
                          color: "bad",
                          onClick: function () {
                            return c("PRG_terminate");
                          },
                        }
                      ),
                      children: [
                        (0, o.createComponentVNode)(2, a.Button.Input, {
                          fluid: !0,
                          content: "Custom...",
                          onCommit: function (e, t) {
                            return c("PRG_assign", {
                              assign_target: "Custom",
                              custom_name: t,
                            });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Flex, {
                          children: [
                            (0, o.createComponentVNode)(2, a.Flex.Item, {
                              children: (0, o.createComponentVNode)(2, a.Tabs, {
                                vertical: !0,
                                children: Object.keys(b).map(function (e) {
                                  return (0, o.createComponentVNode)(
                                    2,
                                    a.Tabs.Tab,
                                    {
                                      selected: e === _,
                                      onClick: function () {
                                        return L(e);
                                      },
                                      children: e,
                                    },
                                    e
                                  );
                                }),
                              }),
                            }),
                            (0, o.createComponentVNode)(2, a.Flex.Item, {
                              grow: 1,
                              children: y.map(function (e) {
                                return (0, o.createComponentVNode)(
                                  2,
                                  a.Button,
                                  {
                                    fluid: !0,
                                    content: e.display_name,
                                    onClick: function () {
                                      return c("PRG_assign", {
                                        assign_target: e.job,
                                      });
                                    },
                                  },
                                  e.job
                                );
                              }),
                            }),
                          ],
                        }),
                      ],
                    }),
                ],
              }),
          ],
          0
        );
      };
      t.NtosCardContent = l;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosConfiguration = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.NtosConfiguration = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.power_usage,
          u = l.battery_exists,
          s = l.battery,
          m = void 0 === s ? {} : s,
          p = l.disk_size,
          C = l.disk_used,
          h = l.hardware,
          N = void 0 === h ? [] : h;
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          resizable: !0,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Power Supply",
                buttons: (0, o.createComponentVNode)(2, a.Box, {
                  inline: !0,
                  bold: !0,
                  mr: 1,
                  children: ["Power Draw: ", d, "W"],
                }),
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Battery Status",
                    color: !u && "average",
                    children: u
                      ? (0, o.createComponentVNode)(2, a.ProgressBar, {
                          value: m.charge,
                          minValue: 0,
                          maxValue: m.max,
                          ranges: {
                            good: [m.max / 2, Infinity],
                            average: [m.max / 4, m.max / 2],
                            bad: [-Infinity, m.max / 4],
                          },
                          children: [m.charge, " / ", m.max],
                        })
                      : "Not Available",
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "File System",
                children: (0, o.createComponentVNode)(2, a.ProgressBar, {
                  value: C,
                  minValue: 0,
                  maxValue: p,
                  color: "good",
                  children: [C, " GQ / ", p, " GQ"],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Hardware Components",
                children: N.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    a.Section,
                    {
                      title: e.name,
                      level: 2,
                      buttons: (0, o.createFragment)(
                        [
                          !e.critical &&
                            (0, o.createComponentVNode)(2, a.Button.Checkbox, {
                              content: "Enabled",
                              checked: e.enabled,
                              mr: 1,
                              onClick: function () {
                                return i("PC_toggle_component", {
                                  name: e.name,
                                });
                              },
                            }),
                          (0, o.createComponentVNode)(2, a.Box, {
                            inline: !0,
                            bold: !0,
                            mr: 1,
                            children: ["Power Usage: ", e.powerusage, "W"],
                          }),
                        ],
                        0
                      ),
                      children: e.desc,
                    },
                    e.name
                  );
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosCrewManifest = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(21),
        i = n(3);
      t.NtosCrewManifest = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.have_printer,
          s = d.manifest,
          m = void 0 === s ? {} : s;
        return (0, o.createComponentVNode)(2, i.NtosWindow, {
          resizable: !0,
          width: 400,
          height: 480,
          children: (0, o.createComponentVNode)(2, i.NtosWindow.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.Section, {
              title: "Crew Manifest",
              buttons: (0, o.createComponentVNode)(2, a.Button, {
                icon: "print",
                content: "Print",
                disabled: !u,
                onClick: function () {
                  return l("PRG_print");
                },
              }),
              children: (0, c.map)(function (e, t) {
                return (0, o.createComponentVNode)(
                  2,
                  a.Section,
                  {
                    level: 2,
                    title: t,
                    children: (0, o.createComponentVNode)(2, a.Table, {
                      children: e.map(function (e) {
                        return (0,
                        o.createComponentVNode)(2, a.Table.Row, { className: "candystripe", children: [(0, o.createComponentVNode)(2, a.Table.Cell, { bold: !0, children: e.name }), (0, o.createComponentVNode)(2, a.Table.Cell, { children: ["(", e.rank, ")"] })] }, e.name);
                      }),
                    }),
                  },
                  t
                );
              })(m),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.NtosCyborgRemoteMonitorContent = t.NtosCyborgRemoteMonitor = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.NtosCyborgRemoteMonitor = function (e, t) {
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          resizable: !0,
          width: 600,
          height: 800,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, i),
          }),
        });
      };
      var i = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          l = i.card,
          d = i.cyborgs,
          u = void 0 === d ? [] : d;
        return u.length
          ? (0, o.createFragment)(
              [
                !l &&
                  (0, o.createComponentVNode)(2, a.NoticeBox, {
                    children: "Certain features require an ID card login.",
                  }),
                u.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    a.Section,
                    {
                      title: e.name,
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: "terminal",
                        content: "Send Message",
                        color: "blue",
                        disabled: !l,
                        onClick: function () {
                          return c("messagebot", { ref: e.ref });
                        },
                      }),
                      children: (0, o.createComponentVNode)(2, a.LabeledList, {
                        children: [
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Status",
                            children: (0, o.createComponentVNode)(2, a.Box, {
                              color: e.status
                                ? "bad"
                                : e.locked_down
                                ? "average"
                                : "good",
                              children: e.status
                                ? "Not Responding"
                                : e.locked_down
                                ? "Locked Down"
                                : e.shell_discon
                                ? "Nominal/Disconnected"
                                : "Nominal",
                            }),
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Charge",
                            children: (0, o.createComponentVNode)(2, a.Box, {
                              color:
                                e.charge <= 30
                                  ? "bad"
                                  : e.charge <= 70
                                  ? "average"
                                  : "good",
                              children:
                                "number" == typeof e.charge
                                  ? e.charge + "%"
                                  : "Not Found",
                            }),
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Module",
                            children: e.module,
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Upgrades",
                            children: e.upgrades,
                          }),
                        ],
                      }),
                    },
                    e.ref
                  );
                }),
              ],
              0
            )
          : (0, o.createComponentVNode)(2, a.NoticeBox, {
              children: "No cyborg units detected.",
            });
      };
      t.NtosCyborgRemoteMonitorContent = i;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosFileManager = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.NtosFileManager = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.usbconnected,
          s = d.files,
          m = void 0 === s ? [] : s,
          p = d.usbfiles,
          C = void 0 === p ? [] : p;
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          resizable: !0,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, i, {
                  files: m,
                  usbconnected: u,
                  onUpload: function (e) {
                    return l("PRG_copytousb", { name: e });
                  },
                  onDelete: function (e) {
                    return l("PRG_deletefile", { name: e });
                  },
                  onRename: function (e, t) {
                    return l("PRG_rename", { name: e, new_name: t });
                  },
                  onDuplicate: function (e) {
                    return l("PRG_clone", { file: e });
                  },
                }),
              }),
              u &&
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "Data Disk",
                  children: (0, o.createComponentVNode)(2, i, {
                    usbmode: !0,
                    files: C,
                    usbconnected: u,
                    onUpload: function (e) {
                      return l("PRG_copyfromusb", { name: e });
                    },
                    onDelete: function (e) {
                      return l("PRG_deletefile", { name: e });
                    },
                    onRename: function (e, t) {
                      return l("PRG_rename", { name: e, new_name: t });
                    },
                    onDuplicate: function (e) {
                      return l("PRG_clone", { file: e });
                    },
                  }),
                }),
            ],
          }),
        });
      };
      var i = function (e) {
        var t = e.files,
          n = void 0 === t ? [] : t,
          r = e.usbconnected,
          c = e.usbmode,
          i = e.onUpload,
          l = e.onDelete,
          d = e.onRename;
        return (0, o.createComponentVNode)(2, a.Table, {
          children: [
            (0, o.createComponentVNode)(2, a.Table.Row, {
              header: !0,
              children: [
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  children: "File",
                }),
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  collapsing: !0,
                  children: "Type",
                }),
                (0, o.createComponentVNode)(2, a.Table.Cell, {
                  collapsing: !0,
                  children: "Size",
                }),
              ],
            }),
            n.map(function (e) {
              return (0, o.createComponentVNode)(
                2,
                a.Table.Row,
                {
                  className: "candystripe",
                  children: [
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      children: e.undeletable
                        ? e.name
                        : (0, o.createComponentVNode)(2, a.Button.Input, {
                            fluid: !0,
                            content: e.name,
                            currentValue: e.name,
                            tooltip: "Rename",
                            onCommit: function (t, n) {
                              return d(e.name, n);
                            },
                          }),
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      children: e.type,
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      children: e.size,
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      collapsing: !0,
                      children:
                        !e.undeletable &&
                        (0, o.createFragment)(
                          [
                            (0, o.createComponentVNode)(2, a.Button.Confirm, {
                              icon: "trash",
                              confirmIcon: "times",
                              confirmContent: "",
                              tooltip: "Delete",
                              onClick: function () {
                                return l(e.name);
                              },
                            }),
                            !!r &&
                              (c
                                ? (0, o.createComponentVNode)(2, a.Button, {
                                    icon: "download",
                                    tooltip: "Download",
                                    onClick: function () {
                                      return i(e.name);
                                    },
                                  })
                                : (0, o.createComponentVNode)(2, a.Button, {
                                    icon: "upload",
                                    tooltip: "Upload",
                                    onClick: function () {
                                      return i(e.name);
                                    },
                                  })),
                          ],
                          0
                        ),
                    }),
                  ],
                },
                e.name
              );
            }),
          ],
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.NtosJobManagerContent = t.NtosJobManager = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.NtosJobManager = function (e, t) {
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          resizable: !0,
          width: 400,
          height: 620,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, i),
          }),
        });
      };
      var i = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          l = i.authed,
          d = i.cooldown,
          u = i.slots,
          s = void 0 === u ? [] : u,
          m = i.prioritized,
          p = void 0 === m ? [] : m;
        return l
          ? (0, o.createComponentVNode)(2, a.Section, {
              children: [
                d > 0 &&
                  (0, o.createComponentVNode)(2, a.Dimmer, {
                    children: (0, o.createComponentVNode)(2, a.Box, {
                      bold: !0,
                      textAlign: "center",
                      fontSize: "20px",
                      children: ["On Cooldown: ", d, "s"],
                    }),
                  }),
                (0, o.createComponentVNode)(2, a.Table, {
                  children: [
                    (0, o.createComponentVNode)(2, a.Table.Row, {
                      header: !0,
                      children: [
                        (0, o.createComponentVNode)(2, a.Table.Cell, {
                          children: "Prioritized",
                        }),
                        (0, o.createComponentVNode)(2, a.Table.Cell, {
                          children: "Slots",
                        }),
                      ],
                    }),
                    s.map(function (e) {
                      return (0, o.createComponentVNode)(
                        2,
                        a.Table.Row,
                        {
                          className: "candystripe",
                          children: [
                            (0, o.createComponentVNode)(2, a.Table.Cell, {
                              bold: !0,
                              children: (0, o.createComponentVNode)(
                                2,
                                a.Button.Checkbox,
                                {
                                  fluid: !0,
                                  content: e.title,
                                  disabled: e.total <= 0,
                                  checked: e.total > 0 && p.includes(e.title),
                                  onClick: function () {
                                    return c("PRG_priority", {
                                      target: e.title,
                                    });
                                  },
                                }
                              ),
                            }),
                            (0, o.createComponentVNode)(2, a.Table.Cell, {
                              collapsing: !0,
                              children: [e.current, " / ", e.total],
                            }),
                            (0, o.createComponentVNode)(2, a.Table.Cell, {
                              collapsing: !0,
                              children: [
                                (0, o.createComponentVNode)(2, a.Button, {
                                  content: "Open",
                                  disabled: !e.status_open,
                                  onClick: function () {
                                    return c("PRG_open_job", {
                                      target: e.title,
                                    });
                                  },
                                }),
                                (0, o.createComponentVNode)(2, a.Button, {
                                  content: "Close",
                                  disabled: !e.status_close,
                                  onClick: function () {
                                    return c("PRG_close_job", {
                                      target: e.title,
                                    });
                                  },
                                }),
                              ],
                            }),
                          ],
                        },
                        e.title
                      );
                    }),
                  ],
                }),
              ],
            })
          : (0, o.createComponentVNode)(2, a.NoticeBox, {
              children:
                "Current ID does not have access permissions to change job slots.",
            });
      };
      t.NtosJobManagerContent = i;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosMain = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = {
          compconfig: "cog",
          ntndownloader: "download",
          filemanager: "folder",
          smmonitor: "radiation",
          alarmmonitor: "bell",
          cardmod: "id-card",
          arcade: "gamepad",
          ntnrc_client: "comment-alt",
          nttransfer: "exchange-alt",
          powermonitor: "plug",
          job_manage: "address-book",
          crewmani: "clipboard-list",
          robocontrol: "robot",
          atmosscan: "thermometer-half",
          shipping: "tags",
        };
      t.NtosMain = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.programs,
          s = void 0 === u ? [] : u,
          m = d.has_light,
          p = d.light_on,
          C = d.comp_light_color;
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          resizable: !0,
          width: 400,
          height: 500,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            scrollable: !0,
            children: [
              !!m &&
                (0, o.createComponentVNode)(2, a.Section, {
                  children: [
                    (0, o.createComponentVNode)(2, a.Button, {
                      width: "144px",
                      icon: "lightbulb",
                      selected: p,
                      onClick: function () {
                        return l("PC_toggle_light");
                      },
                      children: ["Flashlight: ", p ? "ON" : "OFF"],
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      ml: 1,
                      onClick: function () {
                        return l("PC_light_color");
                      },
                      children: [
                        "Color:",
                        (0, o.createComponentVNode)(2, a.ColorBox, {
                          ml: 1,
                          color: C,
                        }),
                      ],
                    }),
                  ],
                }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Programs",
                children: (0, o.createComponentVNode)(2, a.Table, {
                  children: s.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      a.Table.Row,
                      {
                        children: [
                          (0, o.createComponentVNode)(2, a.Table.Cell, {
                            children: (0, o.createComponentVNode)(2, a.Button, {
                              fluid: !0,
                              lineHeight: "24px",
                              color: "transparent",
                              icon: i[e.name] || "window-maximize-o",
                              content: e.desc,
                              onClick: function () {
                                return l("PC_runprogram", { name: e.name });
                              },
                            }),
                          }),
                          (0, o.createComponentVNode)(2, a.Table.Cell, {
                            collapsing: !0,
                            width: "18px",
                            children:
                              !!e.running &&
                              (0, o.createComponentVNode)(2, a.Button, {
                                lineHeight: "24px",
                                color: "transparent",
                                icon: "times",
                                tooltip: "Close program",
                                tooltipPosition: "left",
                                onClick: function () {
                                  return l("PC_killprogram", { name: e.name });
                                },
                              }),
                          }),
                        ],
                      },
                      e.name
                    );
                  }),
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosNetChat = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.NtosNetChat = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.can_admin,
          u = l.adminmode,
          s = l.authed,
          m = l.username,
          p = l.active_channel,
          C = l.is_operator,
          h = l.all_channels,
          N = void 0 === h ? [] : h,
          V = l.clients,
          b = void 0 === V ? [] : V,
          f = l.messages,
          g = void 0 === f ? [] : f,
          v = null !== p,
          k = s || u;
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          width: 900,
          height: 675,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              height: "600px",
              children: (0, o.createComponentVNode)(2, a.Table, {
                height: "580px",
                children: (0, o.createComponentVNode)(2, a.Table.Row, {
                  children: [
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      verticalAlign: "top",
                      style: { width: "200px" },
                      children: [
                        (0, o.createComponentVNode)(2, a.Box, {
                          height: "537px",
                          overflowY: "scroll",
                          children: [
                            (0, o.createComponentVNode)(2, a.Button.Input, {
                              fluid: !0,
                              content: "New Channel...",
                              onCommit: function (e, t) {
                                return i("PRG_newchannel", {
                                  new_channel_name: t,
                                });
                              },
                            }),
                            N.map(function (e) {
                              return (0, o.createComponentVNode)(
                                2,
                                a.Button,
                                {
                                  fluid: !0,
                                  content: e.chan,
                                  selected: e.id === p,
                                  color: "transparent",
                                  onClick: function () {
                                    return i("PRG_joinchannel", { id: e.id });
                                  },
                                },
                                e.chan
                              );
                            }),
                          ],
                        }),
                        (0, o.createComponentVNode)(2, a.Button.Input, {
                          fluid: !0,
                          mt: 1,
                          content: m + "...",
                          currentValue: m,
                          onCommit: function (e, t) {
                            return i("PRG_changename", { new_name: t });
                          },
                        }),
                        !!d &&
                          (0, o.createComponentVNode)(2, a.Button, {
                            fluid: !0,
                            bold: !0,
                            content: "ADMIN MODE: " + (u ? "ON" : "OFF"),
                            color: u ? "bad" : "good",
                            onClick: function () {
                              return i("PRG_toggleadmin");
                            },
                          }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      children: [
                        (0, o.createComponentVNode)(2, a.Box, {
                          height: "560px",
                          overflowY: "scroll",
                          children:
                            v &&
                            (k
                              ? g.map(function (e) {
                                  return (0,
                                  o.createComponentVNode)(2, a.Box, { children: e.msg }, e.msg);
                                })
                              : (0, o.createComponentVNode)(2, a.Box, {
                                  textAlign: "center",
                                  children: [
                                    (0, o.createComponentVNode)(2, a.Icon, {
                                      name: "exclamation-triangle",
                                      mt: 4,
                                      fontSize: "40px",
                                    }),
                                    (0, o.createComponentVNode)(2, a.Box, {
                                      mt: 1,
                                      bold: !0,
                                      fontSize: "18px",
                                      children:
                                        "THIS CHANNEL IS PASSWORD PROTECTED",
                                    }),
                                    (0, o.createComponentVNode)(2, a.Box, {
                                      mt: 1,
                                      children: "INPUT PASSWORD TO ACCESS",
                                    }),
                                  ],
                                })),
                        }),
                        (0, o.createComponentVNode)(2, a.Input, {
                          fluid: !0,
                          selfClear: !0,
                          mt: 1,
                          onEnter: function (e, t) {
                            return i("PRG_speak", { message: t });
                          },
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.Table.Cell, {
                      verticalAlign: "top",
                      style: { width: "150px" },
                      children: [
                        (0, o.createComponentVNode)(2, a.Box, {
                          height: "477px",
                          overflowY: "scroll",
                          children: b.map(function (e) {
                            return (0,
                            o.createComponentVNode)(2, a.Box, { children: e.name }, e.name);
                          }),
                        }),
                        v &&
                          k &&
                          (0, o.createFragment)(
                            [
                              (0, o.createComponentVNode)(2, a.Button.Input, {
                                fluid: !0,
                                content: "Save log...",
                                defaultValue: "new_log",
                                onCommit: function (e, t) {
                                  return i("PRG_savelog", { log_name: t });
                                },
                              }),
                              (0, o.createComponentVNode)(2, a.Button.Confirm, {
                                fluid: !0,
                                content: "Leave Channel",
                                onClick: function () {
                                  return i("PRG_leavechannel");
                                },
                              }),
                            ],
                            4
                          ),
                        !!C &&
                          s &&
                          (0, o.createFragment)(
                            [
                              (0, o.createComponentVNode)(2, a.Button.Confirm, {
                                fluid: !0,
                                content: "Delete Channel",
                                onClick: function () {
                                  return i("PRG_deletechannel");
                                },
                              }),
                              (0, o.createComponentVNode)(2, a.Button.Input, {
                                fluid: !0,
                                content: "Rename Channel...",
                                onCommit: function (e, t) {
                                  return i("PRG_renamechannel", {
                                    new_name: t,
                                  });
                                },
                              }),
                              (0, o.createComponentVNode)(2, a.Button.Input, {
                                fluid: !0,
                                content: "Set Password...",
                                onCommit: function (e, t) {
                                  return i("PRG_setpassword", {
                                    new_password: t,
                                  });
                                },
                              }),
                            ],
                            4
                          ),
                      ],
                    }),
                  ],
                }),
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosNetDosContent = t.NtosNetDos = void 0);
      var o = n(0),
        r = n(1),
        a = n(2),
        c = (n(24), n(3));
      t.NtosNetDos = function (e, t) {
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          theme: "syndicate",
          width: 400,
          height: 250,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            children: (0, o.createComponentVNode)(2, i),
          }),
        });
      };
      var i = function (e, t) {
        var n = (0, a.useBackend)(t),
          c = n.act,
          i = n.data,
          l = i.relays,
          d = void 0 === l ? [] : l,
          u = i.focus,
          s = i.target,
          m = i.speed,
          p = i.overload,
          C = i.capacity,
          h = i.error;
        if (h)
          return (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, r.NoticeBox, { children: h }),
              (0, o.createComponentVNode)(2, r.Button, {
                fluid: !0,
                content: "Reset",
                textAlign: "center",
                onClick: function () {
                  return c("PRG_reset");
                },
              }),
            ],
            4
          );
        var N = function (e) {
          for (var t = "", n = p / C; t.length < e; )
            Math.random() > n ? (t += "0") : (t += "1");
          return t;
        };
        return s
          ? (0, o.createComponentVNode)(2, r.Section, {
              fontFamily: "monospace",
              textAlign: "center",
              children: [
                (0, o.createComponentVNode)(2, r.Box, {
                  children: ["CURRENT SPEED: ", m, " GQ/s"],
                }),
                (0, o.createComponentVNode)(2, r.Box, { children: N(45) }),
                (0, o.createComponentVNode)(2, r.Box, { children: N(45) }),
                (0, o.createComponentVNode)(2, r.Box, { children: N(45) }),
                (0, o.createComponentVNode)(2, r.Box, { children: N(45) }),
                (0, o.createComponentVNode)(2, r.Box, { children: N(45) }),
              ],
            })
          : (0, o.createComponentVNode)(2, r.Section, {
              children: [
                (0, o.createComponentVNode)(2, r.LabeledList, {
                  children: (0, o.createComponentVNode)(2, r.LabeledList.Item, {
                    label: "Target",
                    children: d.map(function (e) {
                      return (0, o.createComponentVNode)(
                        2,
                        r.Button,
                        {
                          content: e.id,
                          selected: u === e.id,
                          onClick: function () {
                            return c("PRG_target_relay", { targid: e.id });
                          },
                        },
                        e.id
                      );
                    }),
                  }),
                }),
                (0, o.createComponentVNode)(2, r.Button, {
                  fluid: !0,
                  bold: !0,
                  content: "EXECUTE",
                  color: "bad",
                  textAlign: "center",
                  disabled: !u,
                  mt: 1,
                  onClick: function () {
                    return c("PRG_execute");
                  },
                }),
              ],
            });
      };
      t.NtosNetDosContent = i;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosNetDownloader = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.NtosNetDownloader = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.disk_size,
          s = d.disk_used,
          m = d.downloadable_programs,
          p = void 0 === m ? [] : m,
          C = d.error,
          h = d.hacked_programs,
          N = void 0 === h ? [] : h,
          V = d.hackedavailable;
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          resizable: !0,
          width: 480,
          height: 735,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            scrollable: !0,
            children: [
              !!C &&
                (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children: [
                    (0, o.createComponentVNode)(2, a.Box, {
                      mb: 1,
                      children: C,
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      content: "Reset",
                      onClick: function () {
                        return l("PRG_reseterror");
                      },
                    }),
                  ],
                }),
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Disk usage",
                    children: (0, o.createComponentVNode)(2, a.ProgressBar, {
                      value: s,
                      minValue: 0,
                      maxValue: u,
                      children: s + " GQ / " + u + " GQ",
                    }),
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                children: p.map(function (e) {
                  return (0,
                  o.createComponentVNode)(2, i, { program: e }, e.filename);
                }),
              }),
              !!V &&
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "UNKNOWN Software Repository",
                  children: [
                    (0, o.createComponentVNode)(2, a.NoticeBox, {
                      mb: 1,
                      children:
                        "Please note that Nanotrasen does not recommend download of software from non-official servers.",
                    }),
                    N.map(function (e) {
                      return (0,
                      o.createComponentVNode)(2, i, { program: e }, e.filename);
                    }),
                  ],
                }),
            ],
          }),
        });
      };
      var i = function (e, t) {
        var n = e.program,
          c = (0, r.useBackend)(t),
          i = c.act,
          l = c.data,
          d = l.disk_size,
          u = l.disk_used,
          s = l.downloadcompletion,
          m = l.downloading,
          p = l.downloadname,
          C = l.downloadsize,
          h = d - u;
        return (0, o.createComponentVNode)(2, a.Box, {
          mb: 3,
          children: [
            (0, o.createComponentVNode)(2, a.Flex, {
              align: "baseline",
              children: [
                (0, o.createComponentVNode)(2, a.Flex.Item, {
                  bold: !0,
                  grow: 1,
                  children: n.filedesc,
                }),
                (0, o.createComponentVNode)(2, a.Flex.Item, {
                  color: "label",
                  nowrap: !0,
                  children: [n.size, " GQ"],
                }),
                (0, o.createComponentVNode)(2, a.Flex.Item, {
                  ml: 2,
                  width: "94px",
                  textAlign: "center",
                  children:
                    (n.filename === p &&
                      (0, o.createComponentVNode)(2, a.ProgressBar, {
                        color: "green",
                        minValue: 0,
                        maxValue: C,
                        value: s,
                      })) ||
                    (0, o.createComponentVNode)(2, a.Button, {
                      fluid: !0,
                      icon: "download",
                      content: "Download",
                      disabled: m || n.size > h,
                      onClick: function () {
                        return i("PRG_downloadfile", { filename: n.filename });
                      },
                    }),
                }),
              ],
            }),
            "Compatible" !== n.compatibility &&
              (0, o.createComponentVNode)(2, a.Box, {
                mt: 1,
                italic: !0,
                fontSize: "12px",
                position: "relative",
                children: [
                  (0, o.createComponentVNode)(2, a.Icon, {
                    mx: 1,
                    color: "red",
                    name: "times",
                  }),
                  "Incompatible!",
                ],
              }),
            n.size > h &&
              (0, o.createComponentVNode)(2, a.Box, {
                mt: 1,
                italic: !0,
                fontSize: "12px",
                position: "relative",
                children: [
                  (0, o.createComponentVNode)(2, a.Icon, {
                    mx: 1,
                    color: "red",
                    name: "times",
                  }),
                  "Not enough disk space!",
                ],
              }),
            (0, o.createComponentVNode)(2, a.Box, {
              mt: 1,
              italic: !0,
              color: "label",
              fontSize: "12px",
              children: n.fileinfo,
            }),
          ],
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosNetMonitor = void 0);
      var o = n(0),
        r = n(1),
        a = n(2),
        c = n(3);
      t.NtosNetMonitor = function (e, t) {
        var n = (0, a.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.ntnetrelays,
          u = l.ntnetstatus,
          s = l.config_softwaredownload,
          m = l.config_peertopeer,
          p = l.config_communication,
          C = l.config_systemcontrol,
          h = l.idsalarm,
          N = l.idsstatus,
          V = l.ntnetmaxlogs,
          b = l.maxlogs,
          f = l.minlogs,
          g = l.ntnetlogs,
          v = void 0 === g ? [] : g;
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          resizable: !0,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, r.NoticeBox, {
                children:
                  "WARNING: Disabling wireless transmitters when using a wireless device may prevent you from reenabling them!",
              }),
              (0, o.createComponentVNode)(2, r.Section, {
                title: "Wireless Connectivity",
                buttons: (0, o.createComponentVNode)(2, r.Button.Confirm, {
                  icon: u ? "power-off" : "times",
                  content: u ? "ENABLED" : "DISABLED",
                  selected: u,
                  onClick: function () {
                    return i("toggleWireless");
                  },
                }),
                children: d
                  ? (0, o.createComponentVNode)(2, r.LabeledList, {
                      children: (0, o.createComponentVNode)(
                        2,
                        r.LabeledList.Item,
                        { label: "Active NTNet Relays", children: d }
                      ),
                    })
                  : "No Relays Connected",
              }),
              (0, o.createComponentVNode)(2, r.Section, {
                title: "Firewall Configuration",
                children: (0, o.createComponentVNode)(2, r.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, r.LabeledList.Item, {
                      label: "Software Downloads",
                      buttons: (0, o.createComponentVNode)(2, r.Button, {
                        icon: s ? "power-off" : "times",
                        content: s ? "ENABLED" : "DISABLED",
                        selected: s,
                        onClick: function () {
                          return i("toggle_function", { id: "1" });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, r.LabeledList.Item, {
                      label: "Peer to Peer Traffic",
                      buttons: (0, o.createComponentVNode)(2, r.Button, {
                        icon: m ? "power-off" : "times",
                        content: m ? "ENABLED" : "DISABLED",
                        selected: m,
                        onClick: function () {
                          return i("toggle_function", { id: "2" });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, r.LabeledList.Item, {
                      label: "Communication Systems",
                      buttons: (0, o.createComponentVNode)(2, r.Button, {
                        icon: p ? "power-off" : "times",
                        content: p ? "ENABLED" : "DISABLED",
                        selected: p,
                        onClick: function () {
                          return i("toggle_function", { id: "3" });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, r.LabeledList.Item, {
                      label: "Remote System Control",
                      buttons: (0, o.createComponentVNode)(2, r.Button, {
                        icon: C ? "power-off" : "times",
                        content: C ? "ENABLED" : "DISABLED",
                        selected: C,
                        onClick: function () {
                          return i("toggle_function", { id: "4" });
                        },
                      }),
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, r.Section, {
                title: "Security Systems",
                children: [
                  !!h &&
                    (0, o.createFragment)(
                      [
                        (0, o.createComponentVNode)(2, r.NoticeBox, {
                          children: "NETWORK INCURSION DETECTED",
                        }),
                        (0, o.createComponentVNode)(2, r.Box, {
                          italics: !0,
                          children:
                            "Abnormal activity has been detected in the network. Check system logs for more information",
                        }),
                      ],
                      4
                    ),
                  (0, o.createComponentVNode)(2, r.LabeledList, {
                    children: [
                      (0, o.createComponentVNode)(2, r.LabeledList.Item, {
                        label: "IDS Status",
                        buttons: (0, o.createFragment)(
                          [
                            (0, o.createComponentVNode)(2, r.Button, {
                              icon: N ? "power-off" : "times",
                              content: N ? "ENABLED" : "DISABLED",
                              selected: N,
                              onClick: function () {
                                return i("toggleIDS");
                              },
                            }),
                            (0, o.createComponentVNode)(2, r.Button, {
                              icon: "sync",
                              content: "Reset",
                              color: "bad",
                              onClick: function () {
                                return i("resetIDS");
                              },
                            }),
                          ],
                          4
                        ),
                      }),
                      (0, o.createComponentVNode)(2, r.LabeledList.Item, {
                        label: "Max Log Count",
                        buttons: (0, o.createComponentVNode)(2, r.NumberInput, {
                          value: V,
                          minValue: f,
                          maxValue: b,
                          width: "39px",
                          onChange: function (e, t) {
                            return i("updatemaxlogs", { new_number: t });
                          },
                        }),
                      }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, r.Section, {
                    title: "System Log",
                    level: 2,
                    buttons: (0, o.createComponentVNode)(2, r.Button.Confirm, {
                      icon: "trash",
                      content: "Clear Logs",
                      onClick: function () {
                        return i("purgelogs");
                      },
                    }),
                    children: v.map(function (e) {
                      return (0,
                      o.createComponentVNode)(2, r.Box, { className: "candystripe", children: e.entry }, e.entry);
                    }),
                  }),
                ],
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosPowerMonitor = void 0);
      var o = n(0),
        r = n(3),
        a = n(207);
      t.NtosPowerMonitor = function () {
        return (0, o.createComponentVNode)(2, r.NtosWindow, {
          resizable: !0,
          width: 550,
          height: 700,
          children: (0, o.createComponentVNode)(2, r.NtosWindow.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.PowerMonitorContent),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosRevelation = void 0);
      var o = n(0),
        r = n(1),
        a = n(2),
        c = n(3);
      t.NtosRevelation = function (e, t) {
        var n = (0, a.useBackend)(t),
          i = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          theme: "syndicate",
          width: 400,
          height: 250,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            children: (0, o.createComponentVNode)(2, r.Section, {
              children: [
                (0, o.createComponentVNode)(2, r.Button.Input, {
                  fluid: !0,
                  content: "Obfuscate Name...",
                  onCommit: function (e, t) {
                    return i("PRG_obfuscate", { new_name: t });
                  },
                  mb: 1,
                }),
                (0, o.createComponentVNode)(2, r.LabeledList, {
                  children: (0, o.createComponentVNode)(2, r.LabeledList.Item, {
                    label: "Payload Status",
                    buttons: (0, o.createComponentVNode)(2, r.Button, {
                      content: l.armed ? "ARMED" : "DISARMED",
                      color: l.armed ? "bad" : "average",
                      onClick: function () {
                        return i("PRG_arm");
                      },
                    }),
                  }),
                }),
                (0, o.createComponentVNode)(2, r.Button, {
                  fluid: !0,
                  bold: !0,
                  content: "ACTIVATE",
                  textAlign: "center",
                  color: "bad",
                  disabled: !l.armed,
                }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosRoboControl = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.NtosRoboControl = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.bots,
          s = d.id_owner,
          m = d.has_id;
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          resizable: !0,
          width: 550,
          height: 550,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Robot Control Console",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Id Card",
                      children: [
                        s,
                        !!m &&
                          (0, o.createComponentVNode)(2, a.Button, {
                            ml: 2,
                            icon: "eject",
                            content: "Eject",
                            onClick: function () {
                              return l("ejectcard");
                            },
                          }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Bots in range",
                      children: d.botcount,
                    }),
                  ],
                }),
              }),
              null == u
                ? void 0
                : u.map(function (e) {
                    return (0,
                    o.createComponentVNode)(2, i, { robot: e }, e.bot_ref);
                  }),
            ],
          }),
        });
      };
      var i = function (e, t) {
        var n = e.robot,
          c = (0, r.useBackend)(t),
          i = c.act,
          l = c.data,
          d = l.mules || [],
          u =
            !!n.mule_check &&
            (function (e, t) {
              return null == e
                ? void 0
                : e.find(function (e) {
                    return e.mule_ref === t;
                  });
            })(d, n.bot_ref),
          s =
            1 === n.mule_check
              ? "rgba(110, 75, 14, 1)"
              : "rgba(74, 59, 140, 1)";
        return (0, o.createComponentVNode)(2, a.Section, {
          title: n.name,
          style: { border: "4px solid " + s },
          buttons:
            u &&
            (0, o.createFragment)(
              [
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "play",
                  tooltip: "Go to Destination.",
                  onClick: function () {
                    return i("go", { robot: u.mule_ref });
                  },
                }),
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "pause",
                  tooltip: "Stop Moving.",
                  onClick: function () {
                    return i("stop", { robot: u.mule_ref });
                  },
                }),
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "home",
                  tooltip: "Travel Home.",
                  tooltipPosition: "bottom-left",
                  onClick: function () {
                    return i("home", { robot: u.mule_ref });
                  },
                }),
              ],
              4
            ),
          children: (0, o.createComponentVNode)(2, a.Flex, {
            spacing: 1,
            children: [
              (0, o.createComponentVNode)(2, a.Flex.Item, {
                grow: 1,
                basis: 0,
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Model",
                      children: n.model,
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Location",
                      children: n.locat,
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Status",
                      children: n.mode,
                    }),
                    u &&
                      (0, o.createFragment)(
                        [
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Loaded Cargo",
                            children: l.load || "N/A",
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Home",
                            children: u.home,
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Destination",
                            children: u.dest || "N/A",
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Power",
                            children: (0, o.createComponentVNode)(
                              2,
                              a.ProgressBar,
                              {
                                value: u.power,
                                minValue: 0,
                                maxValue: 100,
                                ranges: {
                                  good: [60, Infinity],
                                  average: [20, 60],
                                  bad: [-Infinity, 20],
                                },
                              }
                            ),
                          }),
                        ],
                        4
                      ),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Flex.Item, {
                width: "150px",
                children: [
                  u &&
                    (0, o.createFragment)(
                      [
                        (0, o.createComponentVNode)(2, a.Button, {
                          fluid: !0,
                          content: "Set Destination",
                          onClick: function () {
                            return i("destination", { robot: u.mule_ref });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          fluid: !0,
                          content: "Set ID",
                          onClick: function () {
                            return i("setid", { robot: u.mule_ref });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          fluid: !0,
                          content: "Set Home",
                          onClick: function () {
                            return i("sethome", { robot: u.mule_ref });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          fluid: !0,
                          content: "Unload Cargo",
                          onClick: function () {
                            return i("unload", { robot: u.mule_ref });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button.Checkbox, {
                          fluid: !0,
                          content: "Auto Return",
                          checked: u.autoReturn,
                          onClick: function () {
                            return i("autoret", { robot: u.mule_ref });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button.Checkbox, {
                          fluid: !0,
                          content: "Auto Pickup",
                          checked: u.autoPickup,
                          onClick: function () {
                            return i("autopick", { robot: u.mule_ref });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button.Checkbox, {
                          fluid: !0,
                          content: "Delivery Report",
                          checked: u.reportDelivery,
                          onClick: function () {
                            return i("report", { robot: u.mule_ref });
                          },
                        }),
                      ],
                      4
                    ),
                  !u &&
                    (0, o.createFragment)(
                      [
                        (0, o.createComponentVNode)(2, a.Button, {
                          fluid: !0,
                          content: "Stop Patrol",
                          onClick: function () {
                            return i("patroloff", { robot: n.bot_ref });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          fluid: !0,
                          content: "Start Patrol",
                          onClick: function () {
                            return i("patrolon", { robot: n.bot_ref });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          fluid: !0,
                          content: "Summon",
                          onClick: function () {
                            return i("summon", { robot: n.bot_ref });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          fluid: !0,
                          content: "Eject PAi",
                          onClick: function () {
                            return i("ejectpai", { robot: n.bot_ref });
                          },
                        }),
                      ],
                      4
                    ),
                ],
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NtosStationAlertConsole = void 0);
      var o = n(0),
        r = n(3),
        a = n(208);
      t.NtosStationAlertConsole = function () {
        return (0, o.createComponentVNode)(2, r.NtosWindow, {
          resizable: !0,
          width: 315,
          height: 500,
          children: (0, o.createComponentVNode)(2, r.NtosWindow.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(
              2,
              a.StationAlertConsoleContent
            ),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.NtosSupermatterMonitorContent = t.NtosSupermatterMonitor = void 0);
      var o = n(0),
        r = n(21),
        a = n(50),
        c = n(8),
        i = n(2),
        l = n(1),
        d = n(44),
        u = n(3),
        s = function (e) {
          return Math.log2(16 + Math.max(0, e)) - 4;
        };
      t.NtosSupermatterMonitor = function (e, t) {
        return (0, o.createComponentVNode)(2, u.NtosWindow, {
          resizable: !0,
          width: 600,
          height: 350,
          children: (0, o.createComponentVNode)(2, u.NtosWindow.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, m),
          }),
        });
      };
      var m = function (e, t) {
        var n = (0, i.useBackend)(t),
          u = n.act,
          m = n.data,
          C = m.active,
          h = m.SM_integrity,
          N = m.SM_power,
          V = m.SM_ambienttemp,
          b = m.SM_ambientpressure;
        if (!C) return (0, o.createComponentVNode)(2, p);
        var f = (0, a.flow)([
            function (e) {
              return e.filter(function (e) {
                return e.amount >= 0.01;
              });
            },
            (0, r.sortBy)(function (e) {
              return -e.amount;
            }),
          ])(m.gases || []),
          g = Math.max.apply(
            Math,
            [1].concat(
              f.map(function (e) {
                return e.amount;
              })
            )
          );
        return (0, o.createComponentVNode)(2, l.Flex, {
          spacing: 1,
          children: [
            (0, o.createComponentVNode)(2, l.Flex.Item, {
              width: "270px",
              children: (0, o.createComponentVNode)(2, l.Section, {
                title: "Metrics",
                children: (0, o.createComponentVNode)(2, l.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, l.LabeledList.Item, {
                      label: "Integrity",
                      children: (0, o.createComponentVNode)(2, l.ProgressBar, {
                        value: h / 100,
                        ranges: {
                          good: [0.9, Infinity],
                          average: [0.5, 0.9],
                          bad: [-Infinity, 0.5],
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, l.LabeledList.Item, {
                      label: "Relative EER",
                      children: (0, o.createComponentVNode)(2, l.ProgressBar, {
                        value: N,
                        minValue: 0,
                        maxValue: 5e3,
                        ranges: {
                          good: [-Infinity, 5e3],
                          average: [5e3, 7e3],
                          bad: [7e3, Infinity],
                        },
                        children: (0, c.toFixed)(N) + " MeV/cm3",
                      }),
                    }),
                    (0, o.createComponentVNode)(2, l.LabeledList.Item, {
                      label: "Temperature",
                      children: (0, o.createComponentVNode)(2, l.ProgressBar, {
                        value: s(V),
                        minValue: 0,
                        maxValue: s(1e4),
                        ranges: {
                          teal: [-Infinity, s(80)],
                          good: [s(80), s(373)],
                          average: [s(373), s(1e3)],
                          bad: [s(1e3), Infinity],
                        },
                        children: (0, c.toFixed)(V) + " K",
                      }),
                    }),
                    (0, o.createComponentVNode)(2, l.LabeledList.Item, {
                      label: "Pressure",
                      children: (0, o.createComponentVNode)(2, l.ProgressBar, {
                        value: s(b),
                        minValue: 0,
                        maxValue: s(5e4),
                        ranges: {
                          good: [s(1), s(300)],
                          average: [-Infinity, s(1e3)],
                          bad: [s(1e3), +Infinity],
                        },
                        children: (0, c.toFixed)(b) + " kPa",
                      }),
                    }),
                  ],
                }),
              }),
            }),
            (0, o.createComponentVNode)(2, l.Flex.Item, {
              grow: 1,
              basis: 0,
              children: (0, o.createComponentVNode)(2, l.Section, {
                title: "Gases",
                buttons: (0, o.createComponentVNode)(2, l.Button, {
                  icon: "arrow-left",
                  content: "Back",
                  onClick: function () {
                    return u("PRG_clear");
                  },
                }),
                children: (0, o.createComponentVNode)(2, l.LabeledList, {
                  children: f.map(function (e) {
                    return (0,
                    o.createComponentVNode)(2, l.LabeledList.Item, { label: (0, d.getGasLabel)(e.name), children: (0, o.createComponentVNode)(2, l.ProgressBar, { color: (0, d.getGasColor)(e.name), value: e.amount, minValue: 0, maxValue: g, children: (0, c.toFixed)(e.amount, 2) + "%" }) }, e.name);
                  }),
                }),
              }),
            }),
          ],
        });
      };
      t.NtosSupermatterMonitorContent = m;
      var p = function (e, t) {
        var n = (0, i.useBackend)(t),
          r = n.act,
          a = n.data.supermatters,
          c = void 0 === a ? [] : a;
        return (0, o.createComponentVNode)(2, l.Section, {
          title: "Detected Supermatters",
          buttons: (0, o.createComponentVNode)(2, l.Button, {
            icon: "sync",
            content: "Refresh",
            onClick: function () {
              return r("PRG_refresh");
            },
          }),
          children: (0, o.createComponentVNode)(2, l.Table, {
            children: c.map(function (e) {
              return (0, o.createComponentVNode)(
                2,
                l.Table.Row,
                {
                  children: [
                    (0, o.createComponentVNode)(2, l.Table.Cell, {
                      children: e.uid + ". " + e.area_name,
                    }),
                    (0, o.createComponentVNode)(2, l.Table.Cell, {
                      collapsing: !0,
                      color: "label",
                      children: "Integrity:",
                    }),
                    (0, o.createComponentVNode)(2, l.Table.Cell, {
                      collapsing: !0,
                      width: "120px",
                      children: (0, o.createComponentVNode)(2, l.ProgressBar, {
                        value: e.integrity / 100,
                        ranges: {
                          good: [0.9, Infinity],
                          average: [0.5, 0.9],
                          bad: [-Infinity, 0.5],
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, l.Table.Cell, {
                      collapsing: !0,
                      children: (0, o.createComponentVNode)(2, l.Button, {
                        content: "Details",
                        onClick: function () {
                          return r("PRG_set", { target: e.uid });
                        },
                      }),
                    }),
                  ],
                },
                e.uid
              );
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.NuclearBomb = void 0);
      var o = n(0),
        r = n(6),
        a = n(2),
        c = n(1),
        i = n(3),
        l = function (e, t) {
          var n = (0, a.useBackend)(t).act;
          return (0, o.createComponentVNode)(2, c.Box, {
            width: "185px",
            children: (0, o.createComponentVNode)(2, c.Grid, {
              width: "1px",
              children: [
                ["1", "4", "7", "C"],
                ["2", "5", "8", "0"],
                ["3", "6", "9", "E"],
              ].map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  c.Grid.Column,
                  {
                    children: e.map(function (e) {
                      return (0, o.createComponentVNode)(
                        2,
                        c.Button,
                        {
                          fluid: !0,
                          bold: !0,
                          mb: 1,
                          content: e,
                          textAlign: "center",
                          fontSize: "40px",
                          lineHeight: "50px",
                          width: "55px",
                          className: (0, r.classes)([
                            "NuclearBomb__Button",
                            "NuclearBomb__Button--keypad",
                            "NuclearBomb__Button--" + e,
                          ]),
                          onClick: function () {
                            return n("keypad", { digit: e });
                          },
                        },
                        e
                      );
                    }),
                  },
                  e[0]
                );
              }),
            }),
          });
        };
      t.NuclearBomb = function (e, t) {
        var n = (0, a.useBackend)(t),
          r = n.act,
          d = n.data,
          u = (d.anchored, d.disk_present, d.status1),
          s = d.status2;
        return (0, o.createComponentVNode)(2, i.Window, {
          theme: "retro",
          width: 350,
          height: 442,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: (0, o.createComponentVNode)(2, c.Box, {
              m: 1,
              children: [
                (0, o.createComponentVNode)(2, c.Box, {
                  mb: 1,
                  className: "NuclearBomb__displayBox",
                  children: u,
                }),
                (0, o.createComponentVNode)(2, c.Flex, {
                  mb: 1.5,
                  children: [
                    (0, o.createComponentVNode)(2, c.Flex.Item, {
                      grow: 1,
                      children: (0, o.createComponentVNode)(2, c.Box, {
                        className: "NuclearBomb__displayBox",
                        children: s,
                      }),
                    }),
                    (0, o.createComponentVNode)(2, c.Flex.Item, {
                      children: (0, o.createComponentVNode)(2, c.Button, {
                        icon: "eject",
                        fontSize: "24px",
                        lineHeight: "23px",
                        textAlign: "center",
                        width: "43px",
                        ml: 1,
                        mr: "3px",
                        mt: "3px",
                        className:
                          "NuclearBomb__Button NuclearBomb__Button--keypad",
                        onClick: function () {
                          return r("eject_disk");
                        },
                      }),
                    }),
                  ],
                }),
                (0, o.createComponentVNode)(2, c.Flex, {
                  ml: "3px",
                  children: [
                    (0, o.createComponentVNode)(2, c.Flex.Item, {
                      children: (0, o.createComponentVNode)(2, l),
                    }),
                    (0, o.createComponentVNode)(2, c.Flex.Item, {
                      ml: 1,
                      width: "129px",
                      children: (0, o.createComponentVNode)(2, c.Box, {
                        children: [
                          (0, o.createComponentVNode)(2, c.Button, {
                            fluid: !0,
                            bold: !0,
                            content: "ARM",
                            textAlign: "center",
                            fontSize: "28px",
                            lineHeight: "32px",
                            mb: 1,
                            className:
                              "NuclearBomb__Button NuclearBomb__Button--C",
                            onClick: function () {
                              return r("arm");
                            },
                          }),
                          (0, o.createComponentVNode)(2, c.Button, {
                            fluid: !0,
                            bold: !0,
                            content: "ANCHOR",
                            textAlign: "center",
                            fontSize: "28px",
                            lineHeight: "32px",
                            className:
                              "NuclearBomb__Button NuclearBomb__Button--E",
                            onClick: function () {
                              return r("anchor");
                            },
                          }),
                          (0, o.createComponentVNode)(2, c.Box, {
                            textAlign: "center",
                            color: "#9C9987",
                            fontSize: "80px",
                            children: (0, o.createComponentVNode)(2, c.Icon, {
                              name: "radiation",
                            }),
                          }),
                          (0, o.createComponentVNode)(2, c.Box, {
                            height: "80px",
                            className: "NuclearBomb__NTIcon",
                          }),
                        ],
                      }),
                    }),
                  ],
                }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.OperatingComputer = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = [
          { label: "Brute", type: "bruteLoss" },
          { label: "Burn", type: "fireLoss" },
          { label: "Toxin", type: "toxLoss" },
          { label: "Respiratory", type: "oxyLoss" },
        ];
      t.OperatingComputer = function (e, t) {
        var n = (0, r.useSharedState)(t, "tab", 1),
          i = n[0],
          u = n[1];
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 350,
          height: 470,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Tabs, {
                children: [
                  (0, o.createComponentVNode)(2, a.Tabs.Tab, {
                    selected: 1 === i,
                    onClick: function () {
                      return u(1);
                    },
                    children: "Patient State",
                  }),
                  (0, o.createComponentVNode)(2, a.Tabs.Tab, {
                    selected: 2 === i,
                    onClick: function () {
                      return u(2);
                    },
                    children: "Surgery Procedures",
                  }),
                ],
              }),
              1 === i && (0, o.createComponentVNode)(2, l),
              2 === i && (0, o.createComponentVNode)(2, d),
            ],
          }),
        });
      };
      var l = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = (n.act, n.data),
            l = c.table,
            d = c.procedures,
            u = void 0 === d ? [] : d,
            s = c.patient,
            m = void 0 === s ? {} : s;
          return l
            ? (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, a.Section, {
                    title: "Patient State",
                    children:
                      (m &&
                        (0, o.createComponentVNode)(2, a.LabeledList, {
                          children: [
                            (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                              label: "State",
                              color: m.statstate,
                              children: m.stat,
                            }),
                            (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                              label: "Blood Type",
                              children: m.blood_type,
                            }),
                            (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                              label: "Health",
                              children: (0, o.createComponentVNode)(
                                2,
                                a.ProgressBar,
                                {
                                  value: m.health,
                                  minValue: m.minHealth,
                                  maxValue: m.maxHealth,
                                  color: m.health >= 0 ? "good" : "average",
                                  children: (0, o.createComponentVNode)(
                                    2,
                                    a.AnimatedNumber,
                                    { value: m.health }
                                  ),
                                }
                              ),
                            }),
                            i.map(function (e) {
                              return (0,
                              o.createComponentVNode)(2, a.LabeledList.Item, { label: e.label, children: (0, o.createComponentVNode)(2, a.ProgressBar, { value: m[e.type] / m.maxHealth, color: "bad", children: (0, o.createComponentVNode)(2, a.AnimatedNumber, { value: m[e.type] }) }) }, e.type);
                            }),
                          ],
                        })) ||
                      "No Patient Detected",
                  }),
                  0 === u.length &&
                    (0, o.createComponentVNode)(2, a.Section, {
                      children: "No Active Procedures",
                    }),
                  u.map(function (e) {
                    return (0,
                    o.createComponentVNode)(2, a.Section, { title: e.name, children: (0, o.createComponentVNode)(2, a.LabeledList, { children: [(0, o.createComponentVNode)(2, a.LabeledList.Item, { label: "Next Step", children: [e.next_step, e.chems_needed && (0, o.createFragment)([(0, o.createVNode)(1, "b", null, "Required Chemicals:", 16), (0, o.createVNode)(1, "br"), e.chems_needed], 0)] }), !!c.alternative_step && (0, o.createComponentVNode)(2, a.LabeledList.Item, { label: "Alternative Step", children: [e.alternative_step, e.alt_chems_needed && (0, o.createFragment)([(0, o.createVNode)(1, "b", null, "Required Chemicals:", 16), (0, o.createVNode)(1, "br"), e.alt_chems_needed], 0)] })] }) }, e.name);
                  }),
                ],
                0
              )
            : (0, o.createComponentVNode)(2, a.NoticeBox, {
                children: "No Table Detected",
              });
        },
        d = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data.surgeries,
            l = void 0 === i ? [] : i;
          return (0, o.createComponentVNode)(2, a.Section, {
            title: "Advanced Surgery Procedures",
            children: [
              (0, o.createComponentVNode)(2, a.Button, {
                icon: "download",
                content: "Sync Research Database",
                onClick: function () {
                  return c("sync");
                },
              }),
              l.map(function (e) {
                return (0,
                o.createComponentVNode)(2, a.Section, { title: e.name, level: 2, children: e.desc }, e.name);
              }),
            ],
          });
        };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Orbit = void 0);
      var o = n(0),
        r = n(19),
        a = n(1),
        c = n(3),
        i = n(2);
      function l(e, t) {
        var n;
        if ("undefined" == typeof Symbol || null == e[Symbol.iterator]) {
          if (
            Array.isArray(e) ||
            (n = (function (e, t) {
              if (!e) return;
              if ("string" == typeof e) return d(e, t);
              var n = Object.prototype.toString.call(e).slice(8, -1);
              "Object" === n && e.constructor && (n = e.constructor.name);
              if ("Map" === n || "Set" === n) return Array.from(e);
              if (
                "Arguments" === n ||
                /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)
              )
                return d(e, t);
            })(e)) ||
            (t && e && "number" == typeof e.length)
          ) {
            n && (e = n);
            var o = 0;
            return function () {
              return o >= e.length ? { done: !0 } : { done: !1, value: e[o++] };
            };
          }
          throw new TypeError(
            "Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."
          );
        }
        return (n = e[Symbol.iterator]()).next.bind(n);
      }
      function d(e, t) {
        (null == t || t > e.length) && (t = e.length);
        for (var n = 0, o = new Array(t); n < t; n++) o[n] = e[n];
        return o;
      }
      var u = / \[(?:ghost|dead)\]$/,
        s = / \(([0-9]+)\)$/,
        m = function (e) {
          return (0, r.createSearch)(e, function (e) {
            return e.name;
          });
        },
        p = function (e, t) {
          return e < t ? -1 : e > t;
        },
        C = function (e, t) {
          var n = e.name,
            o = t.name,
            r = n.match(s),
            a = o.match(s);
          return r && a && n.replace(s, "") === o.replace(s, "")
            ? parseInt(r[1], 10) - parseInt(a[1], 10)
            : p(n, o);
        },
        h = function (e, t) {
          var n = (0, i.useBackend)(t).act,
            r = e.searchText,
            c = e.source,
            l = e.title,
            d = c.filter(m(r));
          return (
            d.sort(C),
            c.length > 0 &&
              (0, o.createComponentVNode)(2, a.Section, {
                title: l + " - (" + c.length + ")",
                children: d.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    a.Button,
                    {
                      content: e.name.replace(u, ""),
                      onClick: function () {
                        return n("orbit", { name: e.name });
                      },
                    },
                    e.name
                  );
                }),
              })
          );
        },
        N = function (e, t) {
          var n = (0, i.useBackend)(t).act,
            r = e.color,
            c = e.thing;
          return (0, o.createComponentVNode)(2, a.Button, {
            color: r,
            onClick: function () {
              return n("orbit", { name: c.name });
            },
            children: [
              c.name,
              c.orbiters &&
                (0, o.createComponentVNode)(2, a.Box, {
                  inline: !0,
                  ml: 1,
                  children: [
                    "(",
                    c.orbiters,
                    " ",
                    (0, o.createComponentVNode)(2, a.Box, {
                      as: "img",
                      src: "ghost.png",
                      opacity: 0.7,
                    }),
                    ")",
                  ],
                }),
            ],
          });
        };
      t.Orbit = function (e, t) {
        for (
          var n,
            r = (0, i.useBackend)(t),
            d = r.act,
            u = r.data,
            s = u.alive,
            V = u.antagonists,
            b = u.dead,
            f = u.ghosts,
            g = u.misc,
            v = u.npcs,
            k = (0, i.useLocalState)(t, "searchText", ""),
            w = k[0],
            B = k[1],
            x = {},
            _ = l(V);
          !(n = _()).done;

        ) {
          var L = n.value;
          x[L.antag] === undefined && (x[L.antag] = []), x[L.antag].push(L);
        }
        var y = Object.entries(x);
        y.sort(function (e, t) {
          return p(e[0], t[0]);
        });
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 350,
          height: 700,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.Input, {
                  fluid: !0,
                  value: w,
                  onInput: function (e, t) {
                    return B(t);
                  },
                  onEnter: function (e, t) {
                    return (function (e) {
                      for (
                        var t = 0,
                          n = [
                            y.map(function (e) {
                              return e[0], e[1];
                            }),
                            s,
                            f,
                            b,
                            v,
                            g,
                          ];
                        t < n.length;
                        t++
                      ) {
                        var o = n[t].filter(m(e)).sort(C)[0];
                        if (o !== undefined) {
                          d("orbit", { name: o.name });
                          break;
                        }
                      }
                    })(t);
                  },
                }),
              }),
              V.length > 0 &&
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "Ghost-Visible Antagonists",
                  children: y.map(function (e) {
                    var t = e[0],
                      n = e[1];
                    return (0, o.createComponentVNode)(
                      2,
                      a.Section,
                      {
                        title: t,
                        level: 2,
                        children: n
                          .filter(m(w))
                          .sort(C)
                          .map(function (e) {
                            return (0,
                            o.createComponentVNode)(2, N, { color: "bad", thing: e }, e.name);
                          }),
                      },
                      t
                    );
                  }),
                }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Alive",
                children: s
                  .filter(m(w))
                  .sort(C)
                  .map(function (e) {
                    return (0,
                    o.createComponentVNode)(2, N, { color: "good", thing: e }, e.name);
                  }),
              }),
              (0, o.createComponentVNode)(2, h, {
                title: "Ghosts",
                source: f,
                searchText: w,
              }),
              (0, o.createComponentVNode)(2, h, {
                title: "Dead",
                source: b,
                searchText: w,
              }),
              (0, o.createComponentVNode)(2, h, {
                title: "NPCs",
                source: v,
                searchText: w,
              }),
              (0, o.createComponentVNode)(2, h, {
                title: "Misc",
                source: g,
                searchText: w,
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.OreBox = void 0);
      var o = n(0),
        r = n(19),
        a = n(1),
        c = n(2),
        i = n(3);
      t.OreBox = function (e, t) {
        var n = (0, c.useBackend)(t),
          l = n.act,
          d = n.data.materials;
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 335,
          height: 415,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Ores",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  content: "Empty",
                  onClick: function () {
                    return l("removeall");
                  },
                }),
                children: (0, o.createComponentVNode)(2, a.Table, {
                  children: [
                    (0, o.createComponentVNode)(2, a.Table.Row, {
                      header: !0,
                      children: [
                        (0, o.createComponentVNode)(2, a.Table.Cell, {
                          children: "Ore",
                        }),
                        (0, o.createComponentVNode)(2, a.Table.Cell, {
                          collapsing: !0,
                          textAlign: "right",
                          children: "Amount",
                        }),
                      ],
                    }),
                    d.map(function (e) {
                      return (0,
                      o.createComponentVNode)(2, a.Table.Row, { children: [(0, o.createComponentVNode)(2, a.Table.Cell, { children: (0, r.toTitleCase)(e.name) }), (0, o.createComponentVNode)(2, a.Table.Cell, { collapsing: !0, textAlign: "right", children: (0, o.createComponentVNode)(2, a.Box, { color: "label", inline: !0, children: e.amount }) })] }, e.type);
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.Box, {
                  children: [
                    "All ores will be placed in here when you are wearing a mining stachel on your belt or in a pocket while dragging the ore box.",
                    (0, o.createVNode)(1, "br"),
                    "Gibtonite is not accepted.",
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.OreRedemptionMachine = void 0);
      var o = n(0),
        r = n(19),
        a = n(2),
        c = n(1),
        i = n(3);
      t.OreRedemptionMachine = function (e, t) {
        var n = (0, a.useBackend)(t),
          r = n.act,
          d = n.data,
          u = d.unclaimedPoints,
          s = d.materials,
          m = d.alloys,
          p = d.diskDesigns,
          C = d.hasDisk;
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 440,
          height: 550,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, c.Section, {
                children: [
                  (0, o.createComponentVNode)(2, c.BlockQuote, {
                    mb: 1,
                    children: [
                      "This machine only accepts ore.",
                      (0, o.createVNode)(1, "br"),
                      "Gibtonite and Slag are not accepted.",
                    ],
                  }),
                  (0, o.createComponentVNode)(2, c.Box, {
                    children: [
                      (0, o.createComponentVNode)(2, c.Box, {
                        inline: !0,
                        color: "label",
                        mr: 1,
                        children: "Unclaimed points:",
                      }),
                      u,
                      (0, o.createComponentVNode)(2, c.Button, {
                        ml: 2,
                        content: "Claim",
                        disabled: 0 === u,
                        onClick: function () {
                          return r("Claim");
                        },
                      }),
                    ],
                  }),
                ],
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                children:
                  (C &&
                    (0, o.createFragment)(
                      [
                        (0, o.createComponentVNode)(2, c.Box, {
                          mb: 1,
                          children: (0, o.createComponentVNode)(2, c.Button, {
                            icon: "eject",
                            content: "Eject design disk",
                            onClick: function () {
                              return r("diskEject");
                            },
                          }),
                        }),
                        (0, o.createComponentVNode)(2, c.Table, {
                          children: p.map(function (e) {
                            return (0, o.createComponentVNode)(
                              2,
                              c.Table.Row,
                              {
                                children: [
                                  (0, o.createComponentVNode)(2, c.Table.Cell, {
                                    children: ["File ", e.index, ": ", e.name],
                                  }),
                                  (0, o.createComponentVNode)(2, c.Table.Cell, {
                                    collapsing: !0,
                                    children: (0, o.createComponentVNode)(
                                      2,
                                      c.Button,
                                      {
                                        disabled: !e.canupload,
                                        content: "Upload",
                                        onClick: function () {
                                          return r("diskUpload", {
                                            design: e.index,
                                          });
                                        },
                                      }
                                    ),
                                  }),
                                ],
                              },
                              e.index
                            );
                          }),
                        }),
                      ],
                      4
                    )) ||
                  (0, o.createComponentVNode)(2, c.Button, {
                    icon: "save",
                    content: "Insert design disk",
                    onClick: function () {
                      return r("diskInsert");
                    },
                  }),
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Materials",
                children: (0, o.createComponentVNode)(2, c.Table, {
                  children: s.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      l,
                      {
                        material: e,
                        onRelease: function (t) {
                          return r("Release", { id: e.id, sheets: t });
                        },
                      },
                      e.id
                    );
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Alloys",
                children: (0, o.createComponentVNode)(2, c.Table, {
                  children: m.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      l,
                      {
                        material: e,
                        onRelease: function (t) {
                          return r("Smelt", { id: e.id, sheets: t });
                        },
                      },
                      e.id
                    );
                  }),
                }),
              }),
            ],
          }),
        });
      };
      var l = function (e, t) {
        var n = e.material,
          i = e.onRelease,
          l = (0, a.useLocalState)(t, "amount" + n.name, 1),
          d = l[0],
          u = l[1],
          s = Math.floor(n.amount);
        return (0, o.createComponentVNode)(2, c.Table.Row, {
          children: [
            (0, o.createComponentVNode)(2, c.Table.Cell, {
              children: (0, r.toTitleCase)(n.name).replace("Alloy", ""),
            }),
            (0, o.createComponentVNode)(2, c.Table.Cell, {
              collapsing: !0,
              textAlign: "right",
              children: (0, o.createComponentVNode)(2, c.Box, {
                mr: 2,
                color: "label",
                inline: !0,
                children: n.value && n.value + " cr",
              }),
            }),
            (0, o.createComponentVNode)(2, c.Table.Cell, {
              collapsing: !0,
              textAlign: "right",
              children: (0, o.createComponentVNode)(2, c.Box, {
                mr: 2,
                color: "label",
                inline: !0,
                children: [s, " sheets"],
              }),
            }),
            (0, o.createComponentVNode)(2, c.Table.Cell, {
              collapsing: !0,
              children: [
                (0, o.createComponentVNode)(2, c.NumberInput, {
                  width: "32px",
                  step: 1,
                  stepPixelSize: 5,
                  minValue: 1,
                  maxValue: 50,
                  value: d,
                  onChange: function (e, t) {
                    return u(t);
                  },
                }),
                (0, o.createComponentVNode)(2, c.Button, {
                  disabled: s < 1,
                  content: "Release",
                  onClick: function () {
                    return i(d);
                  },
                }),
              ],
            }),
          ],
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.Pandemic = t.PandemicAntibodyDisplay = t.PandemicSymptomDisplay = t.PandemicDiseaseDisplay = t.PandemicBeakerDisplay = void 0);
      var o = n(0),
        r = (n(21), n(2)),
        a = n(1),
        c = n(3),
        i = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data,
            l = i.has_beaker,
            d = i.beaker_empty,
            u = i.has_blood,
            s = i.blood,
            m = !l || d;
          return (0, o.createComponentVNode)(2, a.Section, {
            title: "Beaker",
            buttons: (0, o.createFragment)(
              [
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "times",
                  content: "Empty and Eject",
                  color: "bad",
                  disabled: m,
                  onClick: function () {
                    return c("empty_eject_beaker");
                  },
                }),
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "trash",
                  content: "Empty",
                  disabled: m,
                  onClick: function () {
                    return c("empty_beaker");
                  },
                }),
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "eject",
                  content: "Eject",
                  disabled: !l,
                  onClick: function () {
                    return c("eject_beaker");
                  },
                }),
              ],
              4
            ),
            children: l
              ? d
                ? (0, o.createComponentVNode)(2, a.Box, {
                    color: "bad",
                    children: "Beaker is empty",
                  })
                : u
                ? (0, o.createComponentVNode)(2, a.LabeledList, {
                    children: [
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Blood DNA",
                        children: (s && s.dna) || "Unknown",
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Blood Type",
                        children: (s && s.type) || "Unknown",
                      }),
                    ],
                  })
                : (0, o.createComponentVNode)(2, a.Box, {
                    color: "bad",
                    children: "No blood detected",
                  })
              : (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children: "No beaker loaded",
                }),
          });
        };
      t.PandemicBeakerDisplay = i;
      var l = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          l = i.is_ready;
        return (i.viruses || []).map(function (e) {
          var t = e.symptoms || [];
          return (0, o.createComponentVNode)(
            2,
            a.Section,
            {
              title: e.can_rename
                ? (0, o.createComponentVNode)(2, a.Input, {
                    value: e.name,
                    onChange: function (t, n) {
                      return c("rename_disease", { index: e.index, name: n });
                    },
                  })
                : e.name,
              buttons: (0, o.createComponentVNode)(2, a.Button, {
                icon: "flask",
                content: "Create culture bottle",
                disabled: !l,
                onClick: function () {
                  return c("create_culture_bottle", { index: e.index });
                },
              }),
              children: [
                (0, o.createComponentVNode)(2, a.Grid, {
                  children: [
                    (0, o.createComponentVNode)(2, a.Grid.Column, {
                      children: e.description,
                    }),
                    (0, o.createComponentVNode)(2, a.Grid.Column, {
                      children: (0, o.createComponentVNode)(2, a.LabeledList, {
                        children: [
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Agent",
                            children: e.agent,
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Spread",
                            children: e.spread,
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Severity",
                            children: e.severity,
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Possible Cure",
                            children: e.cure,
                          }),
                        ],
                      }),
                    }),
                  ],
                }),
                !!e.is_adv &&
                  (0, o.createFragment)(
                    [
                      (0, o.createComponentVNode)(2, a.Section, {
                        title: "Statistics",
                        level: 2,
                        children: (0, o.createComponentVNode)(2, a.Grid, {
                          children: [
                            (0, o.createComponentVNode)(2, a.Grid.Column, {
                              children: (0, o.createComponentVNode)(
                                2,
                                a.LabeledList,
                                {
                                  children: [
                                    (0, o.createComponentVNode)(
                                      2,
                                      a.LabeledList.Item,
                                      {
                                        label: "Resistance",
                                        children: e.resistance,
                                      }
                                    ),
                                    (0, o.createComponentVNode)(
                                      2,
                                      a.LabeledList.Item,
                                      { label: "Stealth", children: e.stealth }
                                    ),
                                  ],
                                }
                              ),
                            }),
                            (0, o.createComponentVNode)(2, a.Grid.Column, {
                              children: (0, o.createComponentVNode)(
                                2,
                                a.LabeledList,
                                {
                                  children: [
                                    (0, o.createComponentVNode)(
                                      2,
                                      a.LabeledList.Item,
                                      {
                                        label: "Stage speed",
                                        children: e.stage_speed,
                                      }
                                    ),
                                    (0, o.createComponentVNode)(
                                      2,
                                      a.LabeledList.Item,
                                      {
                                        label: "Transmissibility",
                                        children: e.transmission,
                                      }
                                    ),
                                    (0, o.createComponentVNode)(
                                      2,
                                      a.LabeledList.Item,
                                      {
                                        label: "Severity",
                                        children: e.symptom_severity,
                                      }
                                    ),
                                  ],
                                }
                              ),
                            }),
                          ],
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Section, {
                        title: "Symptoms",
                        level: 2,
                        children: t.map(function (e) {
                          return (0,
                          o.createComponentVNode)(2, a.Collapsible, { title: e.name, children: (0, o.createComponentVNode)(2, a.Section, { children: (0, o.createComponentVNode)(2, d, { symptom: e }) }) }, e.name);
                        }),
                      }),
                    ],
                    4
                  ),
              ],
            },
            e.name
          );
        });
      };
      t.PandemicDiseaseDisplay = l;
      var d = function (e, t) {
        var n = e.symptom,
          r = n.name,
          c = n.desc,
          i = n.stealth,
          l = n.resistance,
          d = n.stage_speed,
          u = n.transmission,
          s = n.severity,
          m = n.level,
          p = n.neutered,
          C = n.threshold_desc;
        return (0, o.createComponentVNode)(2, a.Section, {
          title: r,
          level: 2,
          buttons:
            !!p &&
            (0, o.createComponentVNode)(2, a.Box, {
              bold: !0,
              color: "bad",
              children: "Neutered",
            }),
          children: [
            (0, o.createComponentVNode)(2, a.Grid, {
              children: [
                (0, o.createComponentVNode)(2, a.Grid.Column, {
                  size: 2,
                  children: c,
                }),
                (0, o.createComponentVNode)(2, a.Grid.Column, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList, {
                    children: [
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Level",
                        children: m,
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Resistance",
                        children: l,
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Stealth",
                        children: i,
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Stage Speed",
                        children: d,
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Transmission",
                        children: u,
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Severity",
                        children: s,
                      }),
                    ],
                  }),
                }),
              ],
            }),
            C &&
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Thresholds",
                level: 3,
                children: (0, o.createVNode)(1, "div", null, null, 1, {
                  dangerouslySetInnerHTML: { __html: C },
                }),
              }),
          ],
        });
      };
      t.PandemicSymptomDisplay = d;
      var u = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data,
          l = i.resistances || [];
        return (0, o.createComponentVNode)(2, a.Section, {
          title: "Antibodies",
          children:
            l.length > 0
              ? (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: l.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      a.LabeledList.Item,
                      {
                        label: e.name,
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          icon: "eye-dropper",
                          content: "Create vaccine bottle",
                          disabled: !i.is_ready,
                          onClick: function () {
                            return c("create_vaccine_bottle", { index: e.id });
                          },
                        }),
                      },
                      e.name
                    );
                  }),
                })
              : (0, o.createComponentVNode)(2, a.Box, {
                  bold: !0,
                  color: "bad",
                  mt: 1,
                  children: "No antibodies detected.",
                }),
        });
      };
      t.PandemicAntibodyDisplay = u;
      t.Pandemic = function (e, t) {
        var n = (0, r.useBackend)(t).data;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 520,
          height: 550,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, i),
              !!n.has_blood &&
                (0, o.createFragment)(
                  [
                    (0, o.createComponentVNode)(2, l),
                    (0, o.createComponentVNode)(2, u),
                  ],
                  4
                ),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.PaperSheet = void 0);
      var o = n(0),
        r = n(6),
        a = n(102),
        c = s(n(209)),
        i = s(n(594)),
        l = n(2),
        d = n(1),
        u = n(3);
      function s(e) {
        return e && e.__esModule ? e : { default: e };
      }
      function m(e, t) {
        (e.prototype = Object.create(t.prototype)),
          (e.prototype.constructor = e),
          (e.__proto__ = t);
      }
      function p(e, t) {
        if (null == e) return {};
        var n,
          o,
          r = {},
          a = Object.keys(e);
        for (o = 0; o < a.length; o++)
          (n = a[o]), t.indexOf(n) >= 0 || (r[n] = e[n]);
        return r;
      }
      function C(e, t) {
        var n;
        if ("undefined" == typeof Symbol || null == e[Symbol.iterator]) {
          if (
            Array.isArray(e) ||
            (n = (function (e, t) {
              if (!e) return;
              if ("string" == typeof e) return h(e, t);
              var n = Object.prototype.toString.call(e).slice(8, -1);
              "Object" === n && e.constructor && (n = e.constructor.name);
              if ("Map" === n || "Set" === n) return Array.from(e);
              if (
                "Arguments" === n ||
                /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)
              )
                return h(e, t);
            })(e)) ||
            (t && e && "number" == typeof e.length)
          ) {
            n && (e = n);
            var o = 0;
            return function () {
              return o >= e.length ? { done: !0 } : { done: !1, value: e[o++] };
            };
          }
          throw new TypeError(
            "Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."
          );
        }
        return (n = e[Symbol.iterator]()).next.bind(n);
      }
      function h(e, t) {
        (null == t || t > e.length) && (t = e.length);
        for (var n = 0, o = new Array(t); n < t; n++) o[n] = e[n];
        return o;
      }
      function N(e, t) {
        N = function (e, t) {
          return new a(e, undefined, t);
        };
        var n = b(RegExp),
          o = RegExp.prototype,
          r = new WeakMap();
        function a(e, t, o) {
          var a = n.call(this, e, t);
          return r.set(a, o || r.get(e)), a;
        }
        function c(e, t) {
          var n = r.get(t);
          return Object.keys(n).reduce(function (t, o) {
            return (t[o] = e[n[o]]), t;
          }, Object.create(null));
        }
        return (
          V(a, n),
          (a.prototype.exec = function (e) {
            var t = o.exec.call(this, e);
            return t && (t.groups = c(t, this)), t;
          }),
          (a.prototype[Symbol.replace] = function (e, t) {
            if ("string" == typeof t) {
              var n = r.get(this);
              return o[Symbol.replace].call(
                this,
                e,
                t.replace(/\$<([^>]+)>/g, function (e, t) {
                  return "$" + n[t];
                })
              );
            }
            if ("function" == typeof t) {
              var a = this;
              return o[Symbol.replace].call(this, e, function () {
                var e = [];
                return (
                  e.push.apply(e, arguments),
                  "object" != typeof e[e.length - 1] && e.push(c(e, a)),
                  t.apply(this, e)
                );
              });
            }
            return o[Symbol.replace].call(this, e, t);
          }),
          N.apply(this, arguments)
        );
      }
      function V(e, t) {
        if ("function" != typeof t && null !== t)
          throw new TypeError(
            "Super expression must either be null or a function"
          );
        (e.prototype = Object.create(t && t.prototype, {
          constructor: { value: e, writable: !0, configurable: !0 },
        })),
          t && v(e, t);
      }
      function b(e) {
        var t = "function" == typeof Map ? new Map() : undefined;
        return (b = function (e) {
          if (
            null === e ||
            ((n = e), -1 === Function.toString.call(n).indexOf("[native code]"))
          )
            return e;
          var n;
          if ("function" != typeof e)
            throw new TypeError(
              "Super expression must either be null or a function"
            );
          if (void 0 !== t) {
            if (t.has(e)) return t.get(e);
            t.set(e, o);
          }
          function o() {
            return f(e, arguments, k(this).constructor);
          }
          return (
            (o.prototype = Object.create(e.prototype, {
              constructor: {
                value: o,
                enumerable: !1,
                writable: !0,
                configurable: !0,
              },
            })),
            v(o, e)
          );
        })(e);
      }
      function f(e, t, n) {
        return (f = g()
          ? Reflect.construct
          : function (e, t, n) {
              var o = [null];
              o.push.apply(o, t);
              var r = new (Function.bind.apply(e, o))();
              return n && v(r, n.prototype), r;
            }).apply(null, arguments);
      }
      function g() {
        if ("undefined" == typeof Reflect || !Reflect.construct) return !1;
        if (Reflect.construct.sham) return !1;
        if ("function" == typeof Proxy) return !0;
        try {
          return (
            Date.prototype.toString.call(
              Reflect.construct(Date, [], function () {})
            ),
            !0
          );
        } catch (e) {
          return !1;
        }
      }
      function v(e, t) {
        return (v =
          Object.setPrototypeOf ||
          function (e, t) {
            return (e.__proto__ = t), e;
          })(e, t);
      }
      function k(e) {
        return (k = Object.setPrototypeOf
          ? Object.getPrototypeOf
          : function (e) {
              return e.__proto__ || Object.getPrototypeOf(e);
            })(e);
      }
      var w = function (e, t, n, o) {
          return (
            void 0 === o && (o = !1),
            "<span style=\"color:'" +
              n +
              "';font-family:'" +
              t +
              "';" +
              (o ? "font-weight: bold;" : "") +
              '">' +
              e +
              "</span>"
          );
        },
        B = /\[(_+)\]/g,
        x = N(
          /\[<input[\t-\r \xA0\u1680\u2000-\u200A\u2028\u2029\u202F\u205F\u3000\uFEFF]+(.*?)id="(paperfield_[0-9]+)"(.*?)\/>\]/gm,
          { id: 2 }
        ),
        _ = /%s(?:ign)?(?=\\s|$)/gim,
        L = function (e, t, n, o, r) {
          var a = e.replace(B, function (e, a, c, i) {
            var l =
              (function (e, t, n) {
                t = n + "x " + t;
                var o = document.createElement("canvas").getContext("2d");
                return (o.font = t), o.measureText(e).width;
              })(e, t, n) + "px";
            return (function (e, t, n, o, r, a) {
              return (
                '[<input type="text" style="font:\'' +
                o +
                "x " +
                n +
                "';color:'" +
                r +
                "';min-width:" +
                t +
                ";max-width:" +
                t +
                ';" id="' +
                a +
                '" maxlength=' +
                e +
                " size=" +
                e +
                " />]"
              );
            })(a.length, l, t, n, o, "paperfield_" + r++);
          });
          return { counter: r, text: a };
        },
        y = function (e) {
          return (
            e.stopPropagation && e.stopPropagation(),
            e.preventDefault && e.preventDefault(),
            (e.cancelBubble = !0),
            (e.returnValue = !1),
            !1
          );
        },
        S = function (e, t) {
          var n = e.image,
            a = e.opacity,
            c =
              (p(e, ["image", "opacity"]),
              "rotate(" +
                n.rotate +
                "deg) translate(" +
                n.x +
                "px," +
                n.y +
                "px)"),
            i = {
              transform: c,
              "-ms-transform": c,
              "-webkit-transform": c,
              opacity: a || 1,
              position: "absolute",
            };
          return (0, o.createVNode)(
            1,
            "div",
            (0, r.classes)(["paper121x54", n.sprite]),
            null,
            1,
            { style: i }
          );
        },
        I = function (e, t) {
          var n,
            r,
            a = e.value,
            c = e.stamps,
            i = e.backgroundColor,
            l = e.readOnly,
            u = c || [],
            s = {
              __html:
                '<span class="paper-text">' +
                ((n = a),
                (r = l),
                (r
                  ? n.replace(/<input\s[^d]/g, "<input disabled ")
                  : n.replace(/<input\sdisabled\s/g, "<input ")) + "</span>"),
            };
          return (0, o.createComponentVNode)(2, d.Box, {
            position: "relative",
            backgroundColor: i,
            width: "100%",
            height: "100%",
            children: [
              (0, o.createComponentVNode)(2, d.Box, {
                fillPositionedParent: !0,
                width: "100%",
                height: "100%",
                dangerouslySetInnerHTML: s,
                p: "10px",
              }),
              u.map(function (e, t) {
                return (0,
                o.createComponentVNode)(2, S, { image: { sprite: e[0], x: e[1], y: e[2], rotate: e[3] } }, e[0] + t);
              }),
            ],
          });
        },
        T = (function (e) {
          function t(t, n) {
            var o;
            return (
              ((o = e.call(this, t, n) || this).state = {
                x: 0,
                y: 0,
                rotate: 0,
              }),
              o
            );
          }
          m(t, e);
          var n = t.prototype;
          return (
            (n.findStampPosition = function (e) {
              for (
                var t = event.pageX,
                  n = event.pageY,
                  o = { left: e.target.offsetLeft, top: e.target.offsetTop },
                  r = e.target.offsetParent;
                r;

              )
                (o.left += r.offsetLeft),
                  (o.top += r.offsetTop),
                  (r = r.offsetParent);
              var c = [t - o.left, n - o.top],
                i = (0, a.vecScale)([121, 51], 0.5);
              return (0, a.vecSubtract)(c, i);
            }),
            (n.componentDidMount = function () {
              document.onwheel = this.handleWheel.bind(this);
            }),
            (n.handleMouseMove = function (e) {
              var t = this.findStampPosition(e);
              y(e), this.setState({ x: t[0], y: t[1] });
            }),
            (n.handleMouseClick = function (e) {
              var t = this.findStampPosition(e),
                n = (0, l.useBackend)(this.context),
                o = n.act,
                r = n.data;
              o("stamp", {
                x: t[0],
                y: t[1],
                r: this.state.rotate,
                stamp_class: this.props.stamp_class,
                stamp_icon_state: r.stamp_icon_state,
              }),
                this.setState({ x: t[0], y: t[1] });
            }),
            (n.handleWheel = function (e) {
              var t = e.deltaY > 0 ? 15 : -15;
              if (e.deltaY < 0 && 0 === this.state.rotate)
                this.setState({ rotate: 360 + t });
              else if (e.deltaY > 0 && 360 === this.state.rotate)
                this.setState({ rotate: t });
              else {
                var n = { rotate: t + this.state.rotate };
                this.setState(function () {
                  return n;
                });
              }
              y(e);
            }),
            (n.render = function () {
              var e = this.props,
                t = e.value,
                n = e.stamp_class,
                r = e.stamps,
                a = p(e, ["value", "stamp_class", "stamps"]),
                c = r || [],
                i = {
                  sprite: n,
                  x: this.state.x,
                  y: this.state.y,
                  rotate: this.state.rotate,
                };
              return (0, o.normalizeProps)(
                (0, o.createComponentVNode)(
                  2,
                  d.Box,
                  Object.assign(
                    {
                      onClick: this.handleMouseClick.bind(this),
                      onMouseMove: this.handleMouseMove.bind(this),
                      onwheel: this.handleWheel.bind(this),
                    },
                    a,
                    {
                      children: [
                        (0, o.createComponentVNode)(2, I, {
                          readOnly: !0,
                          value: t,
                          stamps: c,
                        }),
                        (0, o.createComponentVNode)(2, S, {
                          opacity: 0.5,
                          image: i,
                        }),
                      ],
                    }
                  )
                )
              );
            }),
            t
          );
        })(o.Component),
        A = (function (e) {
          function t(t, n) {
            var o;
            return (
              ((o = e.call(this, t, n) || this).state = {
                previewSelected: "Preview",
                old_text: t.value || "",
                textarea_text: "",
                combined_text: t.value || "",
              }),
              o
            );
          }
          m(t, e);
          var n = t.prototype;
          return (
            (n.createPreview = function (e, t) {
              void 0 === t && (t = !1);
              var n,
                o,
                r = (0, l.useBackend)(this.context).data,
                a = r.text,
                d = r.pen_color,
                u = r.pen_font,
                s = r.is_crayon,
                m = r.field_counter,
                p = r.edit_usr,
                h = { text: a };
              if ((e = e.trim()).length > 0) {
                var N = (function (e) {
                    return c["default"].sanitize(e, {
                      FORBID_ATTR: ["class", "style"],
                      ALLOWED_TAGS: [
                        "br",
                        "code",
                        "li",
                        "p",
                        "pre",
                        "span",
                        "table",
                        "td",
                        "tr",
                        "th",
                        "ul",
                        "ol",
                        "menu",
                        "font",
                        "b",
                        "center",
                        "table",
                        "tr",
                        "th",
                      ],
                    });
                  })((e += "\n" === e[e.length] ? " \n" : "\n \n")),
                  V =
                    ((n = d),
                    (o = p),
                    N.replace(_, function () {
                      return w(o, "Times New Roman", n, !0);
                    })),
                  b = L(V, u, 12, d, m),
                  f = (function (e) {
                    return (0, i["default"])(e, {
                      breaks: !0,
                      smartypants: !0,
                      smartLists: !0,
                      walkTokens: function (e) {
                        switch (e.type) {
                          case "url":
                          case "autolink":
                          case "reflink":
                          case "link":
                          case "image":
                            (e.type = "text"), (e.href = "");
                        }
                      },
                      baseUrl: "thisshouldbreakhttp",
                    });
                  })(b.text),
                  g = w(f, u, d, s);
                (h.text += g), (h.field_counter = b.counter);
              }
              if (t) {
                var v = (function (e, t, n, o, r) {
                  var a;
                  void 0 === r && (r = !1);
                  for (var i = {}, l = []; null !== (a = x.exec(e)); ) {
                    var d = a[0],
                      u = a.groups.id;
                    if (u) {
                      var s = document.getElementById(u);
                      if (0 === (s && s.value ? s.value : "").length) continue;
                      var m = c["default"].sanitize(s.value.trim(), {
                        ALLOWED_TAGS: [],
                      });
                      if (0 === m.length) continue;
                      var p = s.cloneNode(!0);
                      m.match(_)
                        ? ((p.style.fontFamily = "Times New Roman"),
                          (r = !0),
                          (p.defaultValue = o))
                        : ((p.style.fontFamily = t), (p.defaultValue = m)),
                        r && (p.style.fontWeight = "bold"),
                        (p.style.color = n),
                        (p.disabled = !0);
                      var h = document.createElement("div");
                      h.appendChild(p),
                        (i[u] = m),
                        l.push({ value: "[" + h.innerHTML + "]", raw_text: d });
                    }
                  }
                  if (l.length > 0)
                    for (var N, V = C(l); !(N = V()).done; ) {
                      var b = N.value;
                      e = e.replace(b.raw_text, b.value);
                    }
                  return { text: e, fields: i };
                })(h.text, u, d, p, s);
                (h.text = v.text), (h.form_fields = v.fields);
              }
              return h;
            }),
            (n.onInputHandler = function (e, t) {
              var n = this;
              if (t !== this.state.textarea_text) {
                var o =
                  this.state.old_text.length + this.state.textarea_text.length;
                if (
                  o > 5e3 &&
                  (t =
                    o - 5e3 >= t.length
                      ? ""
                      : t.substr(0, t.length - (o - 5e3))) ===
                    this.state.textarea_text
                )
                  return;
                this.setState(function () {
                  return {
                    textarea_text: t,
                    combined_text: n.createPreview(t),
                  };
                });
              }
            }),
            (n.finalUpdate = function (e) {
              var t = (0, l.useBackend)(this.context).act,
                n = this.createPreview(e, !0);
              t("save", n),
                this.setState(function () {
                  return {
                    textarea_text: "",
                    previewSelected: "save",
                    combined_text: n.text,
                  };
                });
            }),
            (n.render = function () {
              var e = this,
                t = this.props,
                n = (t.value, t.textColor),
                r = t.fontFamily,
                a = t.stamps,
                c = t.backgroundColor;
              return (
                p(t, [
                  "value",
                  "textColor",
                  "fontFamily",
                  "stamps",
                  "backgroundColor",
                ]),
                (0, o.createComponentVNode)(2, d.Flex, {
                  direction: "column",
                  fillPositionedParent: !0,
                  children: [
                    (0, o.createComponentVNode)(2, d.Flex.Item, {
                      children: (0, o.createComponentVNode)(2, d.Tabs, {
                        children: [
                          (0, o.createComponentVNode)(
                            2,
                            d.Tabs.Tab,
                            {
                              textColor: "black",
                              backgroundColor:
                                "Edit" === this.state.previewSelected
                                  ? "grey"
                                  : "white",
                              selected: "Edit" === this.state.previewSelected,
                              onClick: function () {
                                return e.setState({ previewSelected: "Edit" });
                              },
                              children: "Edit",
                            },
                            "marked_edit"
                          ),
                          (0, o.createComponentVNode)(
                            2,
                            d.Tabs.Tab,
                            {
                              textColor: "black",
                              backgroundColor:
                                "Preview" === this.state.previewSelected
                                  ? "grey"
                                  : "white",
                              selected:
                                "Preview" === this.state.previewSelected,
                              onClick: function () {
                                return e.setState(function () {
                                  return {
                                    previewSelected: "Preview",
                                    textarea_text: e.state.textarea_text,
                                    combined_text: e.createPreview(
                                      e.state.textarea_text
                                    ).text,
                                  };
                                });
                              },
                              children: "Preview",
                            },
                            "marked_preview"
                          ),
                          (0, o.createComponentVNode)(
                            2,
                            d.Tabs.Tab,
                            {
                              textColor: "black",
                              backgroundColor:
                                "confirm" === this.state.previewSelected
                                  ? "red"
                                  : "save" === this.state.previewSelected
                                  ? "grey"
                                  : "white",
                              selected:
                                "confirm" === this.state.previewSelected ||
                                "save" === this.state.previewSelected,
                              onClick: function () {
                                "confirm" === e.state.previewSelected
                                  ? e.finalUpdate(e.state.textarea_text)
                                  : "Edit" === e.state.previewSelected
                                  ? e.setState(function () {
                                      return {
                                        previewSelected: "confirm",
                                        textarea_text: e.state.textarea_text,
                                        combined_text: e.createPreview(
                                          e.state.textarea_text
                                        ).text,
                                      };
                                    })
                                  : e.setState({ previewSelected: "confirm" });
                              },
                              children:
                                "confirm" === this.state.previewSelected
                                  ? "confirm"
                                  : "save",
                            },
                            "marked_done"
                          ),
                        ],
                      }),
                    }),
                    (0, o.createComponentVNode)(2, d.Flex.Item, {
                      grow: 1,
                      basis: 1,
                      children:
                        ("Edit" === this.state.previewSelected &&
                          (0, o.createComponentVNode)(2, d.TextArea, {
                            value: this.state.textarea_text,
                            textColor: n,
                            fontFamily: r,
                            height: window.innerHeight - 80 + "px",
                            backgroundColor: c,
                            onInput: this.onInputHandler.bind(this),
                          })) ||
                        (0, o.createComponentVNode)(2, I, {
                          value: this.state.combined_text,
                          stamps: a,
                          fontFamily: r,
                          textColor: n,
                        }),
                    }),
                  ],
                })
              );
            }),
            t
          );
        })(o.Component);
      t.PaperSheet = function (e, t) {
        var n = (0, l.useBackend)(t).data,
          r = n.edit_mode,
          a = n.text,
          c = n.paper_color,
          i = n.pen_color,
          s = void 0 === i ? "black" : i,
          m = n.pen_font,
          p = void 0 === m ? "Verdana" : m,
          C = n.stamps,
          h = n.stamp_class,
          N = (n.stamped, c && "white" !== c ? c : "#FFFFFF"),
          V = C && null !== C ? C : [];
        return (0, o.createComponentVNode)(2, u.Window, {
          theme: "paper",
          width: 400,
          height: 500,
          resizable: !0,
          children: (0, o.createComponentVNode)(2, u.Window.Content, {
            children: (0, o.createComponentVNode)(2, d.Box, {
              fillPositionedParent: !0,
              backgroundColor: N,
              children: (function (e) {
                switch (e) {
                  case 0:
                    return (0, o.createComponentVNode)(2, I, {
                      value: a,
                      stamps: V,
                      readOnly: !0,
                    });
                  case 1:
                    return (0, o.createComponentVNode)(2, A, {
                      value: a,
                      textColor: s,
                      fontFamily: p,
                      stamps: V,
                      backgroundColor: N,
                    });
                  case 2:
                    return (0, o.createComponentVNode)(2, T, {
                      value: a,
                      stamps: V,
                      stamp_class: h,
                    });
                  default:
                    return "ERROR ERROR WE CANNOT BE HERE!!";
                }
              })(r),
            }),
          }),
        });
      };
    },
    ,
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ParticleAccelerator = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.ParticleAccelerator = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.assembled,
          u = l.power,
          s = l.strength;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 350,
          height: 185,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Status",
                    buttons: (0, o.createComponentVNode)(2, a.Button, {
                      icon: "sync",
                      content: "Run Scan",
                      onClick: function () {
                        return i("scan");
                      },
                    }),
                    children: (0, o.createComponentVNode)(2, a.Box, {
                      color: d ? "good" : "bad",
                      children: d
                        ? "Ready - All parts in place"
                        : "Unable to detect all parts",
                    }),
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Particle Accelerator Controls",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Power",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: u ? "power-off" : "times",
                        content: u ? "On" : "Off",
                        selected: u,
                        disabled: !d,
                        onClick: function () {
                          return i("power");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Particle Strength",
                      children: [
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "backward",
                          disabled: !d,
                          onClick: function () {
                            return i("remove_strength");
                          },
                        }),
                        " ",
                        String(s).padStart(1, "0"),
                        " ",
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "forward",
                          disabled: !d,
                          onClick: function () {
                            return i("add_strength");
                          },
                        }),
                      ],
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.PatchDispenser = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.PatchDispenser = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.patch_size,
          u = l.patch_name;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 300,
          height: 120,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Patch Volume",
                    children: (0, o.createComponentVNode)(2, a.NumberInput, {
                      value: d,
                      unit: "u",
                      width: "43px",
                      minValue: 5,
                      maxValue: 40,
                      step: 1,
                      stepPixelSize: 2,
                      onChange: function (e, t) {
                        return i("change_patch_size", { volume: t });
                      },
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Patch Name",
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      icon: "pencil-alt",
                      content: u,
                      onClick: function () {
                        return i("change_patch_name");
                      },
                    }),
                  }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.PersonalCrafting = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      function i(e, t) {
        var n;
        if ("undefined" == typeof Symbol || null == e[Symbol.iterator]) {
          if (
            Array.isArray(e) ||
            (n = (function (e, t) {
              if (!e) return;
              if ("string" == typeof e) return l(e, t);
              var n = Object.prototype.toString.call(e).slice(8, -1);
              "Object" === n && e.constructor && (n = e.constructor.name);
              if ("Map" === n || "Set" === n) return Array.from(e);
              if (
                "Arguments" === n ||
                /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)
              )
                return l(e, t);
            })(e)) ||
            (t && e && "number" == typeof e.length)
          ) {
            n && (e = n);
            var o = 0;
            return function () {
              return o >= e.length ? { done: !0 } : { done: !1, value: e[o++] };
            };
          }
          throw new TypeError(
            "Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."
          );
        }
        return (n = e[Symbol.iterator]()).next.bind(n);
      }
      function l(e, t) {
        (null == t || t > e.length) && (t = e.length);
        for (var n = 0, o = new Array(t); n < t; n++) o[n] = e[n];
        return o;
      }
      t.PersonalCrafting = function (e, t) {
        for (
          var n,
            l = (0, r.useBackend)(t),
            u = l.act,
            s = l.data,
            m = s.busy,
            p = s.display_craftable_only,
            C = s.display_compact,
            h = s.crafting_recipes || {},
            N = [],
            V = [],
            b = 0,
            f = Object.keys(h);
          b < f.length;
          b++
        ) {
          var g = f[b],
            v = h[g];
          if ("has_subcats" in v)
            for (var k = 0, w = Object.keys(v); k < w.length; k++) {
              var B = w[k];
              if ("has_subcats" !== B) {
                N.push({ name: B, category: g, subcategory: B });
                for (var x, _ = i(v[B]); !(x = _()).done; ) {
                  var L = x.value;
                  V.push(Object.assign({}, L, { category: B }));
                }
              }
            }
          else {
            N.push({ name: g, category: g });
            for (var y, S = i(h[g]); !(y = S()).done; ) {
              var I = y.value;
              V.push(Object.assign({}, I, { category: g }));
            }
          }
        }
        var T = (0, r.useLocalState)(
            t,
            "tab",
            null == (n = N[0]) ? void 0 : n.name
          ),
          A = T[0],
          P = T[1],
          M = V.filter(function (e) {
            return e.category === A;
          });
        return (0, o.createComponentVNode)(2, c.Window, {
          title: "Crafting Menu",
          width: 700,
          height: 800,
          resizable: !0,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              !!m &&
                (0, o.createComponentVNode)(2, a.Dimmer, {
                  fontSize: "32px",
                  children: [
                    (0, o.createComponentVNode)(2, a.Icon, {
                      name: "cog",
                      spin: 1,
                    }),
                    " Crafting...",
                  ],
                }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Personal Crafting",
                buttons: (0, o.createFragment)(
                  [
                    (0, o.createComponentVNode)(2, a.Button.Checkbox, {
                      content: "Compact",
                      checked: C,
                      onClick: function () {
                        return u("toggle_compact");
                      },
                    }),
                    (0, o.createComponentVNode)(2, a.Button.Checkbox, {
                      content: "Craftable Only",
                      checked: p,
                      onClick: function () {
                        return u("toggle_recipes");
                      },
                    }),
                  ],
                  4
                ),
                children: (0, o.createComponentVNode)(2, a.Flex, {
                  children: [
                    (0, o.createComponentVNode)(2, a.Flex.Item, {
                      children: (0, o.createComponentVNode)(2, a.Tabs, {
                        vertical: !0,
                        children: N.map(function (e) {
                          return (0, o.createComponentVNode)(
                            2,
                            a.Tabs.Tab,
                            {
                              selected: e.name === A,
                              onClick: function () {
                                P(e.name),
                                  u("set_category", {
                                    category: e.category,
                                    subcategory: e.subcategory,
                                  });
                              },
                              children: e.name,
                            },
                            e.name
                          );
                        }),
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.Flex.Item, {
                      grow: 1,
                      basis: 0,
                      children: (0, o.createComponentVNode)(2, d, {
                        craftables: M,
                      }),
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
      var d = function (e, t) {
        var n = e.craftables,
          c = void 0 === n ? [] : n,
          i = (0, r.useBackend)(t),
          l = i.act,
          d = i.data,
          u = d.craftability,
          s = void 0 === u ? {} : u,
          m = d.display_compact,
          p = d.display_craftable_only;
        return c.map(function (e) {
          return p && !s[e.ref]
            ? null
            : m
            ? (0, o.createComponentVNode)(
                2,
                a.LabeledList.Item,
                {
                  label: e.name,
                  className: "candystripe",
                  buttons: (0, o.createComponentVNode)(2, a.Button, {
                    icon: "cog",
                    content: "Craft",
                    disabled: !s[e.ref],
                    tooltip: e.tool_text && "Tools needed: " + e.tool_text,
                    tooltipPosition: "left",
                    onClick: function () {
                      return l("make", { recipe: e.ref });
                    },
                  }),
                  children: e.req_text,
                },
                e.name
              )
            : (0, o.createComponentVNode)(
                2,
                a.Section,
                {
                  title: e.name,
                  level: 2,
                  buttons: (0, o.createComponentVNode)(2, a.Button, {
                    icon: "cog",
                    content: "Craft",
                    disabled: !s[e.ref],
                    onClick: function () {
                      return l("make", { recipe: e.ref });
                    },
                  }),
                  children: (0, o.createComponentVNode)(2, a.LabeledList, {
                    children: [
                      !!e.req_text &&
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Required",
                          children: e.req_text,
                        }),
                      !!e.catalyst_text &&
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Catalyst",
                          children: e.catalyst_text,
                        }),
                      !!e.tool_text &&
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Tools",
                          children: e.tool_text,
                        }),
                    ],
                  }),
                },
                e.name
              );
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.PortableGenerator = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.PortableGenerator = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.stack_percent,
          u = (d > 50 ? "good" : d > 15 && "average") || "bad";
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              !l.anchored &&
                (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children: "Generator not anchored.",
                }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Status",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Power switch",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: l.active ? "power-off" : "times",
                        onClick: function () {
                          return i("toggle_power");
                        },
                        disabled: !l.ready_to_boot,
                        children: l.active ? "On" : "Off",
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: l.sheet_name + " sheets",
                      children: [
                        (0, o.createComponentVNode)(2, a.Box, {
                          inline: !0,
                          color: u,
                          children: l.sheets,
                        }),
                        l.sheets >= 1 &&
                          (0, o.createComponentVNode)(2, a.Button, {
                            ml: 1,
                            icon: "eject",
                            disabled: l.active,
                            onClick: function () {
                              return i("eject");
                            },
                            children: "Eject",
                          }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Current sheet level",
                      children: (0, o.createComponentVNode)(2, a.ProgressBar, {
                        value: l.stack_percent / 100,
                        ranges: {
                          good: [0.1, Infinity],
                          average: [0.01, 0.1],
                          bad: [-Infinity, 0.01],
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Heat level",
                      children:
                        l.current_heat < 100
                          ? (0, o.createComponentVNode)(2, a.Box, {
                              inline: !0,
                              color: "good",
                              children: "Nominal",
                            })
                          : l.current_heat < 200
                          ? (0, o.createComponentVNode)(2, a.Box, {
                              inline: !0,
                              color: "average",
                              children: "Caution",
                            })
                          : (0, o.createComponentVNode)(2, a.Box, {
                              inline: !0,
                              color: "bad",
                              children: "DANGER",
                            }),
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Output",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Current output",
                      children: l.power_output,
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Adjust output",
                      children: [
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "minus",
                          onClick: function () {
                            return i("lower_power");
                          },
                          children: l.power_generated,
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "plus",
                          onClick: function () {
                            return i("higher_power");
                          },
                          children: l.power_generated,
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Power available",
                      children: (0, o.createComponentVNode)(2, a.Box, {
                        inline: !0,
                        color: !l.connected && "bad",
                        children: l.connected
                          ? l.power_available
                          : "Unconnected",
                      }),
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.PortablePump = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = n(210);
      t.PortablePump = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.direction,
          s = (d.holding, d.target_pressure),
          m = d.default_pressure,
          p = d.min_pressure,
          C = d.max_pressure;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 300,
          height: 315,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, i.PortableBasicInfo),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Pump",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: u ? "sign-in-alt" : "sign-out-alt",
                  content: u ? "In" : "Out",
                  selected: u,
                  onClick: function () {
                    return l("direction");
                  },
                }),
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Output",
                      children: (0, o.createComponentVNode)(2, a.NumberInput, {
                        value: s,
                        unit: "kPa",
                        width: "75px",
                        minValue: p,
                        maxValue: C,
                        step: 10,
                        onChange: function (e, t) {
                          return l("pressure", { pressure: t });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Presets",
                      children: [
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "minus",
                          disabled: s === p,
                          onClick: function () {
                            return l("pressure", { pressure: "min" });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "sync",
                          disabled: s === m,
                          onClick: function () {
                            return l("pressure", { pressure: "reset" });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "plus",
                          disabled: s === C,
                          onClick: function () {
                            return l("pressure", { pressure: "max" });
                          },
                        }),
                      ],
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.PortableScrubber = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(44),
        i = n(3),
        l = n(210);
      t.PortableScrubber = function (e, t) {
        var n = (0, r.useBackend)(t),
          d = n.act,
          u = n.data.filter_types || [];
        return (0, o.createComponentVNode)(2, i.Window, {
          width: 320,
          height: 350,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, l.PortableBasicInfo),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Filters",
                children: u.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    a.Button,
                    {
                      icon: e.enabled ? "check-square-o" : "square-o",
                      content: (0, c.getGasLabel)(e.gas_id, e.gas_name),
                      selected: e.enabled,
                      onClick: function () {
                        return d("toggle_filter", { val: e.gas_id });
                      },
                    },
                    e.id
                  );
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ProximitySensor = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.ProximitySensor = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.minutes,
          u = l.seconds,
          s = l.timing,
          m = l.scanning,
          p = l.sensitivity;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 250,
          height: 185,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Status",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: m ? "lock" : "unlock",
                        content: m ? "Armed" : "Not Armed",
                        selected: m,
                        onClick: function () {
                          return i("scanning");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Detection Range",
                      children: [
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "backward",
                          disabled: m,
                          onClick: function () {
                            return i("sense", { range: -1 });
                          },
                        }),
                        " ",
                        String(p).padStart(1, "1"),
                        " ",
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "forward",
                          disabled: m,
                          onClick: function () {
                            return i("sense", { range: 1 });
                          },
                        }),
                      ],
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Auto Arm",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: "clock-o",
                  content: s ? "Stop" : "Start",
                  selected: s,
                  disabled: m,
                  onClick: function () {
                    return i("time");
                  },
                }),
                children: [
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: "fast-backward",
                    disabled: m || s,
                    onClick: function () {
                      return i("input", { adjust: -30 });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: "backward",
                    disabled: m || s,
                    onClick: function () {
                      return i("input", { adjust: -1 });
                    },
                  }),
                  " ",
                  String(d).padStart(2, "0"),
                  ":",
                  String(u).padStart(2, "0"),
                  " ",
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: "forward",
                    disabled: m || s,
                    onClick: function () {
                      return i("input", { adjust: 1 });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: "fast-forward",
                    disabled: m || s,
                    onClick: function () {
                      return i("input", { adjust: 30 });
                    },
                  }),
                ],
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.RDConsole = void 0);
      var o = n(0),
        r = (n(21), n(2)),
        a = n(1),
        c = (n(52), n(3)),
        i = n(8);
      function l(e, t) {
        if (null == e) return {};
        var n,
          o,
          r = {},
          a = Object.keys(e);
        for (o = 0; o < a.length; o++)
          (n = a[o]), t.indexOf(n) >= 0 || (r[n] = e[n]);
        return r;
      }
      var d = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            d = (n.data, e.value),
            u = l(e, ["value"]),
            s = d.name,
            m = d.server_id,
            p = d.temperature,
            C = d.temperature_warning,
            h = d.temperature_max,
            N = d.enabled,
            V = (p < C ? "good" : p > C && p < h && "average") || "bad",
            b =
              (d.overheated ? "Halted" : p > C && p < h && "Warning") ||
              "Normal";
          return (0, o.normalizeProps)(
            (0, o.createComponentVNode)(
              2,
              a.Box,
              Object.assign({}, u, {
                width: "170px",
                style: { border: "1px solid #000000" },
                children: (0, o.createComponentVNode)(2, a.Flex, {
                  mx: 0.5,
                  my: 0.5,
                  direction: "row",
                  justify: "space-around",
                  children: [
                    (0, o.createComponentVNode)(2, a.Flex, {
                      direction: "column",
                      align: "auto",
                      children: [
                        (0, o.createComponentVNode)(2, a.Flex.Item, {
                          color: "label",
                          children: s,
                        }),
                        (0, o.createComponentVNode)(2, a.Flex.Item, {
                          children: (0, o.createComponentVNode)(2, a.Flex, {
                            direction: "row",
                            justify: "space-between",
                            children: [
                              (0, o.createComponentVNode)(2, a.Flex.Item, {
                                textAlign: "left",
                                align: "left",
                                color: V,
                                children: b,
                              }),
                              (0, o.createComponentVNode)(2, a.Flex.Item, {
                                textAlign: "right",
                                align: "right",
                                color: V,
                                children: [
                                  (0, o.createComponentVNode)(
                                    2,
                                    a.AnimatedNumber,
                                    { value: (0, i.toFixed)(p) }
                                  ),
                                  " K",
                                ],
                              }),
                            ],
                          }),
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.Flex.Item, {
                      align: "center",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: N ? "sync-alt" : "times",
                        selected: N,
                        onClick: function () {
                          return c("enable_server", { server_id: m });
                        },
                        children: N ? "On" : "Off",
                      }),
                    }),
                  ],
                }),
              })
            )
          );
        },
        u = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = (n.act, n.data, e.value),
            i = l(e, ["value"]),
            d = c.entry,
            u = void 0 === d ? "" : d,
            s = c.research_name,
            m = void 0 === s ? "" : s,
            p = c.cost,
            C = void 0 === p ? "" : p,
            h = c.researcher_name,
            N = void 0 === h ? "" : h,
            V = c.location,
            b = void 0 === V ? "" : V;
          return (0, o.normalizeProps)(
            (0, o.createComponentVNode)(
              2,
              a.Flex,
              Object.assign({}, i, {
                align: "baseline",
                justify: "space-between",
                children: [
                  (0, o.createComponentVNode)(2, a.Flex.Item, {
                    width: 3,
                    children: u,
                  }),
                  (0, o.createComponentVNode)(2, a.Flex.Item, {
                    width: 20,
                    children: m,
                  }),
                  (0, o.createComponentVNode)(2, a.Flex.Item, {
                    width: 10,
                    children: C,
                  }),
                  (0, o.createComponentVNode)(2, a.Flex.Item, {
                    width: 20,
                    children: N,
                  }),
                  (0, o.createComponentVNode)(2, a.Flex.Item, {
                    width: 20,
                    children: b,
                  }),
                ],
              })
            )
          );
        };
      t.RDConsole = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = (n.act, n.data),
          l = i.logs,
          s = void 0 === l ? [] : l,
          m = i.servers,
          p = void 0 === m ? [] : m;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 900,
          height: 750,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Servers",
                children: p.map(function (e) {
                  return (0,
                  o.createComponentVNode)(2, d, { value: e }, e.name);
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Access Logs",
                children: (0, o.createComponentVNode)(2, a.Flex, {
                  direction: "column",
                  children: [
                    (0, o.createComponentVNode)(
                      2,
                      u,
                      {
                        color: "label",
                        value: {
                          researcher_name: "Researcher",
                          research_name: "Technology",
                          cost: "Cost",
                          location: "Location",
                        },
                      },
                      "logheader"
                    ),
                    s.map(function (e) {
                      return (0,
                      o.createComponentVNode)(2, u, { value: e }, e.entry);
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Radio = void 0);
      var o = n(0),
        r = n(21),
        a = n(8),
        c = n(2),
        i = n(1),
        l = n(44),
        d = n(3);
      t.Radio = function (e, t) {
        var n = (0, c.useBackend)(t),
          u = n.act,
          s = n.data,
          m = s.freqlock,
          p = s.frequency,
          C = s.minFrequency,
          h = s.maxFrequency,
          N = s.listening,
          V = s.broadcasting,
          b = s.command,
          f = s.useCommand,
          g = s.subspace,
          v = s.subspaceSwitchable,
          k = l.RADIO_CHANNELS.find(function (e) {
            return e.freq === p;
          }),
          w = (0, r.map)(function (e, t) {
            return { name: t, status: !!e };
          })(s.channels);
        return (0, o.createComponentVNode)(2, d.Window, {
          width: 360,
          height: 106 + (w.len > 0 ? 6 + 21 * w.len : 24),
          children: (0, o.createComponentVNode)(2, d.Window.Content, {
            children: (0, o.createComponentVNode)(2, i.Section, {
              children: (0, o.createComponentVNode)(2, i.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                    label: "Frequency",
                    children: [
                      (m &&
                        (0, o.createComponentVNode)(2, i.Box, {
                          inline: !0,
                          color: "light-gray",
                          children: (0, a.toFixed)(p / 10, 1) + " kHz",
                        })) ||
                        (0, o.createComponentVNode)(2, i.NumberInput, {
                          animate: !0,
                          unit: "kHz",
                          step: 0.2,
                          stepPixelSize: 10,
                          minValue: C / 10,
                          maxValue: h / 10,
                          value: p / 10,
                          format: function (e) {
                            return (0, a.toFixed)(e, 1);
                          },
                          onDrag: function (e, t) {
                            return u("frequency", { adjust: t - p / 10 });
                          },
                        }),
                      k &&
                        (0, o.createComponentVNode)(2, i.Box, {
                          inline: !0,
                          color: k.color,
                          ml: 2,
                          children: ["[", k.name, "]"],
                        }),
                    ],
                  }),
                  (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                    label: "Audio",
                    children: [
                      (0, o.createComponentVNode)(2, i.Button, {
                        textAlign: "center",
                        width: "37px",
                        icon: N ? "volume-up" : "volume-mute",
                        selected: N,
                        onClick: function () {
                          return u("listen");
                        },
                      }),
                      (0, o.createComponentVNode)(2, i.Button, {
                        textAlign: "center",
                        width: "37px",
                        icon: V ? "microphone" : "microphone-slash",
                        selected: V,
                        onClick: function () {
                          return u("broadcast");
                        },
                      }),
                      !!b &&
                        (0, o.createComponentVNode)(2, i.Button, {
                          ml: 1,
                          icon: "bullhorn",
                          selected: f,
                          content: "High volume " + (f ? "ON" : "OFF"),
                          onClick: function () {
                            return u("command");
                          },
                        }),
                      !!v &&
                        (0, o.createComponentVNode)(2, i.Button, {
                          ml: 1,
                          icon: "bullhorn",
                          selected: g,
                          content: "Subspace Tx " + (g ? "ON" : "OFF"),
                          onClick: function () {
                            return u("subspace");
                          },
                        }),
                    ],
                  }),
                  !!g &&
                    (0, o.createComponentVNode)(2, i.LabeledList.Item, {
                      label: "Channels",
                      children: [
                        0 === w.length &&
                          (0, o.createComponentVNode)(2, i.Box, {
                            inline: !0,
                            color: "bad",
                            children: "No encryption keys installed.",
                          }),
                        w.map(function (e) {
                          return (0, o.createComponentVNode)(
                            2,
                            i.Box,
                            {
                              children: (0, o.createComponentVNode)(
                                2,
                                i.Button,
                                {
                                  icon: e.status
                                    ? "check-square-o"
                                    : "square-o",
                                  selected: e.status,
                                  content: e.name,
                                  onClick: function () {
                                    return u("channel", { channel: e.name });
                                  },
                                }
                              ),
                            },
                            e.name
                          );
                        }),
                      ],
                    }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.RadioactiveMicrolaser = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.RadioactiveMicrolaser = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.irradiate,
          u = l.stealth,
          s = l.scanmode,
          m = l.intensity,
          p = l.wavelength,
          C = l.on_cooldown,
          h = l.cooldown;
        return (0, o.createComponentVNode)(2, c.Window, {
          theme: "syndicate",
          width: 320,
          height: 335,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Laser Status",
                    children: (0, o.createComponentVNode)(2, a.Box, {
                      color: C ? "average" : "good",
                      children: C ? "Recharging" : "Ready",
                    }),
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Scanner Controls",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Irradiation",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: d ? "power-off" : "times",
                        content: d ? "On" : "Off",
                        selected: d,
                        onClick: function () {
                          return i("irradiate");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Stealth Mode",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: u ? "eye-slash" : "eye",
                        content: u ? "On" : "Off",
                        disabled: !d,
                        selected: u,
                        onClick: function () {
                          return i("stealth");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Scan Mode",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: s ? "mortar-pestle" : "heartbeat",
                        content: s ? "Scan Reagents" : "Scan Health",
                        disabled: d && u,
                        onClick: function () {
                          return i("scanmode");
                        },
                      }),
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Laser Settings",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Radiation Intensity",
                      children: [
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "fast-backward",
                          onClick: function () {
                            return i("radintensity", { adjust: -5 });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "backward",
                          onClick: function () {
                            return i("radintensity", { adjust: -1 });
                          },
                        }),
                        " ",
                        (0, o.createComponentVNode)(2, a.NumberInput, {
                          value: Math.round(m),
                          width: "40px",
                          minValue: 1,
                          maxValue: 20,
                          onChange: function (e, t) {
                            return i("radintensity", { target: t });
                          },
                        }),
                        " ",
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "forward",
                          onClick: function () {
                            return i("radintensity", { adjust: 1 });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "fast-forward",
                          onClick: function () {
                            return i("radintensity", { adjust: 5 });
                          },
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Radiation Wavelength",
                      children: [
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "fast-backward",
                          onClick: function () {
                            return i("radwavelength", { adjust: -5 });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "backward",
                          onClick: function () {
                            return i("radwavelength", { adjust: -1 });
                          },
                        }),
                        " ",
                        (0, o.createComponentVNode)(2, a.NumberInput, {
                          value: Math.round(p),
                          width: "40px",
                          minValue: 0,
                          maxValue: 120,
                          onChange: function (e, t) {
                            return i("radwavelength", { target: t });
                          },
                        }),
                        " ",
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "forward",
                          onClick: function () {
                            return i("radwavelength", { adjust: 1 });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: "fast-forward",
                          onClick: function () {
                            return i("radwavelength", { adjust: 5 });
                          },
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Laser Cooldown",
                      children: (0, o.createComponentVNode)(2, a.Box, {
                        inline: !0,
                        bold: !0,
                        children: h,
                      }),
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.RapidPipeDispenser = void 0);
      var o = n(0),
        r = n(6),
        a = n(2),
        c = n(1),
        i = n(3),
        l = ["Atmospherics", "Disposals", "Transit Tubes"],
        d = {
          Atmospherics: "wrench",
          Disposals: "trash-alt",
          "Transit Tubes": "bus",
          Pipes: "grip-lines",
          "Disposal Pipes": "grip-lines",
          Devices: "microchip",
          "Heat Exchange": "thermometer-half",
          "Station Equipment": "microchip",
        },
        u = {
          grey: "#bbbbbb",
          amethyst: "#a365ff",
          blue: "#4466ff",
          brown: "#b26438",
          cyan: "#48eae8",
          dark: "#808080",
          green: "#1edd00",
          orange: "#ffa030",
          purple: "#b535ea",
          red: "#ff3333",
          violet: "#6e00f6",
          yellow: "#ffce26",
        },
        s = [
          { name: "Dispense", bitmask: 1 },
          { name: "Connect", bitmask: 2 },
          { name: "Destroy", bitmask: 4 },
          { name: "Paint", bitmask: 8 },
        ];
      t.RapidPipeDispenser = function (e, t) {
        var n = (0, a.useBackend)(t),
          m = n.act,
          p = n.data,
          C = p.category,
          h = p.categories,
          N = void 0 === h ? [] : h,
          V = p.selected_color,
          b = p.piping_layer,
          f = p.mode,
          g = p.preview_rows.flatMap(function (e) {
            return e.previews;
          }),
          v = (0, a.useLocalState)(t, "categoryName"),
          k = v[0],
          w = v[1],
          B =
            N.find(function (e) {
              return e.cat_name === k;
            }) || N[0];
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 425,
          height: 515,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, c.Section, {
                children: (0, o.createComponentVNode)(2, c.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Category",
                      children: l.map(function (e, t) {
                        return (0, o.createComponentVNode)(
                          2,
                          c.Button,
                          {
                            selected: C === t,
                            icon: d[e],
                            color: "transparent",
                            content: e,
                            onClick: function () {
                              return m("category", { category: t });
                            },
                          },
                          e
                        );
                      }),
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Modes",
                      children: s.map(function (e) {
                        return (0, o.createComponentVNode)(
                          2,
                          c.Button.Checkbox,
                          {
                            checked: f & e.bitmask,
                            content: e.name,
                            onClick: function () {
                              return m("mode", { mode: e.bitmask });
                            },
                          },
                          e.bitmask
                        );
                      }),
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Color",
                      children: [
                        (0, o.createComponentVNode)(2, c.Box, {
                          inline: !0,
                          width: "64px",
                          color: u[V],
                          children: V,
                        }),
                        Object.keys(u).map(function (e) {
                          return (0, o.createComponentVNode)(
                            2,
                            c.ColorBox,
                            {
                              ml: 1,
                              color: u[e],
                              onClick: function () {
                                return m("color", { paint_color: e });
                              },
                            },
                            e
                          );
                        }),
                      ],
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, c.Flex, {
                m: -0.5,
                children: [
                  (0, o.createComponentVNode)(2, c.Flex.Item, {
                    m: 0.5,
                    children: (0, o.createComponentVNode)(2, c.Section, {
                      children: [
                        0 === C &&
                          (0, o.createComponentVNode)(2, c.Box, {
                            mb: 1,
                            children: [1, 2, 3].map(function (e) {
                              return (0, o.createComponentVNode)(
                                2,
                                c.Button.Checkbox,
                                {
                                  fluid: !0,
                                  checked: e === b,
                                  content: "Layer " + e,
                                  onClick: function () {
                                    return m("piping_layer", {
                                      piping_layer: e,
                                    });
                                  },
                                },
                                e
                              );
                            }),
                          }),
                        (0, o.createComponentVNode)(2, c.Box, {
                          width: "108px",
                          children: g.map(function (e) {
                            return (0, o.createComponentVNode)(
                              2,
                              c.Button,
                              {
                                title: e.dir_name,
                                selected: e.selected,
                                style: {
                                  width: "48px",
                                  height: "48px",
                                  padding: 0,
                                },
                                onClick: function () {
                                  return m("setdir", {
                                    dir: e.dir,
                                    flipped: e.flipped,
                                  });
                                },
                                children: (0, o.createComponentVNode)(
                                  2,
                                  c.Box,
                                  {
                                    className: (0, r.classes)([
                                      "pipes32x32",
                                      e.dir + "-" + e.icon_state,
                                    ]),
                                    style: {
                                      transform:
                                        "scale(1.5) translate(17%, 17%)",
                                    },
                                  }
                                ),
                              },
                              e.dir
                            );
                          }),
                        }),
                      ],
                    }),
                  }),
                  (0, o.createComponentVNode)(2, c.Flex.Item, {
                    m: 0.5,
                    grow: 1,
                    children: (0, o.createComponentVNode)(2, c.Section, {
                      children: [
                        (0, o.createComponentVNode)(2, c.Tabs, {
                          children: N.map(function (e, t) {
                            return (0, o.createComponentVNode)(
                              2,
                              c.Tabs.Tab,
                              {
                                fluid: !0,
                                icon: d[e.cat_name],
                                selected: e.cat_name === B.cat_name,
                                onClick: function () {
                                  return w(e.cat_name);
                                },
                                children: e.cat_name,
                              },
                              e.cat_name
                            );
                          }),
                        }),
                        null == B
                          ? void 0
                          : B.recipes.map(function (e) {
                              return (0, o.createComponentVNode)(
                                2,
                                c.Button.Checkbox,
                                {
                                  fluid: !0,
                                  ellipsis: !0,
                                  checked: e.selected,
                                  content: e.pipe_name,
                                  title: e.pipe_name,
                                  onClick: function () {
                                    return m("pipe_type", {
                                      pipe_type: e.pipe_index,
                                      category: B.cat_name,
                                    });
                                  },
                                },
                                e.pipe_index
                              );
                            }),
                      ],
                    }),
                  }),
                ],
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.RoboticsControlConsole = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.RoboticsControlConsole = function (e, t) {
        var n = (0, r.useBackend)(t),
          d = (n.act, n.data),
          u = (0, r.useSharedState)(t, "tab", 1),
          s = u[0],
          m = u[1],
          p = d.can_hack,
          C = d.cyborgs,
          h = void 0 === C ? [] : C,
          N = d.drones,
          V = void 0 === N ? [] : N;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 500,
          height: 460,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Tabs, {
                children: [
                  (0, o.createComponentVNode)(2, a.Tabs.Tab, {
                    icon: "list",
                    lineHeight: "23px",
                    selected: 1 === s,
                    onClick: function () {
                      return m(1);
                    },
                    children: ["Cyborgs (", h.length, ")"],
                  }),
                  (0, o.createComponentVNode)(2, a.Tabs.Tab, {
                    icon: "list",
                    lineHeight: "23px",
                    selected: 2 === s,
                    onClick: function () {
                      return m(2);
                    },
                    children: ["Drones (", V.length, ")"],
                  }),
                ],
              }),
              1 === s &&
                (0, o.createComponentVNode)(2, i, { cyborgs: h, can_hack: p }),
              2 === s && (0, o.createComponentVNode)(2, l, { drones: V }),
            ],
          }),
        });
      };
      var i = function (e, t) {
          var n = e.cyborgs,
            c = e.can_hack,
            i = (0, r.useBackend)(t),
            l = i.act;
          i.data;
          return n.length
            ? n.map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  a.Section,
                  {
                    title: e.name,
                    buttons: (0, o.createFragment)(
                      [
                        !!c &&
                          !e.emagged &&
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "terminal",
                            content: "Hack",
                            color: "bad",
                            onClick: function () {
                              return l("magbot", { ref: e.ref });
                            },
                          }),
                        (0, o.createComponentVNode)(2, a.Button.Confirm, {
                          icon: e.locked_down ? "unlock" : "lock",
                          color: e.locked_down ? "good" : "default",
                          content: e.locked_down ? "Release" : "Lockdown",
                          onClick: function () {
                            return l("stopbot", { ref: e.ref });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button.Confirm, {
                          icon: "bomb",
                          content: "Detonate",
                          color: "bad",
                          onClick: function () {
                            return l("killbot", { ref: e.ref });
                          },
                        }),
                      ],
                      0
                    ),
                    children: (0, o.createComponentVNode)(2, a.LabeledList, {
                      children: [
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Status",
                          children: (0, o.createComponentVNode)(2, a.Box, {
                            color: e.status
                              ? "bad"
                              : e.locked_down
                              ? "average"
                              : "good",
                            children: e.status
                              ? "Not Responding"
                              : e.locked_down
                              ? "Locked Down"
                              : "Nominal",
                          }),
                        }),
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Charge",
                          children: (0, o.createComponentVNode)(2, a.Box, {
                            color:
                              e.charge <= 30
                                ? "bad"
                                : e.charge <= 70
                                ? "average"
                                : "good",
                            children:
                              "number" == typeof e.charge
                                ? e.charge + "%"
                                : "Not Found",
                          }),
                        }),
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Module",
                          children: e.module,
                        }),
                        (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                          label: "Master AI",
                          children: (0, o.createComponentVNode)(2, a.Box, {
                            color: e.synchronization ? "default" : "average",
                            children: e.synchronization || "None",
                          }),
                        }),
                      ],
                    }),
                  },
                  e.ref
                );
              })
            : (0, o.createComponentVNode)(2, a.NoticeBox, {
                children: "No cyborg units detected within access parameters",
              });
        },
        l = function (e, t) {
          var n = e.drones,
            c = (0, r.useBackend)(t).act;
          return n.length
            ? n.map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  a.Section,
                  {
                    title: e.name,
                    buttons: (0, o.createComponentVNode)(2, a.Button.Confirm, {
                      icon: "bomb",
                      content: "Detonate",
                      color: "bad",
                      onClick: function () {
                        return c("killdrone", { ref: e.ref });
                      },
                    }),
                    children: (0, o.createComponentVNode)(2, a.LabeledList, {
                      children: (0, o.createComponentVNode)(
                        2,
                        a.LabeledList.Item,
                        {
                          label: "Status",
                          children: (0, o.createComponentVNode)(2, a.Box, {
                            color: e.status ? "bad" : "good",
                            children: e.status ? "Not Responding" : "Nominal",
                          }),
                        }
                      ),
                    }),
                  },
                  e.ref
                );
              })
            : (0, o.createComponentVNode)(2, a.NoticeBox, {
                children: "No drone units detected within access parameters",
              });
        };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.SatelliteControl = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(200),
        i = n(3);
      t.SatelliteControl = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.satellites || [];
        return (0, o.createComponentVNode)(2, i.Window, {
          width: 400,
          height: 305,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: [
              d.meteor_shield &&
                (0, o.createComponentVNode)(2, a.Section, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList, {
                    children: (0, o.createComponentVNode)(
                      2,
                      c.LabeledListItem,
                      {
                        label: "Coverage",
                        children: (0, o.createComponentVNode)(
                          2,
                          a.ProgressBar,
                          {
                            value:
                              d.meteor_shield_coverage /
                              d.meteor_shield_coverage_max,
                            content:
                              (100 * d.meteor_shield_coverage) /
                                d.meteor_shield_coverage_max +
                              "%",
                            ranges: {
                              good: [1, Infinity],
                              average: [0.3, 1],
                              bad: [-Infinity, 0.3],
                            },
                          }
                        ),
                      }
                    ),
                  }),
                }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Satellite Controls",
                children: (0, o.createComponentVNode)(2, a.Box, {
                  mr: -1,
                  children: u.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      a.Button.Checkbox,
                      {
                        checked: e.active,
                        content: "#" + e.id + " " + e.mode,
                        onClick: function () {
                          return l("toggle", { id: e.id });
                        },
                      },
                      e.id
                    );
                  }),
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ScannerGate = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(59),
        i = n(3),
        l = [
          "Positive",
          "Harmless",
          "Minor",
          "Medium",
          "Harmful",
          "Dangerous",
          "BIOHAZARD",
        ],
        d = [
          { name: "Human", value: "human" },
          { name: "Lizardperson", value: "lizard" },
          { name: "Flyperson", value: "fly" },
          { name: "Felinid", value: "felinid" },
          { name: "Plasmaman", value: "plasma" },
          { name: "Mothperson", value: "moth" },
          { name: "Jellyperson", value: "jelly" },
          { name: "Podperson", value: "pod" },
          { name: "Golem", value: "golem" },
          { name: "Zombie", value: "zombie" },
        ],
        u = [
          { name: "Starving", value: 150 },
          { name: "Obese", value: 600 },
        ];
      t.ScannerGate = function (e, t) {
        var n = (0, r.useBackend)(t),
          a = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 400,
          height: 300,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, c.InterfaceLockNoticeBox, {
                onLockedStatusChange: function () {
                  return a("toggle_lock");
                },
              }),
              !l.locked && (0, o.createComponentVNode)(2, m),
            ],
          }),
        });
      };
      var s = {
          Off: {
            title: "Scanner Mode: Off",
            component: function () {
              return p;
            },
          },
          Wanted: {
            title: "Scanner Mode: Wanted",
            component: function () {
              return C;
            },
          },
          Guns: {
            title: "Scanner Mode: Guns",
            component: function () {
              return h;
            },
          },
          Mindshield: {
            title: "Scanner Mode: Mindshield",
            component: function () {
              return N;
            },
          },
          Disease: {
            title: "Scanner Mode: Disease",
            component: function () {
              return V;
            },
          },
          Species: {
            title: "Scanner Mode: Species",
            component: function () {
              return b;
            },
          },
          Nutrition: {
            title: "Scanner Mode: Nutrition",
            component: function () {
              return f;
            },
          },
          Nanites: {
            title: "Scanner Mode: Nanites",
            component: function () {
              return g;
            },
          },
        },
        m = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data.scan_mode,
            l = s[i] || s.off,
            d = l.component();
          return (0, o.createComponentVNode)(2, a.Section, {
            title: l.title,
            buttons:
              "Off" !== i &&
              (0, o.createComponentVNode)(2, a.Button, {
                icon: "arrow-left",
                content: "back",
                onClick: function () {
                  return c("set_mode", { new_mode: "Off" });
                },
              }),
            children: (0, o.createComponentVNode)(2, d),
          });
        },
        p = function (e, t) {
          var n = (0, r.useBackend)(t).act;
          return (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, a.Box, {
                mb: 2,
                children: "Select a scanning mode below.",
              }),
              (0, o.createComponentVNode)(2, a.Box, {
                children: [
                  (0, o.createComponentVNode)(2, a.Button, {
                    content: "Wanted",
                    onClick: function () {
                      return n("set_mode", { new_mode: "Wanted" });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    content: "Guns",
                    onClick: function () {
                      return n("set_mode", { new_mode: "Guns" });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    content: "Mindshield",
                    onClick: function () {
                      return n("set_mode", { new_mode: "Mindshield" });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    content: "Disease",
                    onClick: function () {
                      return n("set_mode", { new_mode: "Disease" });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    content: "Species",
                    onClick: function () {
                      return n("set_mode", { new_mode: "Species" });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    content: "Nutrition",
                    onClick: function () {
                      return n("set_mode", { new_mode: "Nutrition" });
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    content: "Nanites",
                    onClick: function () {
                      return n("set_mode", { new_mode: "Nanites" });
                    },
                  }),
                ],
              }),
            ],
            4
          );
        },
        C = function (e, t) {
          var n = (0, r.useBackend)(t).data.reverse;
          return (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, a.Box, {
                mb: 2,
                children: [
                  "Trigger if the person scanned ",
                  n ? "does not have" : "has",
                  " ",
                  "any warrants for their arrest.",
                ],
              }),
              (0, o.createComponentVNode)(2, v),
            ],
            4
          );
        },
        h = function (e, t) {
          var n = (0, r.useBackend)(t).data.reverse;
          return (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, a.Box, {
                mb: 2,
                children: [
                  "Trigger if the person scanned ",
                  n ? "does not have" : "has",
                  " ",
                  "any guns.",
                ],
              }),
              (0, o.createComponentVNode)(2, v),
            ],
            4
          );
        },
        N = function (e, t) {
          var n = (0, r.useBackend)(t).data.reverse;
          return (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, a.Box, {
                mb: 2,
                children: [
                  "Trigger if the person scanned ",
                  n ? "does not have" : "has",
                  " ",
                  "a mindshield.",
                ],
              }),
              (0, o.createComponentVNode)(2, v),
            ],
            4
          );
        },
        V = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data,
            d = i.reverse,
            u = i.disease_threshold;
          return (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, a.Box, {
                mb: 2,
                children: [
                  "Trigger if the person scanned ",
                  d ? "does not have" : "has",
                  " ",
                  "a disease equal or worse than ",
                  u,
                  ".",
                ],
              }),
              (0, o.createComponentVNode)(2, a.Box, {
                mb: 2,
                children: l.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    a.Button.Checkbox,
                    {
                      checked: e === u,
                      content: e,
                      onClick: function () {
                        return c("set_disease_threshold", { new_threshold: e });
                      },
                    },
                    e
                  );
                }),
              }),
              (0, o.createComponentVNode)(2, v),
            ],
            4
          );
        },
        b = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data,
            l = i.reverse,
            u = i.target_species,
            s = d.find(function (e) {
              return e.value === u;
            });
          return (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, a.Box, {
                mb: 2,
                children: [
                  "Trigger if the person scanned is ",
                  l ? "not" : "",
                  " ",
                  "of the ",
                  s.name,
                  " species.",
                  "zombie" === u &&
                    " All zombie types will be detected, including dormant zombies.",
                ],
              }),
              (0, o.createComponentVNode)(2, a.Box, {
                mb: 2,
                children: d.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    a.Button.Checkbox,
                    {
                      checked: e.value === u,
                      content: e.name,
                      onClick: function () {
                        return c("set_target_species", {
                          new_species: e.value,
                        });
                      },
                    },
                    e.value
                  );
                }),
              }),
              (0, o.createComponentVNode)(2, v),
            ],
            4
          );
        },
        f = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data,
            l = i.reverse,
            d = i.target_nutrition,
            s = u.find(function (e) {
              return e.value === d;
            });
          return (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, a.Box, {
                mb: 2,
                children: [
                  "Trigger if the person scanned ",
                  l ? "does not have" : "has",
                  " ",
                  "the ",
                  s.name,
                  " nutrition level.",
                ],
              }),
              (0, o.createComponentVNode)(2, a.Box, {
                mb: 2,
                children: u.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    a.Button.Checkbox,
                    {
                      checked: e.value === d,
                      content: e.name,
                      onClick: function () {
                        return c("set_target_nutrition", {
                          new_nutrition: e.name,
                        });
                      },
                    },
                    e.name
                  );
                }),
              }),
              (0, o.createComponentVNode)(2, v),
            ],
            4
          );
        },
        g = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data,
            l = i.reverse,
            d = i.nanite_cloud;
          return (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, a.Box, {
                mb: 2,
                children: [
                  "Trigger if the person scanned ",
                  l ? "does not have" : "has",
                  " ",
                  "nanite cloud ",
                  d,
                  ".",
                ],
              }),
              (0, o.createComponentVNode)(2, a.Box, {
                mb: 2,
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Cloud ID",
                    children: (0, o.createComponentVNode)(2, a.NumberInput, {
                      value: d,
                      width: "65px",
                      minValue: 1,
                      maxValue: 100,
                      stepPixelSize: 2,
                      onChange: function (e, t) {
                        return c("set_nanite_cloud", { new_cloud: t });
                      },
                    }),
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, v),
            ],
            4
          );
        },
        v = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data.reverse;
          return (0, o.createComponentVNode)(2, a.LabeledList, {
            children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
              label: "Scanning Mode",
              children: (0, o.createComponentVNode)(2, a.Button, {
                content: i ? "Inverted" : "Default",
                icon: i ? "random" : "long-arrow-alt-right",
                onClick: function () {
                  return c("toggle_reverse");
                },
                color: i ? "bad" : "good",
              }),
            }),
          });
        };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.ShuttleManipulatorModification = t.ShuttleManipulatorTemplates = t.ShuttleManipulatorStatus = t.ShuttleManipulator = void 0);
      var o = n(0),
        r = n(21),
        a = n(2),
        c = n(1),
        i = n(3);
      t.ShuttleManipulator = function (e, t) {
        var n = (0, a.useLocalState)(t, "tab", 1),
          r = n[0],
          s = n[1];
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 800,
          height: 600,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, c.Tabs, {
                children: [
                  (0, o.createComponentVNode)(2, c.Tabs.Tab, {
                    selected: 1 === r,
                    onClick: function () {
                      return s(1);
                    },
                    children: "Status",
                  }),
                  (0, o.createComponentVNode)(2, c.Tabs.Tab, {
                    selected: 2 === r,
                    onClick: function () {
                      return s(2);
                    },
                    children: "Templates",
                  }),
                  (0, o.createComponentVNode)(2, c.Tabs.Tab, {
                    selected: 3 === r,
                    onClick: function () {
                      return s(3);
                    },
                    children: "Modification",
                  }),
                ],
              }),
              1 === r && (0, o.createComponentVNode)(2, l),
              2 === r && (0, o.createComponentVNode)(2, d),
              3 === r && (0, o.createComponentVNode)(2, u),
            ],
          }),
        });
      };
      var l = function (e, t) {
        var n = (0, a.useBackend)(t),
          r = n.act,
          i = n.data.shuttles || [];
        return (0, o.createComponentVNode)(2, c.Section, {
          children: (0, o.createComponentVNode)(2, c.Table, {
            children: i.map(function (e) {
              return (0, o.createComponentVNode)(
                2,
                c.Table.Row,
                {
                  children: [
                    (0, o.createComponentVNode)(2, c.Table.Cell, {
                      children: (0, o.createComponentVNode)(
                        2,
                        c.Button,
                        {
                          content: "JMP",
                          onClick: function () {
                            return r("jump_to", { type: "mobile", id: e.id });
                          },
                        },
                        e.id
                      ),
                    }),
                    (0, o.createComponentVNode)(2, c.Table.Cell, {
                      children: (0, o.createComponentVNode)(
                        2,
                        c.Button,
                        {
                          content: "Fly",
                          disabled: !e.can_fly,
                          onClick: function () {
                            return r("fly", { id: e.id });
                          },
                        },
                        e.id
                      ),
                    }),
                    (0, o.createComponentVNode)(2, c.Table.Cell, {
                      children: e.name,
                    }),
                    (0, o.createComponentVNode)(2, c.Table.Cell, {
                      children: e.id,
                    }),
                    (0, o.createComponentVNode)(2, c.Table.Cell, {
                      children: e.status,
                    }),
                    (0, o.createComponentVNode)(2, c.Table.Cell, {
                      children: [
                        e.mode,
                        !!e.timer &&
                          (0, o.createFragment)(
                            [
                              (0, o.createTextVNode)("("),
                              e.timeleft,
                              (0, o.createTextVNode)(")"),
                              (0, o.createComponentVNode)(
                                2,
                                c.Button,
                                {
                                  content: "Fast Travel",
                                  disabled: !e.can_fast_travel,
                                  onClick: function () {
                                    return r("fast_travel", { id: e.id });
                                  },
                                },
                                e.id
                              ),
                            ],
                            0
                          ),
                      ],
                    }),
                  ],
                },
                e.id
              );
            }),
          }),
        });
      };
      t.ShuttleManipulatorStatus = l;
      var d = function (e, t) {
        var n,
          i = (0, a.useBackend)(t),
          l = i.act,
          d = i.data,
          u = d.templates || {},
          s = d.selected || {},
          m = (0, a.useLocalState)(t, "templateId", Object.keys(u)[0]),
          p = m[0],
          C = m[1],
          h = null == (n = u[p]) ? void 0 : n.templates;
        return (0, o.createComponentVNode)(2, c.Section, {
          children: (0, o.createComponentVNode)(2, c.Flex, {
            children: [
              (0, o.createComponentVNode)(2, c.Flex.Item, {
                children: (0, o.createComponentVNode)(2, c.Tabs, {
                  vertical: !0,
                  children: (0, r.map)(function (e, t) {
                    return (0, o.createComponentVNode)(
                      2,
                      c.Tabs.Tab,
                      {
                        selected: p === t,
                        onClick: function () {
                          return C(t);
                        },
                        children: e.port_id,
                      },
                      t
                    );
                  })(u),
                }),
              }),
              (0, o.createComponentVNode)(2, c.Flex.Item, {
                grow: 1,
                basis: 0,
                children: h.map(function (e) {
                  var t = e.shuttle_id === s.shuttle_id;
                  return (0, o.createComponentVNode)(
                    2,
                    c.Section,
                    {
                      title: e.name,
                      level: 2,
                      buttons: (0, o.createComponentVNode)(2, c.Button, {
                        content: t ? "Selected" : "Select",
                        selected: t,
                        onClick: function () {
                          return l("select_template", {
                            shuttle_id: e.shuttle_id,
                          });
                        },
                      }),
                      children:
                        (!!e.description || !!e.admin_notes) &&
                        (0, o.createComponentVNode)(2, c.LabeledList, {
                          children: [
                            !!e.description &&
                              (0, o.createComponentVNode)(
                                2,
                                c.LabeledList.Item,
                                {
                                  label: "Description",
                                  children: e.description,
                                }
                              ),
                            !!e.admin_notes &&
                              (0, o.createComponentVNode)(
                                2,
                                c.LabeledList.Item,
                                {
                                  label: "Admin Notes",
                                  children: e.admin_notes,
                                }
                              ),
                          ],
                        }),
                    },
                    e.shuttle_id
                  );
                }),
              }),
            ],
          }),
        });
      };
      t.ShuttleManipulatorTemplates = d;
      var u = function (e, t) {
        var n = (0, a.useBackend)(t),
          r = n.act,
          i = n.data,
          l = i.selected || {},
          d = i.existing_shuttle || {};
        return (0, o.createComponentVNode)(2, c.Section, {
          children: l
            ? (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, c.Section, {
                    level: 2,
                    title: l.name,
                    children:
                      (!!l.description || !!l.admin_notes) &&
                      (0, o.createComponentVNode)(2, c.LabeledList, {
                        children: [
                          !!l.description &&
                            (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                              label: "Description",
                              children: l.description,
                            }),
                          !!l.admin_notes &&
                            (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                              label: "Admin Notes",
                              children: l.admin_notes,
                            }),
                        ],
                      }),
                  }),
                  d
                    ? (0, o.createComponentVNode)(2, c.Section, {
                        level: 2,
                        title: "Existing Shuttle: " + d.name,
                        children: (0, o.createComponentVNode)(
                          2,
                          c.LabeledList,
                          {
                            children: (0, o.createComponentVNode)(
                              2,
                              c.LabeledList.Item,
                              {
                                label: "Status",
                                buttons: (0, o.createComponentVNode)(
                                  2,
                                  c.Button,
                                  {
                                    content: "Jump To",
                                    onClick: function () {
                                      return r("jump_to", {
                                        type: "mobile",
                                        id: d.id,
                                      });
                                    },
                                  }
                                ),
                                children: [
                                  d.status,
                                  !!d.timer &&
                                    (0, o.createFragment)(
                                      [
                                        (0, o.createTextVNode)("("),
                                        d.timeleft,
                                        (0, o.createTextVNode)(")"),
                                      ],
                                      0
                                    ),
                                ],
                              }
                            ),
                          }
                        ),
                      })
                    : (0, o.createComponentVNode)(2, c.Section, {
                        level: 2,
                        title: "Existing Shuttle: None",
                      }),
                  (0, o.createComponentVNode)(2, c.Section, {
                    level: 2,
                    title: "Status",
                    children: [
                      (0, o.createComponentVNode)(2, c.Button, {
                        content: "Preview",
                        onClick: function () {
                          return r("preview", { shuttle_id: l.shuttle_id });
                        },
                      }),
                      (0, o.createComponentVNode)(2, c.Button, {
                        content: "Load",
                        color: "bad",
                        onClick: function () {
                          return r("load", { shuttle_id: l.shuttle_id });
                        },
                      }),
                    ],
                  }),
                ],
                0
              )
            : "No shuttle selected",
        });
      };
      t.ShuttleManipulatorModification = u;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Signaler = void 0);
      var o = n(0),
        r = n(1),
        a = n(2),
        c = n(8),
        i = n(3);
      t.Signaler = function (e, t) {
        var n = (0, a.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.code,
          s = d.frequency,
          m = d.minFrequency,
          p = d.maxFrequency;
        return (0, o.createComponentVNode)(2, i.Window, {
          width: 280,
          height: 132,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: (0, o.createComponentVNode)(2, r.Section, {
              children: [
                (0, o.createComponentVNode)(2, r.Grid, {
                  children: [
                    (0, o.createComponentVNode)(2, r.Grid.Column, {
                      size: 1.4,
                      color: "label",
                      children: "Frequency:",
                    }),
                    (0, o.createComponentVNode)(2, r.Grid.Column, {
                      children: (0, o.createComponentVNode)(2, r.NumberInput, {
                        animate: !0,
                        unit: "kHz",
                        step: 0.2,
                        stepPixelSize: 6,
                        minValue: m / 10,
                        maxValue: p / 10,
                        value: s / 10,
                        format: function (e) {
                          return (0, c.toFixed)(e, 1);
                        },
                        width: "80px",
                        onDrag: function (e, t) {
                          return l("freq", { freq: t });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, r.Grid.Column, {
                      children: (0, o.createComponentVNode)(2, r.Button, {
                        ml: 1.3,
                        icon: "sync",
                        content: "Reset",
                        onClick: function () {
                          return l("reset", { reset: "freq" });
                        },
                      }),
                    }),
                  ],
                }),
                (0, o.createComponentVNode)(2, r.Grid, {
                  mt: 0.6,
                  children: [
                    (0, o.createComponentVNode)(2, r.Grid.Column, {
                      size: 1.4,
                      color: "label",
                      children: "Code:",
                    }),
                    (0, o.createComponentVNode)(2, r.Grid.Column, {
                      children: (0, o.createComponentVNode)(2, r.NumberInput, {
                        animate: !0,
                        step: 1,
                        stepPixelSize: 6,
                        minValue: 1,
                        maxValue: 100,
                        value: u,
                        width: "80px",
                        onDrag: function (e, t) {
                          return l("code", { code: t });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, r.Grid.Column, {
                      children: (0, o.createComponentVNode)(2, r.Button, {
                        ml: 1.3,
                        icon: "sync",
                        content: "Reset",
                        onClick: function () {
                          return l("reset", { reset: "code" });
                        },
                      }),
                    }),
                  ],
                }),
                (0, o.createComponentVNode)(2, r.Grid, {
                  mt: 0.8,
                  children: (0, o.createComponentVNode)(2, r.Grid.Column, {
                    children: (0, o.createComponentVNode)(2, r.Button, {
                      mb: -0.1,
                      fluid: !0,
                      icon: "arrow-up",
                      content: "Send Signal",
                      textAlign: "center",
                      onClick: function () {
                        return l("signal");
                      },
                    }),
                  }),
                }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Sleeper = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = (n(144), n(8));
      t.Sleeper = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.open,
          s = d.occupant,
          m = void 0 === s ? {} : s,
          p = d.occupied,
          C = (d.chems || []).sort(function (e, t) {
            var n = e.name.toLowerCase(),
              o = t.name.toLowerCase();
            return n < o ? -1 : n > o ? 1 : 0;
          });
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 310,
          height: 520,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: m.name ? m.name : "No Occupant",
                minHeight: "250px",
                buttons:
                  !!m.stat &&
                  (0, o.createComponentVNode)(2, a.Box, {
                    inline: !0,
                    bold: !0,
                    color: m.statstate,
                    children: m.stat,
                  }),
                children:
                  !!p &&
                  (0, o.createFragment)(
                    [
                      (0, o.createComponentVNode)(2, a.ProgressBar, {
                        value: m.health,
                        minValue: m.minHealth,
                        maxValue: m.maxHealth,
                        ranges: {
                          good: [50, Infinity],
                          average: [0, 50],
                          bad: [-Infinity, 0],
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Box, { mt: 1 }),
                      (0, o.createComponentVNode)(2, a.LabeledList, {
                        children: [
                          [
                            { label: "Brute", type: "bruteLoss" },
                            { label: "Burn", type: "fireLoss" },
                            { label: "Toxin", type: "toxLoss" },
                            { label: "Oxygen", type: "oxyLoss" },
                          ].map(function (e) {
                            return (0,
                            o.createComponentVNode)(2, a.LabeledList.Item, { label: e.label, children: (0, o.createComponentVNode)(2, a.ProgressBar, { value: m[e.type], minValue: 0, maxValue: m.maxHealth, color: "bad" }) }, e.type);
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Cells",
                            color: m.cloneLoss ? "bad" : "good",
                            children: m.cloneLoss ? "Damaged" : "Healthy",
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Brain",
                            color: m.brainLoss ? "bad" : "good",
                            children: m.brainLoss ? "Abnormal" : "Healthy",
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Reagents",
                            children: (0, o.createComponentVNode)(2, a.Box, {
                              color: "label",
                              children: [
                                0 === m.reagents.length && "\u2014",
                                m.reagents.map(function (e) {
                                  return (0, o.createComponentVNode)(
                                    2,
                                    a.Box,
                                    {
                                      children: [
                                        (0, o.createComponentVNode)(
                                          2,
                                          a.AnimatedNumber,
                                          {
                                            value: e.volume,
                                            format: function (e) {
                                              return (0, i.toFixed)(e, 1);
                                            },
                                          }
                                        ),
                                        " units of " + e.name,
                                      ],
                                    },
                                    e.name
                                  );
                                }),
                              ],
                            }),
                          }),
                        ],
                      }),
                    ],
                    4
                  ),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Medicines",
                minHeight: "205px",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: u ? "door-open" : "door-closed",
                  content: u ? "Open" : "Closed",
                  onClick: function () {
                    return l("door");
                  },
                }),
                children: C.map(function (e) {
                  return (0, o.createComponentVNode)(
                    2,
                    a.Button,
                    {
                      icon: "flask",
                      content: e.name,
                      disabled: !(p && e.allowed),
                      width: "140px",
                      onClick: function () {
                        return l("inject", { chem: e.id });
                      },
                    },
                    e.name
                  );
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.SlimeBodySwapper = t.BodyEntry = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = function (e, t) {
          var n = e.body,
            r = e.swapFunc;
          return (0, o.createComponentVNode)(2, a.Section, {
            title: (0, o.createComponentVNode)(2, a.Box, {
              inline: !0,
              color: n.htmlcolor,
              children: n.name,
            }),
            level: 2,
            buttons: (0, o.createComponentVNode)(2, a.Button, {
              content: {
                owner: "You Are Here",
                stranger: "Occupied",
                available: "Swap",
              }[n.occupied],
              selected: "owner" === n.occupied,
              color: "stranger" === n.occupied && "bad",
              onClick: function () {
                return r();
              },
            }),
            children: (0, o.createComponentVNode)(2, a.LabeledList, {
              children: [
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Status",
                  bold: !0,
                  color: {
                    Dead: "bad",
                    Unconscious: "average",
                    Conscious: "good",
                  }[n.status],
                  children: n.status,
                }),
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Jelly",
                  children: n.exoticblood,
                }),
                (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                  label: "Location",
                  children: n.area,
                }),
              ],
            }),
          });
        };
      t.BodyEntry = i;
      t.SlimeBodySwapper = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data.bodies,
          u = void 0 === d ? [] : d;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 400,
          height: 400,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: u.map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  i,
                  {
                    body: e,
                    swapFunc: function () {
                      return l("swap", { ref: e.ref });
                    },
                  },
                  e.name
                );
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.SmartVend = void 0);
      var o = n(0),
        r = n(21),
        a = n(2),
        c = n(1),
        i = n(3);
      t.SmartVend = function (e, t) {
        var n = (0, a.useBackend)(t),
          l = n.act,
          d = n.data;
        return (0, o.createComponentVNode)(2, i.Window, {
          resizable: !0,
          width: 440,
          height: 550,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, c.Section, {
              title: "Storage",
              buttons:
                !!d.isdryer &&
                (0, o.createComponentVNode)(2, c.Button, {
                  icon: d.drying ? "stop" : "tint",
                  onClick: function () {
                    return l("Dry");
                  },
                  children: d.drying ? "Stop drying" : "Dry",
                }),
              children:
                (0 === d.contents.length &&
                  (0, o.createComponentVNode)(2, c.NoticeBox, {
                    children: ["Unfortunately, this ", d.name, " is empty."],
                  })) ||
                (0, o.createComponentVNode)(2, c.Table, {
                  children: [
                    (0, o.createComponentVNode)(2, c.Table.Row, {
                      header: !0,
                      children: [
                        (0, o.createComponentVNode)(2, c.Table.Cell, {
                          children: "Item",
                        }),
                        (0, o.createComponentVNode)(2, c.Table.Cell, {
                          collapsing: !0,
                        }),
                        (0, o.createComponentVNode)(2, c.Table.Cell, {
                          collapsing: !0,
                          textAlign: "center",
                          children: d.verb ? d.verb : "Dispense",
                        }),
                      ],
                    }),
                    (0, r.map)(function (e, t) {
                      return (0, o.createComponentVNode)(
                        2,
                        c.Table.Row,
                        {
                          children: [
                            (0, o.createComponentVNode)(2, c.Table.Cell, {
                              children: e.name,
                            }),
                            (0, o.createComponentVNode)(2, c.Table.Cell, {
                              collapsing: !0,
                              textAlign: "right",
                              children: e.amount,
                            }),
                            (0, o.createComponentVNode)(2, c.Table.Cell, {
                              collapsing: !0,
                              children: [
                                (0, o.createComponentVNode)(2, c.Button, {
                                  content: "One",
                                  disabled: e.amount < 1,
                                  onClick: function () {
                                    return l("Release", {
                                      name: e.name,
                                      amount: 1,
                                    });
                                  },
                                }),
                                (0, o.createComponentVNode)(2, c.Button, {
                                  content: "Many",
                                  disabled: e.amount <= 1,
                                  onClick: function () {
                                    return l("Release", { name: e.name });
                                  },
                                }),
                              ],
                            }),
                          ],
                        },
                        t
                      );
                    })(d.contents),
                  ],
                }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Smes = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(52),
        i = n(3);
      t.Smes = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.capacityPercent,
          s = (d.capacity, d.charge),
          m = d.inputAttempt,
          p = d.inputting,
          C = d.inputLevel,
          h = d.inputLevelMax,
          N = d.inputAvailable,
          V = d.outputAttempt,
          b = d.outputting,
          f = d.outputLevel,
          g = d.outputLevelMax,
          v = d.outputUsed,
          k = (u >= 100 ? "good" : p && "average") || "bad",
          w = (b ? "good" : s > 0 && "average") || "bad";
        return (0, o.createComponentVNode)(2, i.Window, {
          width: 340,
          height: 350,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Stored Energy",
                children: (0, o.createComponentVNode)(2, a.ProgressBar, {
                  value: 0.01 * u,
                  ranges: {
                    good: [0.5, Infinity],
                    average: [0.15, 0.5],
                    bad: [-Infinity, 0.15],
                  },
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Input",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Charge Mode",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: m ? "sync-alt" : "times",
                        selected: m,
                        onClick: function () {
                          return l("tryinput");
                        },
                        children: m ? "Auto" : "Off",
                      }),
                      children: (0, o.createComponentVNode)(2, a.Box, {
                        color: k,
                        children:
                          (u >= 100 ? "Fully Charged" : p && "Charging") ||
                          "Not Charging",
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Target Input",
                      children: (0, o.createComponentVNode)(2, a.Flex, {
                        inline: !0,
                        width: "100%",
                        children: [
                          (0, o.createComponentVNode)(2, a.Flex.Item, {
                            children: [
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "fast-backward",
                                disabled: 0 === C,
                                onClick: function () {
                                  return l("input", { target: "min" });
                                },
                              }),
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "backward",
                                disabled: 0 === C,
                                onClick: function () {
                                  return l("input", { adjust: -1e4 });
                                },
                              }),
                            ],
                          }),
                          (0, o.createComponentVNode)(2, a.Flex.Item, {
                            grow: 1,
                            mx: 1,
                            children: (0, o.createComponentVNode)(2, a.Slider, {
                              value: C / 1e3,
                              fillValue: N / 1e3,
                              minValue: 0,
                              maxValue: h / 1e3,
                              step: 5,
                              stepPixelSize: 4,
                              format: function (e) {
                                return (0, c.formatPower)(1e3 * e, 1);
                              },
                              onDrag: function (e, t) {
                                return l("input", { target: 1e3 * t });
                              },
                            }),
                          }),
                          (0, o.createComponentVNode)(2, a.Flex.Item, {
                            children: [
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "forward",
                                disabled: C === h,
                                onClick: function () {
                                  return l("input", { adjust: 1e4 });
                                },
                              }),
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "fast-forward",
                                disabled: C === h,
                                onClick: function () {
                                  return l("input", { target: "max" });
                                },
                              }),
                            ],
                          }),
                        ],
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Available",
                      children: (0, c.formatPower)(N),
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Output",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Output Mode",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: V ? "power-off" : "times",
                        selected: V,
                        onClick: function () {
                          return l("tryoutput");
                        },
                        children: V ? "On" : "Off",
                      }),
                      children: (0, o.createComponentVNode)(2, a.Box, {
                        color: w,
                        children: b
                          ? "Sending"
                          : s > 0
                          ? "Not Sending"
                          : "No Charge",
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Target Output",
                      children: (0, o.createComponentVNode)(2, a.Flex, {
                        inline: !0,
                        width: "100%",
                        children: [
                          (0, o.createComponentVNode)(2, a.Flex.Item, {
                            children: [
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "fast-backward",
                                disabled: 0 === f,
                                onClick: function () {
                                  return l("output", { target: "min" });
                                },
                              }),
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "backward",
                                disabled: 0 === f,
                                onClick: function () {
                                  return l("output", { adjust: -1e4 });
                                },
                              }),
                            ],
                          }),
                          (0, o.createComponentVNode)(2, a.Flex.Item, {
                            grow: 1,
                            mx: 1,
                            children: (0, o.createComponentVNode)(2, a.Slider, {
                              value: f / 1e3,
                              minValue: 0,
                              maxValue: g / 1e3,
                              step: 5,
                              stepPixelSize: 4,
                              format: function (e) {
                                return (0, c.formatPower)(1e3 * e, 1);
                              },
                              onDrag: function (e, t) {
                                return l("output", { target: 1e3 * t });
                              },
                            }),
                          }),
                          (0, o.createComponentVNode)(2, a.Flex.Item, {
                            children: [
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "forward",
                                disabled: f === g,
                                onClick: function () {
                                  return l("output", { adjust: 1e4 });
                                },
                              }),
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "fast-forward",
                                disabled: f === g,
                                onClick: function () {
                                  return l("output", { target: "max" });
                                },
                              }),
                            ],
                          }),
                        ],
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Outputting",
                      children: (0, c.formatPower)(v),
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.SmokeMachine = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.SmokeMachine = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.TankContents,
          u = (l.isTankLoaded, l.TankCurrentVolume),
          s = l.TankMaxVolume,
          m = l.active,
          p = l.setting,
          C = (l.screen, l.maxSetting),
          h = void 0 === C ? [] : C;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 350,
          height: 350,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Dispersal Tank",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: m ? "power-off" : "times",
                  selected: m,
                  content: m ? "On" : "Off",
                  onClick: function () {
                    return i("power");
                  },
                }),
                children: [
                  (0, o.createComponentVNode)(2, a.ProgressBar, {
                    value: u / s,
                    ranges: { bad: [-Infinity, 0.3] },
                    children: [
                      (0, o.createComponentVNode)(2, a.AnimatedNumber, {
                        initial: 0,
                        value: u || 0,
                      }),
                      " / " + s,
                    ],
                  }),
                  (0, o.createComponentVNode)(2, a.Box, {
                    mt: 1,
                    children: (0, o.createComponentVNode)(2, a.LabeledList, {
                      children: (0, o.createComponentVNode)(
                        2,
                        a.LabeledList.Item,
                        {
                          label: "Range",
                          children: [1, 2, 3, 4, 5].map(function (e) {
                            return (0, o.createComponentVNode)(
                              2,
                              a.Button,
                              {
                                selected: p === e,
                                icon: "plus",
                                content: 3 * e,
                                disabled: h < e,
                                onClick: function () {
                                  return i("setting", { amount: e });
                                },
                              },
                              e
                            );
                          }),
                        }
                      ),
                    }),
                  }),
                ],
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Contents",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  icon: "trash",
                  content: "Purge",
                  onClick: function () {
                    return i("purge");
                  },
                }),
                children: d.map(function (e) {
                  return (0,
                  o.createComponentVNode)(2, a.Box, { color: "label", children: [(0, o.createComponentVNode)(2, a.AnimatedNumber, { initial: 0, value: e.volume }), " ", "units of ", e.name] }, e.name);
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.SolarControl = void 0);
      var o = n(0),
        r = n(8),
        a = n(2),
        c = n(1),
        i = n(3);
      t.SolarControl = function (e, t) {
        var n = (0, a.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.generated,
          s = d.angle,
          m = d.tracking_state,
          p = d.tracking_rate,
          C = d.connected_panels,
          h = d.connected_tracker;
        return (0, o.createComponentVNode)(2, i.Window, {
          width: 380,
          height: 230,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Status",
                buttons: (0, o.createComponentVNode)(2, c.Button, {
                  icon: "sync",
                  content: "Scan for new hardware",
                  onClick: function () {
                    return l("refresh");
                  },
                }),
                children: (0, o.createComponentVNode)(2, c.Grid, {
                  children: [
                    (0, o.createComponentVNode)(2, c.Grid.Column, {
                      children: (0, o.createComponentVNode)(2, c.LabeledList, {
                        children: [
                          (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                            label: "Solar tracker",
                            color: h ? "good" : "bad",
                            children: h ? "OK" : "N/A",
                          }),
                          (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                            label: "Solar panels",
                            color: C > 0 ? "good" : "bad",
                            children: C,
                          }),
                        ],
                      }),
                    }),
                    (0, o.createComponentVNode)(2, c.Grid.Column, {
                      size: 1.5,
                      children: (0, o.createComponentVNode)(2, c.LabeledList, {
                        children: (0, o.createComponentVNode)(
                          2,
                          c.LabeledList.Item,
                          {
                            label: "Power output",
                            children: (0, o.createComponentVNode)(
                              2,
                              c.ProgressBar,
                              {
                                ranges: {
                                  good: [6e4, Infinity],
                                  average: [3e4, 6e4],
                                  bad: [-Infinity, 3e4],
                                },
                                minValue: 0,
                                maxValue: 9e4,
                                value: u,
                                content: u + " W",
                              }
                            ),
                          }
                        ),
                      }),
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Controls",
                children: (0, o.createComponentVNode)(2, c.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Tracking",
                      children: [
                        (0, o.createComponentVNode)(2, c.Button, {
                          icon: "times",
                          content: "Off",
                          selected: 0 === m,
                          onClick: function () {
                            return l("tracking", { mode: 0 });
                          },
                        }),
                        (0, o.createComponentVNode)(2, c.Button, {
                          icon: "clock-o",
                          content: "Timed",
                          selected: 1 === m,
                          onClick: function () {
                            return l("tracking", { mode: 1 });
                          },
                        }),
                        (0, o.createComponentVNode)(2, c.Button, {
                          icon: "sync",
                          content: "Auto",
                          selected: 2 === m,
                          disabled: !h,
                          onClick: function () {
                            return l("tracking", { mode: 2 });
                          },
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Angle",
                      children: [
                        (0 === m || 1 === m) &&
                          (0, o.createComponentVNode)(2, c.NumberInput, {
                            width: "52px",
                            unit: "\xb0",
                            step: 1,
                            stepPixelSize: 2,
                            minValue: -360,
                            maxValue: 720,
                            value: s,
                            format: function (e) {
                              return Math.round(360 + e) % 360;
                            },
                            onDrag: function (e, t) {
                              return l("angle", { value: t });
                            },
                          }),
                        1 === m &&
                          (0, o.createComponentVNode)(2, c.NumberInput, {
                            width: "80px",
                            unit: "\xb0/h",
                            step: 5,
                            stepPixelSize: 2,
                            minValue: -7200,
                            maxValue: 7200,
                            value: p,
                            format: function (e) {
                              return (
                                (Math.sign(e) > 0 ? "+" : "-") +
                                (0, r.toFixed)(Math.abs(e))
                              );
                            },
                            onDrag: function (e, t) {
                              return l("rate", { value: t });
                            },
                          }),
                        2 === m &&
                          (0, o.createComponentVNode)(2, c.Box, {
                            inline: !0,
                            color: "label",
                            mt: "3px",
                            children: [s + " \xb0", " (auto)"],
                          }),
                      ],
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.SpaceHeater = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.SpaceHeater = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 400,
          height: 305,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Power",
                buttons: (0, o.createFragment)(
                  [
                    (0, o.createComponentVNode)(2, a.Button, {
                      icon: "eject",
                      content: "Eject Cell",
                      disabled: !l.hasPowercell || !l.open,
                      onClick: function () {
                        return i("eject");
                      },
                    }),
                    (0, o.createComponentVNode)(2, a.Button, {
                      icon: l.on ? "power-off" : "times",
                      content: l.on ? "On" : "Off",
                      selected: l.on,
                      disabled: !l.hasPowercell,
                      onClick: function () {
                        return i("power");
                      },
                    }),
                  ],
                  4
                ),
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Cell",
                    color: !l.hasPowercell && "bad",
                    children:
                      (l.hasPowercell &&
                        (0, o.createComponentVNode)(2, a.ProgressBar, {
                          value: l.powerLevel / 100,
                          ranges: {
                            good: [0.6, Infinity],
                            average: [0.3, 0.6],
                            bad: [-Infinity, 0.3],
                          },
                          children: l.powerLevel + "%",
                        })) ||
                      "None",
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Thermostat",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Current Temperature",
                      children: (0, o.createComponentVNode)(2, a.Box, {
                        fontSize: "18px",
                        color:
                          Math.abs(l.targetTemp - l.currentTemp) > 50
                            ? "bad"
                            : Math.abs(l.targetTemp - l.currentTemp) > 20
                            ? "average"
                            : "good",
                        children: [l.currentTemp, "\xb0C"],
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Target Temperature",
                      children:
                        (l.open &&
                          (0, o.createComponentVNode)(2, a.NumberInput, {
                            animated: !0,
                            value: parseFloat(l.targetTemp),
                            width: "65px",
                            unit: "\xb0C",
                            minValue: l.minTemp,
                            maxValue: l.maxTemp,
                            onChange: function (e, t) {
                              return i("target", { target: t });
                            },
                          })) ||
                        l.targetTemp + "\xb0C",
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Mode",
                      children: l.open
                        ? (0, o.createFragment)(
                            [
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "thermometer-half",
                                content: "Auto",
                                selected: "auto" === l.mode,
                                onClick: function () {
                                  return i("mode", { mode: "auto" });
                                },
                              }),
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "fire-alt",
                                content: "Heat",
                                selected: "heat" === l.mode,
                                onClick: function () {
                                  return i("mode", { mode: "heat" });
                                },
                              }),
                              (0, o.createComponentVNode)(2, a.Button, {
                                icon: "fan",
                                content: "Cool",
                                selected: "cool" === l.mode,
                                onClick: function () {
                                  return i("mode", { mode: "cool" });
                                },
                              }),
                            ],
                            4
                          )
                        : "Auto",
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Divider),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.SpawnersMenu = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.SpawnersMenu = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data.spawners || [];
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 700,
          height: 600,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: l.map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  a.Section,
                  {
                    title: e.name + " (" + e.amount_left + " left)",
                    level: 2,
                    buttons: (0, o.createFragment)(
                      [
                        (0, o.createComponentVNode)(2, a.Button, {
                          content: "Jump",
                          onClick: function () {
                            return i("jump", { name: e.name });
                          },
                        }),
                        (0, o.createComponentVNode)(2, a.Button, {
                          content: "Spawn",
                          onClick: function () {
                            return i("spawn", { name: e.name });
                          },
                        }),
                      ],
                      4
                    ),
                    children: [
                      (0, o.createComponentVNode)(2, a.Box, {
                        bold: !0,
                        mb: 1,
                        fontSize: "20px",
                        children: e.short_desc,
                      }),
                      (0, o.createComponentVNode)(2, a.Box, {
                        children: e.flavor_text,
                      }),
                      !!e.important_info &&
                        (0, o.createComponentVNode)(2, a.Box, {
                          mt: 1,
                          bold: !0,
                          color: "bad",
                          fontSize: "26px",
                          children: e.important_info,
                        }),
                    ],
                  },
                  e.name
                );
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.SuitStorageUnit = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.SuitStorageUnit = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.locked,
          u = l.open,
          s = l.safeties,
          m = l.uv_active,
          p = l.occupied,
          C = l.suit,
          h = l.helmet,
          N = l.mask,
          V = l.storage;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 400,
          height: 305,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              !(!p || !s) &&
                (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children:
                    "Biological entity detected in suit chamber. Please remove before continuing with operation.",
                }),
              (m &&
                (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children:
                    "Contents are currently being decontaminated. Please wait.",
                })) ||
                (0, o.createComponentVNode)(2, a.Section, {
                  title: "Storage",
                  minHeight: "260px",
                  buttons: (0, o.createFragment)(
                    [
                      !u &&
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: d ? "unlock" : "lock",
                          content: d ? "Unlock" : "Lock",
                          onClick: function () {
                            return i("lock");
                          },
                        }),
                      !d &&
                        (0, o.createComponentVNode)(2, a.Button, {
                          icon: u ? "sign-out-alt" : "sign-in-alt",
                          content: u ? "Close" : "Open",
                          onClick: function () {
                            return i("door");
                          },
                        }),
                    ],
                    0
                  ),
                  children:
                    (d &&
                      (0, o.createComponentVNode)(2, a.Box, {
                        mt: 6,
                        bold: !0,
                        textAlign: "center",
                        fontSize: "40px",
                        children: [
                          (0, o.createComponentVNode)(2, a.Box, {
                            children: "Unit Locked",
                          }),
                          (0, o.createComponentVNode)(2, a.Icon, {
                            name: "lock",
                          }),
                        ],
                      })) ||
                    (u &&
                      (0, o.createComponentVNode)(2, a.LabeledList, {
                        children: [
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Helmet",
                            children: (0, o.createComponentVNode)(2, a.Button, {
                              icon: h ? "square" : "square-o",
                              content: h || "Empty",
                              disabled: !h,
                              onClick: function () {
                                return i("dispense", { item: "helmet" });
                              },
                            }),
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Suit",
                            children: (0, o.createComponentVNode)(2, a.Button, {
                              icon: C ? "square" : "square-o",
                              content: C || "Empty",
                              disabled: !C,
                              onClick: function () {
                                return i("dispense", { item: "suit" });
                              },
                            }),
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Mask",
                            children: (0, o.createComponentVNode)(2, a.Button, {
                              icon: N ? "square" : "square-o",
                              content: N || "Empty",
                              disabled: !N,
                              onClick: function () {
                                return i("dispense", { item: "mask" });
                              },
                            }),
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Storage",
                            children: (0, o.createComponentVNode)(2, a.Button, {
                              icon: V ? "square" : "square-o",
                              content: V || "Empty",
                              disabled: !V,
                              onClick: function () {
                                return i("dispense", { item: "storage" });
                              },
                            }),
                          }),
                        ],
                      })) ||
                    (0, o.createComponentVNode)(2, a.Button, {
                      fluid: !0,
                      icon: "recycle",
                      content: "Decontaminate",
                      disabled: p && s,
                      textAlign: "center",
                      onClick: function () {
                        return i("uv");
                      },
                    }),
                }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.SyndPane = t.StatusPane = t.SyndContractorContent = t.SyndContractor = t.FakeTerminal = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      var i = (function (e) {
        var t, n;
        function r(t) {
          var n;
          return (
            ((n = e.call(this, t) || this).timer = null),
            (n.state = { currentIndex: 0, currentDisplay: [] }),
            n
          );
        }
        (n = e),
          ((t = r).prototype = Object.create(n.prototype)),
          (t.prototype.constructor = t),
          (t.__proto__ = n);
        var c = r.prototype;
        return (
          (c.tick = function () {
            var e = this.props,
              t = this.state;
            t.currentIndex <= e.allMessages.length
              ? (this.setState(function (e) {
                  return { currentIndex: e.currentIndex + 1 };
                }),
                t.currentDisplay.push(e.allMessages[t.currentIndex]))
              : (clearTimeout(this.timer),
                setTimeout(e.onFinished, e.finishedTimeout));
          }),
          (c.componentDidMount = function () {
            var e = this,
              t = this.props.linesPerSecond,
              n = void 0 === t ? 2.5 : t;
            this.timer = setInterval(function () {
              return e.tick();
            }, 1e3 / n);
          }),
          (c.componentWillUnmount = function () {
            clearTimeout(this.timer);
          }),
          (c.render = function () {
            return (0, o.createComponentVNode)(2, a.Box, {
              m: 1,
              children: this.state.currentDisplay.map(function (e) {
                return (0,
                o.createFragment)([e, (0, o.createVNode)(1, "br")], 0, e);
              }),
            });
          }),
          r
        );
      })(o.Component);
      t.FakeTerminal = i;
      t.SyndContractor = function (e, t) {
        return (0, o.createComponentVNode)(2, c.NtosWindow, {
          theme: "syndicate",
          resizable: !0,
          width: 500,
          height: 600,
          children: (0, o.createComponentVNode)(2, c.NtosWindow.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, l),
          }),
        });
      };
      var l = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.data,
          l = n.act,
          d = [
            "Recording biometric data...",
            "Analyzing embedded syndicate info...",
            "STATUS CONFIRMED",
            "Contacting syndicate database...",
            "Awaiting response...",
            "Awaiting response...",
            "Awaiting response...",
            "Awaiting response...",
            "Awaiting response...",
            "Awaiting response...",
            "Response received, ack 4851234...",
            "CONFIRM ACC " + Math.round(2e4 * Math.random()),
            "Setting up private accounts...",
            "CONTRACTOR ACCOUNT CREATED",
            "Searching for available contracts...",
            "Searching for available contracts...",
            "Searching for available contracts...",
            "Searching for available contracts...",
            "CONTRACTS FOUND",
            "WELCOME, AGENT",
          ],
          s =
            !!c.error &&
            (0, o.createComponentVNode)(2, a.Modal, {
              backgroundColor: "red",
              children: (0, o.createComponentVNode)(2, a.Flex, {
                align: "center",
                children: [
                  (0, o.createComponentVNode)(2, a.Flex.Item, {
                    mr: 2,
                    children: (0, o.createComponentVNode)(2, a.Icon, {
                      size: 4,
                      name: "exclamation-triangle",
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.Flex.Item, {
                    mr: 2,
                    grow: 1,
                    textAlign: "center",
                    children: [
                      (0, o.createComponentVNode)(2, a.Box, {
                        width: "260px",
                        textAlign: "left",
                        minHeight: "80px",
                        children: c.error,
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Dismiss",
                        onClick: function () {
                          return l("PRG_clear_error");
                        },
                      }),
                    ],
                  }),
                ],
              }),
            });
        return c.logged_in
          ? c.logged_in && c.first_load
            ? (0, o.createComponentVNode)(2, a.Box, {
                backgroundColor: "rgba(0, 0, 0, 0.8)",
                minHeight: "525px",
                children: (0, o.createComponentVNode)(2, i, {
                  allMessages: d,
                  finishedTimeout: 3e3,
                  onFinished: function () {
                    return l("PRG_set_first_load_finished");
                  },
                }),
              })
            : c.info_screen
            ? (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, a.Box, {
                    backgroundColor: "rgba(0, 0, 0, 0.8)",
                    minHeight: "500px",
                    children: (0, o.createComponentVNode)(2, i, {
                      allMessages: [
                        "SyndTract v2.0",
                        "",
                        "We've identified potentional high-value targets that are",
                        "currently assigned to your mission area. They are believed",
                        "to hold valuable information which could be of immediate",
                        "importance to our organisation.",
                        "",
                        "Listed below are all of the contracts available to you. You",
                        "are to bring the specified target to the designated",
                        "drop-off, and contact us via this uplink. We will send",
                        "a specialised extraction unit to put the body into.",
                        "",
                        "We want targets alive - but we will sometimes pay slight",
                        "amounts if they're not, you just won't recieve the shown",
                        "bonus. You can redeem your payment through this uplink in",
                        "the form of raw telecrystals, which can be put into your",
                        "regular Syndicate uplink to purchase whatever you may need.",
                        "We provide you with these crystals the moment you send the",
                        "target up to us, which can be collected at anytime through",
                        "this system.",
                        "",
                        "Targets extracted will be ransomed back to the station once",
                        "their use to us is fulfilled, with us providing you a small",
                        "percentage cut. You may want to be mindful of them",
                        "identifying you when they come back. We provide you with",
                        "a standard contractor loadout, which will help cover your",
                        "identity.",
                      ],
                      linesPerSecond: 10,
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    fluid: !0,
                    content: "CONTINUE",
                    color: "transparent",
                    textAlign: "center",
                    onClick: function () {
                      return l("PRG_toggle_info");
                    },
                  }),
                ],
                4
              )
            : (0, o.createFragment)([s, (0, o.createComponentVNode)(2, u)], 0)
          : (0, o.createComponentVNode)(2, a.Section, {
              minHeight: "525px",
              children: [
                (0, o.createComponentVNode)(2, a.Box, {
                  width: "100%",
                  textAlign: "center",
                  children: (0, o.createComponentVNode)(2, a.Button, {
                    content: "REGISTER USER",
                    color: "transparent",
                    onClick: function () {
                      return l("PRG_login");
                    },
                  }),
                }),
                !!c.error &&
                  (0, o.createComponentVNode)(2, a.NoticeBox, {
                    children: c.error,
                  }),
              ],
            });
      };
      t.SyndContractorContent = l;
      var d = function (e, t) {
        var n = (0, r.useBackend)(t),
          c = n.act,
          i = n.data;
        return (0, o.createComponentVNode)(2, a.Section, {
          title: (0, o.createFragment)(
            [
              (0, o.createTextVNode)("Contractor Status"),
              (0, o.createComponentVNode)(2, a.Button, {
                content: "View Information Again",
                color: "transparent",
                mb: 0,
                ml: 1,
                onClick: function () {
                  return c("PRG_toggle_info");
                },
              }),
            ],
            4
          ),
          buttons: (0, o.createComponentVNode)(2, a.Box, {
            bold: !0,
            mr: 1,
            children: [i.contract_rep, " Rep"],
          }),
          children: (0, o.createComponentVNode)(2, a.Grid, {
            children: [
              (0, o.createComponentVNode)(2, a.Grid.Column, {
                size: 0.85,
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "TC Availible",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        content: "Claim",
                        disabled: i.redeemable_tc <= 0,
                        onClick: function () {
                          return c("PRG_redeem_TC");
                        },
                      }),
                      children: i.redeemable_tc,
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "TC Earned",
                      children: i.earned_tc,
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, a.Grid.Column, {
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Contracts Completed",
                      children: i.contracts_completed,
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Current Status",
                      children: "ACTIVE",
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
      t.StatusPane = d;
      var u = function (e, t) {
        var n = (0, r.useLocalState)(t, "tab", 1),
          c = n[0],
          i = n[1];
        return (0, o.createFragment)(
          [
            (0, o.createComponentVNode)(2, d, { state: e.state }),
            (0, o.createComponentVNode)(2, a.Tabs, {
              children: [
                (0, o.createComponentVNode)(2, a.Tabs.Tab, {
                  selected: 1 === c,
                  onClick: function () {
                    return i(1);
                  },
                  children: "Contracts",
                }),
                (0, o.createComponentVNode)(2, a.Tabs.Tab, {
                  selected: 2 === c,
                  onClick: function () {
                    return i(2);
                  },
                  children: "Hub",
                }),
              ],
            }),
            1 === c && (0, o.createComponentVNode)(2, s),
            2 === c && (0, o.createComponentVNode)(2, m),
          ],
          0
        );
      };
      t.SyndPane = u;
      var s = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data,
            l = i.contracts || [];
          return (0, o.createFragment)(
            [
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Availible Contracts",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  content: "Call Extraction",
                  disabled: !i.ongoing_contract || i.extraction_enroute,
                  onClick: function () {
                    return c("PRG_call_extraction");
                  },
                }),
                children: l.map(function (e) {
                  if (!i.ongoing_contract || 2 === e.status) {
                    var t = e.status > 1;
                    if (!(e.status >= 5))
                      return (0, o.createComponentVNode)(
                        2,
                        a.Section,
                        {
                          title: e.target
                            ? e.target + " (" + e.target_rank + ")"
                            : "Invalid Target",
                          level: t ? 1 : 2,
                          buttons: (0, o.createFragment)(
                            [
                              (0, o.createComponentVNode)(2, a.Box, {
                                inline: !0,
                                bold: !0,
                                mr: 1,
                                children: [
                                  e.payout,
                                  " (+",
                                  e.payout_bonus,
                                  ") TC",
                                ],
                              }),
                              (0, o.createComponentVNode)(2, a.Button, {
                                content: t ? "Abort" : "Accept",
                                disabled: e.extraction_enroute,
                                color: t && "bad",
                                onClick: function () {
                                  return c(
                                    "PRG_contract" + (t ? "_abort" : "-accept"),
                                    { contract_id: e.id }
                                  );
                                },
                              }),
                            ],
                            4
                          ),
                          children: (0, o.createComponentVNode)(2, a.Grid, {
                            children: [
                              (0, o.createComponentVNode)(2, a.Grid.Column, {
                                children: e.message,
                              }),
                              (0, o.createComponentVNode)(2, a.Grid.Column, {
                                size: 0.5,
                                children: [
                                  (0, o.createComponentVNode)(2, a.Box, {
                                    bold: !0,
                                    mb: 1,
                                    children: "Dropoff Location:",
                                  }),
                                  (0, o.createComponentVNode)(2, a.Box, {
                                    children: e.dropoff,
                                  }),
                                ],
                              }),
                            ],
                          }),
                        },
                        e.target
                      );
                  }
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Dropoff Locator",
                textAlign: "center",
                opacity: i.ongoing_contract ? 100 : 0,
                children: (0, o.createComponentVNode)(2, a.Box, {
                  bold: !0,
                  children: i.dropoff_direction,
                }),
              }),
            ],
            4
          );
        },
        m = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data,
            l = i.contractor_hub_items || [];
          return (0, o.createComponentVNode)(2, a.Section, {
            children: l.map(function (e) {
              var t = e.cost ? e.cost + " Rep" : "FREE",
                n = -1 !== e.limited;
              return (0, o.createComponentVNode)(
                2,
                a.Section,
                {
                  title: e.name + " - " + t,
                  level: 2,
                  buttons: (0, o.createFragment)(
                    [
                      n &&
                        (0, o.createComponentVNode)(2, a.Box, {
                          inline: !0,
                          bold: !0,
                          mr: 1,
                          children: [e.limited, " remaining"],
                        }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        content: "Purchase",
                        disabled:
                          i.contract_rep < e.cost || (n && e.limited <= 0),
                        onClick: function () {
                          return c("buy_hub", { item: e.name, cost: e.cost });
                        },
                      }),
                    ],
                    0
                  ),
                  children: (0, o.createComponentVNode)(2, a.Table, {
                    children: (0, o.createComponentVNode)(2, a.Table.Row, {
                      children: [
                        (0, o.createComponentVNode)(2, a.Table.Cell, {
                          children: (0, o.createComponentVNode)(2, a.Icon, {
                            fontSize: "60px",
                            name: e.item_icon,
                          }),
                        }),
                        (0, o.createComponentVNode)(2, a.Table.Cell, {
                          verticalAlign: "top",
                          children: e.desc,
                        }),
                      ],
                    }),
                  }),
                },
                e.name
              );
            }),
          });
        };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.TachyonArrayContent = t.TachyonArray = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.TachyonArray = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = (n.act, n.data.records),
          d = void 0 === l ? [] : l;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 500,
          height: 225,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: d.length
              ? (0, o.createComponentVNode)(2, i)
              : (0, o.createComponentVNode)(2, a.NoticeBox, {
                  children: "No Records",
                }),
          }),
        });
      };
      var i = function (e, t) {
        var n,
          c = (0, r.useBackend)(t),
          i = c.act,
          l = c.data.records,
          d = void 0 === l ? [] : l,
          u = (0, r.useSharedState)(
            t,
            "record",
            null == (n = d[0]) ? void 0 : n.name
          ),
          s = u[0],
          m = u[1],
          p = d.find(function (e) {
            return e.name === s;
          });
        return (0, o.createComponentVNode)(2, a.Section, {
          children: (0, o.createComponentVNode)(2, a.Flex, {
            children: [
              (0, o.createComponentVNode)(2, a.Flex.Item, {
                children: (0, o.createComponentVNode)(2, a.Tabs, {
                  vertical: !0,
                  children: d.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      a.Tabs.Tab,
                      {
                        icon: "file",
                        selected: e.name === s,
                        onClick: function () {
                          return m(e.name);
                        },
                        children: e.name,
                      },
                      e.name
                    );
                  }),
                }),
              }),
              p
                ? (0, o.createComponentVNode)(2, a.Flex.Item, {
                    children: (0, o.createComponentVNode)(2, a.Section, {
                      level: "2",
                      title: p.name,
                      buttons: (0, o.createFragment)(
                        [
                          (0, o.createComponentVNode)(2, a.Button.Confirm, {
                            icon: "trash",
                            content: "Delete",
                            color: "bad",
                            onClick: function () {
                              return i("delete_record", { ref: p.ref });
                            },
                          }),
                          (0, o.createComponentVNode)(2, a.Button, {
                            icon: "print",
                            content: "Print",
                            onClick: function () {
                              return i("print_record", { ref: p.ref });
                            },
                          }),
                        ],
                        4
                      ),
                      children: (0, o.createComponentVNode)(2, a.LabeledList, {
                        children: [
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Timestamp",
                            children: p.timestamp,
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Coordinates",
                            children: p.coordinates,
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Displacement",
                            children: [p.displacement, " seconds"],
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Epicenter Radius",
                            children: [
                              p.factual_epicenter_radius,
                              p.theory_epicenter_radius &&
                                " (Theoretical: " +
                                  p.theory_epicenter_radius +
                                  ")",
                            ],
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Outer Radius",
                            children: [
                              p.factual_outer_radius,
                              p.theory_outer_radius &&
                                " (Theoretical: " + p.theory_outer_radius + ")",
                            ],
                          }),
                          (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                            label: "Shockwave Radius",
                            children: [
                              p.factual_shockwave_radius,
                              p.theory_shockwave_radius &&
                                " (Theoretical: " +
                                  p.theory_shockwave_radius +
                                  ")",
                            ],
                          }),
                        ],
                      }),
                    }),
                  })
                : (0, o.createComponentVNode)(2, a.Flex.Item, {
                    grow: 1,
                    basis: 0,
                    children: (0, o.createComponentVNode)(2, a.NoticeBox, {
                      children: "No Record Selected",
                    }),
                  }),
            ],
          }),
        });
      };
      t.TachyonArrayContent = i;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Tank = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.Tank = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 400,
          height: 120,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Pressure",
                    children: (0, o.createComponentVNode)(2, a.ProgressBar, {
                      value: l.tankPressure / 1013,
                      ranges: {
                        good: [0.35, Infinity],
                        average: [0.15, 0.35],
                        bad: [-Infinity, 0.15],
                      },
                      children: l.tankPressure + " kPa",
                    }),
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Pressure Regulator",
                    children: [
                      (0, o.createComponentVNode)(2, a.Button, {
                        icon: "fast-backward",
                        disabled: l.ReleasePressure === l.minReleasePressure,
                        onClick: function () {
                          return i("pressure", { pressure: "min" });
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.NumberInput, {
                        animated: !0,
                        value: parseFloat(l.releasePressure),
                        width: "65px",
                        unit: "kPa",
                        minValue: l.minReleasePressure,
                        maxValue: l.maxReleasePressure,
                        onChange: function (e, t) {
                          return i("pressure", { pressure: t });
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        icon: "fast-forward",
                        disabled: l.ReleasePressure === l.maxReleasePressure,
                        onClick: function () {
                          return i("pressure", { pressure: "max" });
                        },
                      }),
                      (0, o.createComponentVNode)(2, a.Button, {
                        icon: "undo",
                        content: "",
                        disabled:
                          l.ReleasePressure === l.defaultReleasePressure,
                        onClick: function () {
                          return i("pressure", { pressure: "reset" });
                        },
                      }),
                    ],
                  }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.TankDispenser = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.TankDispenser = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 275,
          height: 103,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: (0, o.createComponentVNode)(2, a.LabeledList, {
                children: [
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Plasma",
                    buttons: (0, o.createComponentVNode)(2, a.Button, {
                      icon: l.plasma ? "square" : "square-o",
                      content: "Dispense",
                      disabled: !l.plasma,
                      onClick: function () {
                        return i("plasma");
                      },
                    }),
                    children: l.plasma,
                  }),
                  (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Oxygen",
                    buttons: (0, o.createComponentVNode)(2, a.Button, {
                      icon: l.oxygen ? "square" : "square-o",
                      content: "Dispense",
                      disabled: !l.oxygen,
                      onClick: function () {
                        return i("oxygen");
                      },
                    }),
                    children: l.oxygen,
                  }),
                ],
              }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Teleporter = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.Teleporter = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.calibrated,
          u = l.calibrating,
          s = l.power_station,
          m = l.regime_set,
          p = l.teleporter_hub,
          C = l.target;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 470,
          height: 140,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children:
                (!s &&
                  (0, o.createComponentVNode)(2, a.Box, {
                    color: "bad",
                    textAlign: "center",
                    children: "No power station linked.",
                  })) ||
                (!p &&
                  (0, o.createComponentVNode)(2, a.Box, {
                    color: "bad",
                    textAlign: "center",
                    children: "No hub linked.",
                  })) ||
                (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Current Regime",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: "tools",
                        content: "Change Regime",
                        onClick: function () {
                          return i("regimeset");
                        },
                      }),
                      children: m,
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Current Target",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: "tools",
                        content: "Set Target",
                        onClick: function () {
                          return i("settarget");
                        },
                      }),
                      children: C,
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Calibration",
                      buttons: (0, o.createComponentVNode)(2, a.Button, {
                        icon: "tools",
                        content: "Calibrate Hub",
                        onClick: function () {
                          return i("calibrate");
                        },
                      }),
                      children:
                        (u &&
                          (0, o.createComponentVNode)(2, a.Box, {
                            color: "average",
                            children: "In Progress",
                          })) ||
                        (d &&
                          (0, o.createComponentVNode)(2, a.Box, {
                            color: "good",
                            children: "Optimal",
                          })) ||
                        (0, o.createComponentVNode)(2, a.Box, {
                          color: "bad",
                          children: "Sub-Optimal",
                        }),
                    }),
                  ],
                }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.ThermoMachine = void 0);
      var o = n(0),
        r = n(8),
        a = n(2),
        c = n(1),
        i = n(3);
      t.ThermoMachine = function (e, t) {
        var n = (0, a.useBackend)(t),
          l = n.act,
          d = n.data;
        return (0, o.createComponentVNode)(2, i.Window, {
          width: 300,
          height: 250,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Status",
                children: (0, o.createComponentVNode)(2, c.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Temperature",
                      children: [
                        (0, o.createComponentVNode)(2, c.AnimatedNumber, {
                          value: d.temperature,
                          format: function (e) {
                            return (0, r.toFixed)(e, 2);
                          },
                        }),
                        " K",
                      ],
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Pressure",
                      children: [
                        (0, o.createComponentVNode)(2, c.AnimatedNumber, {
                          value: d.pressure,
                          format: function (e) {
                            return (0, r.toFixed)(e, 2);
                          },
                        }),
                        " kPa",
                      ],
                    }),
                  ],
                }),
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                title: "Controls",
                buttons: (0, o.createComponentVNode)(2, c.Button, {
                  icon: d.on ? "power-off" : "times",
                  content: d.on ? "On" : "Off",
                  selected: d.on,
                  onClick: function () {
                    return l("power");
                  },
                }),
                children: (0, o.createComponentVNode)(2, c.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Setting",
                      children: (0, o.createComponentVNode)(2, c.Button, {
                        icon: d.cooling ? "cooling" : "heating",
                        content: d.cooling ? "Cooling" : "Heating",
                        selected: d.cooling,
                        onClick: function () {
                          return l("cooling");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Target Temperature",
                      children: (0, o.createComponentVNode)(2, c.NumberInput, {
                        animated: !0,
                        value: Math.round(d.target),
                        unit: "K",
                        width: "62px",
                        minValue: Math.round(d.min),
                        maxValue: Math.round(d.max),
                        step: 5,
                        stepPixelSize: 3,
                        onDrag: function (e, t) {
                          return l("target", { target: t });
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, c.LabeledList.Item, {
                      label: "Presets",
                      children: [
                        (0, o.createComponentVNode)(2, c.Button, {
                          icon: "fast-backward",
                          disabled: d.target === d.min,
                          title: "Minimum temperature",
                          onClick: function () {
                            return l("target", { target: d.min });
                          },
                        }),
                        (0, o.createComponentVNode)(2, c.Button, {
                          icon: "sync",
                          disabled: d.target === d.initial,
                          title: "Room Temperature",
                          onClick: function () {
                            return l("target", { target: d.initial });
                          },
                        }),
                        (0, o.createComponentVNode)(2, c.Button, {
                          icon: "fast-forward",
                          disabled: d.target === d.max,
                          title: "Maximum Temperature",
                          onClick: function () {
                            return l("target", { target: d.max });
                          },
                        }),
                      ],
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.TicketMenu = t.TicketBrowser = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = n(19);
      t.TicketBrowser = function (e, t) {
        var n = (0, r.useBackend)(t).data,
          i = n.unclaimed_tickets,
          d = void 0 === i ? [] : i,
          u = n.open_tickets,
          s = void 0 === u ? [] : u,
          m = n.closed_tickets,
          p = void 0 === m ? [] : m,
          C = n.resolved_tickets,
          h = void 0 === C ? [] : C,
          N = n.admin_ckey;
        return (0, o.createComponentVNode)(2, c.Window, {
          theme: "admin",
          resizable: !0,
          width: 720,
          height: 480,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                title: (0, o.createComponentVNode)(2, a.Table, {
                  children: (0, o.createComponentVNode)(2, a.Table.Row, {
                    children: (0, o.createComponentVNode)(2, a.Table.Cell, {
                      inline: !0,
                      children: ["Administrator : ", N],
                    }),
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                children: [
                  (0, o.createComponentVNode)(2, l, {
                    ticket_list: d,
                    name: "Unclaimed Tickets",
                    actions: [
                      ["flw", "blue"],
                      ["claim", "good"],
                      ["reject", "bad"],
                      ["ic", "label"],
                      ["mhelp", "label"],
                    ],
                  }),
                  (0, o.createComponentVNode)(2, l, {
                    ticket_list: s,
                    name: "Claimed Tickets",
                    actions: [
                      ["flw", "blue"],
                      ["claim", "average"],
                      ["resolve", "good"],
                      ["reject", "bad"],
                      ["close", "label"],
                      ["mhelp", "label"],
                      ["ic", "label"],
                    ],
                  }),
                  (0, o.createComponentVNode)(2, l, {
                    ticket_list: h,
                    name: "Resolved Tickets",
                    actions: [
                      ["flw", "blue"],
                      ["reopen", "good"],
                    ],
                  }),
                  (0, o.createComponentVNode)(2, l, {
                    ticket_list: p,
                    name: "Closed Tickets",
                    actions: [
                      ["flw", "blue"],
                      ["reopen", "good"],
                    ],
                  }),
                ],
              }),
            ],
          }),
        });
      };
      var l = function (e, t) {
        var n = e.ticket_list,
          c = e.name,
          l = e.actions,
          d = void 0 === l ? [] : l,
          u = (0, r.useBackend)(t).act;
        return (0, o.createComponentVNode)(2, a.Section, {
          title: c,
          children: (0, o.createComponentVNode)(2, a.Table, {
            children: n.map(function (e) {
              return (0, o.createComponentVNode)(
                2,
                a.Section,
                {
                  children: [
                    (0, o.createComponentVNode)(2, a.Table.Row, {
                      children: [
                        (0, o.createComponentVNode)(2, a.Table.Cell, {
                          bold: !0,
                          collapsing: !0,
                          children: (0, o.createComponentVNode)(2, a.Button, {
                            color: "transparent",
                            onClick: function () {
                              return u("view", { id: e.id });
                            },
                            children: (0, o.createVNode)(
                              1,
                              "u",
                              null,
                              "#" + e.id,
                              0
                            ),
                          }),
                        }),
                        (0, o.createComponentVNode)(2, a.Table.Cell, {
                          children: (0, o.createComponentVNode)(2, a.Button, {
                            color: e.disconnected ? "bad" : "transparent",
                            onClick: function () {
                              return u("pm", { id: e.id });
                            },
                            children: (0, o.createVNode)(
                              1,
                              "u",
                              null,
                              [
                                e.initiator_key_name,
                                (0, o.createTextVNode)(" \\"),
                                e.disconnected ? "[DC]" : "",
                              ],
                              0
                            ),
                          }),
                        }),
                        d.map(function (t) {
                          return (0, o.createComponentVNode)(
                            2,
                            a.Table.Cell,
                            {
                              collapsing: !0,
                              children: (0, o.createComponentVNode)(
                                2,
                                a.Button,
                                {
                                  content: (0, i.capitalize)(t[0]),
                                  onClick: function () {
                                    return u(t[0], { id: e.id });
                                  },
                                  color: t[1],
                                }
                              ),
                            },
                            t[0]
                          );
                        }),
                      ],
                    }),
                    (0, o.createComponentVNode)(2, a.BlockQuote, {
                      children: e.name,
                    }),
                    (0, o.createComponentVNode)(2, a.Box, {
                      color: e.claimed_key_name ? "good" : "bad",
                      children: e.claimed_key_name
                        ? e.state < 3
                          ? "Claimed by " + e.claimed_key_name
                          : 3 === e.state
                          ? "Closed by " + e.claimed_key_name
                          : "Resolved by " + e.claimed_key_name
                        : "UNCLAIMED",
                    }),
                  ],
                },
                e.name
              );
            }),
          }),
        });
      };
      t.TicketMenu = l;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0),
        (t.TicketChatWindow = t.TicketClosureStates = t.TicketFullMonty = t.TicketActionBar = t.TicketMessenger = void 0);
      var o = n(0),
        r = n(19),
        a = n(2),
        c = n(1),
        i = n(3),
        l = n(8);
      t.TicketMessenger = function (e, t) {
        return (0, o.createComponentVNode)(2, i.Window, {
          theme: "admin",
          width: 620,
          height: 500,
          resizable: !0,
          children: (0, o.createComponentVNode)(2, i.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, c.Section, {
                height: "85px",
                children: (0, o.createComponentVNode)(2, d),
              }),
              (0, o.createComponentVNode)(2, c.Section, {
                children: (0, o.createComponentVNode)(2, m),
              }),
            ],
          }),
        });
      };
      var d = function (e, t) {
        var n = (0, a.useBackend)(t),
          r = n.act,
          i = n.data,
          d = i.disconnected,
          m = i.time_opened,
          p = (i.time_closed, i.world_time),
          C = (i.ticket_state, i.claimee, i.claimee_key),
          h = i.antag_status,
          N = i.id,
          V = i.sender;
        return (0, o.createComponentVNode)(2, c.Box, {
          children: [
            (0, o.createComponentVNode)(2, c.Box, {
              bold: !0,
              inline: !0,
              children: ["Admin Help Ticket #", N, " : ", V],
            }),
            (0, o.createComponentVNode)(2, c.Box, {
              inline: !0,
              color: "None" === h ? "green" : "red",
              children: ["Antag: ", h],
            }),
            (0, o.createComponentVNode)(2, c.Box),
            (0, o.createComponentVNode)(2, c.Box, {
              inline: !0,
              color: C ? "blue" : "red",
              bold: !0,
              children: ["Claimed by ", C || "Nobody"],
            }),
            (0, o.createComponentVNode)(2, c.Box, {
              inline: !0,
              children: "|",
            }),
            (0, o.createComponentVNode)(2, c.Box, {
              inline: !0,
              bold: !0,
              children: [
                "Opened ",
                (0, l.round)((p - m) / 600),
                " minutes ago",
              ],
            }),
            (0, o.createComponentVNode)(2, c.Box, {
              inline: !0,
              children: [
                " |",
                (0, o.createComponentVNode)(2, c.Button, {
                  color: "transparent",
                  content: "Re-title",
                  onClick: function () {
                    return r("retitle");
                  },
                }),
                "|",
                (0, o.createComponentVNode)(2, c.Button, {
                  color: "transparent",
                  content: "Reopen",
                  onClick: function () {
                    return r("reopen");
                  },
                }),
                "|",
              ],
            }),
            (0, o.createComponentVNode)(2, c.Divider),
            (0, o.createComponentVNode)(2, c.Box, {
              children: [
                d ? "DISCONNECTED" : (0, o.createComponentVNode)(2, u),
                (0, o.createComponentVNode)(2, s),
              ],
            }),
          ],
        });
      };
      t.TicketActionBar = d;
      var u = function (e, t) {
        var n = (0, a.useBackend)(t).act;
        return (0, o.createComponentVNode)(2, c.Box, {
          inline: !0,
          children: [
            (0, o.createComponentVNode)(2, c.Button, {
              color: "purple",
              content: "?",
              onClick: function () {
                return n("moreinfo");
              },
            }),
            (0, o.createComponentVNode)(2, c.Button, {
              color: "blue",
              content: "PP",
              onClick: function () {
                return n("playerpanel");
              },
            }),
            (0, o.createComponentVNode)(2, c.Button, {
              color: "blue",
              content: "VV",
              onClick: function () {
                return n("viewvars");
              },
            }),
            (0, o.createComponentVNode)(2, c.Button, {
              color: "blue",
              content: "SM",
              onClick: function () {
                return n("subtlemsg");
              },
            }),
            (0, o.createComponentVNode)(2, c.Button, {
              color: "blue",
              content: "FLW",
              onClick: function () {
                return n("flw");
              },
            }),
            (0, o.createComponentVNode)(2, c.Button, {
              color: "blue",
              content: "TP",
              onClick: function () {
                return n("traitorpanel");
              },
            }),
            (0, o.createComponentVNode)(2, c.Button, {
              color: "green",
              content: "LOG",
              onClick: function () {
                return n("viewlogs");
              },
            }),
            (0, o.createComponentVNode)(2, c.Button, {
              color: "red",
              content: "SMITE",
              onClick: function () {
                return n("smite");
              },
            }),
          ],
        });
      };
      t.TicketFullMonty = u;
      var s = function (e, t) {
        var n = (0, a.useBackend)(t).act;
        return (0, o.createComponentVNode)(2, c.Box, {
          inline: !0,
          children: [
            (0, o.createComponentVNode)(2, c.Button, {
              content: "REJT",
              onClick: function () {
                return n("reject");
              },
            }),
            (0, o.createComponentVNode)(2, c.Button, {
              content: "IC",
              onClick: function () {
                return n("markic");
              },
            }),
            (0, o.createComponentVNode)(2, c.Button, {
              content: "CLOSE",
              onClick: function () {
                return n("close");
              },
            }),
            (0, o.createComponentVNode)(2, c.Button, {
              content: "RSLVE",
              onClick: function () {
                return n("resolve");
              },
            }),
            (0, o.createComponentVNode)(2, c.Button, {
              content: "MHELP",
              onClick: function () {
                return n("mentorhelp");
              },
            }),
          ],
        });
      };
      t.TicketClosureStates = s;
      var m = function (e, t) {
        var n = (0, a.useBackend)(t),
          i = n.act,
          l = n.data.messages,
          d = void 0 === l ? [] : l;
        return (0, o.createComponentVNode)(2, c.Box, {
          children: [
            (0, o.createComponentVNode)(2, c.Box, {
              overflowY: "scroll",
              height: "315px",
              children: (0, o.createComponentVNode)(2, c.Table, {
                children: d.map(function (e) {
                  return (0,
                  o.createComponentVNode)(2, c.Section, { children: (0, o.createComponentVNode)(2, c.Table.Row, { children: [(0, o.createComponentVNode)(2, c.Table.Cell, { children: e.time }), (0, o.createComponentVNode)(2, c.Table.Cell, { color: e.color, children: (0, o.createComponentVNode)(2, c.Box, { children: [(0, o.createComponentVNode)(2, c.Box, { inline: !0, bold: !0, children: e.from && e.to ? "PM from " + (0, r.decodeHtmlEntities)(e.from) + " to " + (0, r.decodeHtmlEntities)(e.to) : (0, r.decodeHtmlEntities)(e.from) ? "Reply PM from " + (0, r.decodeHtmlEntities)(e.from) : (0, r.decodeHtmlEntities)(e.to) ? "PM to " + (0, r.decodeHtmlEntities)(e.to) : "" }), (0, o.createComponentVNode)(2, c.Box, { inline: !0, children: (0, r.decodeHtmlEntities)(e.message) })] }) })] }) }, e.time);
                }),
              }),
            }),
            (0, o.createComponentVNode)(2, c.Divider),
            (0, o.createComponentVNode)(2, c.Input, {
              fluid: !0,
              selfClear: !0,
              onEnter: function (e, t) {
                return i("sendpm", { text: t });
              },
            }),
          ],
        });
      };
      t.TicketChatWindow = m;
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Timer = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.Timer = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.minutes,
          u = l.seconds,
          s = l.timing,
          m = l.loop;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 275,
          height: 115,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              title: "Timing Unit",
              buttons: (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: "sync",
                    content: m ? "Repeating" : "Repeat",
                    selected: m,
                    onClick: function () {
                      return i("repeat");
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: "clock-o",
                    content: s ? "Stop" : "Start",
                    selected: s,
                    onClick: function () {
                      return i("time");
                    },
                  }),
                ],
                4
              ),
              children: [
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "fast-backward",
                  disabled: s,
                  onClick: function () {
                    return i("input", { adjust: -30 });
                  },
                }),
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "backward",
                  disabled: s,
                  onClick: function () {
                    return i("input", { adjust: -1 });
                  },
                }),
                " ",
                String(d).padStart(2, "0"),
                ":",
                String(u).padStart(2, "0"),
                " ",
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "forward",
                  disabled: s,
                  onClick: function () {
                    return i("input", { adjust: 1 });
                  },
                }),
                (0, o.createComponentVNode)(2, a.Button, {
                  icon: "fast-forward",
                  disabled: s,
                  onClick: function () {
                    return i("input", { adjust: 30 });
                  },
                }),
              ],
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.TransferValve = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.TransferValve = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.tank_one,
          u = l.tank_two,
          s = l.attached_device,
          m = l.valve;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 310,
          height: 320,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                    label: "Valve Status",
                    children: (0, o.createComponentVNode)(2, a.Button, {
                      icon: m ? "unlock" : "lock",
                      content: m ? "Open" : "Closed",
                      disabled: !d || !u,
                      onClick: function () {
                        return i("toggle");
                      },
                    }),
                  }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Valve Attachment",
                buttons: (0, o.createComponentVNode)(2, a.Button, {
                  textAlign: "center",
                  width: "30px",
                  icon: "cog",
                  disabled: !s,
                  onClick: function () {
                    return i("device");
                  },
                }),
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: s
                    ? (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Attachment",
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          icon: "wrench",
                          content: s,
                          disabled: !s,
                          onClick: function () {
                            return i("remove_device");
                          },
                        }),
                      })
                    : (0, o.createComponentVNode)(2, a.NoticeBox, {
                        textAlign: "center",
                        children: "Insert Assembly",
                      }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Attachment One",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: d
                    ? (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Attachment",
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          icon: "wrench",
                          content: d,
                          disabled: !d,
                          onClick: function () {
                            return i("tankone");
                          },
                        }),
                      })
                    : (0, o.createComponentVNode)(2, a.NoticeBox, {
                        textAlign: "center",
                        children: "Insert Tank",
                      }),
                }),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Attachment Two",
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: u
                    ? (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Attachment",
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          icon: "wrench",
                          content: u,
                          disabled: !u,
                          onClick: function () {
                            return i("tanktwo");
                          },
                        }),
                      })
                    : (0, o.createComponentVNode)(2, a.NoticeBox, {
                        textAlign: "center",
                        children: "Insert Tank",
                      }),
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.TurbineComputer = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.TurbineComputer = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = Boolean(
            l.compressor && !l.compressor_broke && l.turbine && !l.turbine_broke
          );
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 310,
          height: 150,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              title: "Status",
              buttons: (0, o.createFragment)(
                [
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: l.online ? "power-off" : "times",
                    content: l.online ? "Online" : "Offline",
                    selected: l.online,
                    disabled: !d,
                    onClick: function () {
                      return i("toggle_power");
                    },
                  }),
                  (0, o.createComponentVNode)(2, a.Button, {
                    icon: "sync",
                    content: "Reconnect",
                    onClick: function () {
                      return i("reconnect");
                    },
                  }),
                ],
                4
              ),
              children:
                (!d &&
                  (0, o.createComponentVNode)(2, a.LabeledList, {
                    children: [
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Compressor Status",
                        color:
                          !l.compressor || l.compressor_broke ? "bad" : "good",
                        children: l.compressor_broke
                          ? l.compressor
                            ? "Offline"
                            : "Missing"
                          : "Online",
                      }),
                      (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                        label: "Turbine Status",
                        color: !l.turbine || l.turbine_broke ? "bad" : "good",
                        children: l.turbine_broke
                          ? l.turbine
                            ? "Offline"
                            : "Missing"
                          : "Online",
                      }),
                    ],
                  })) ||
                (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Turbine Speed",
                      children: [l.rpm, " RPM"],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Internal Temp",
                      children: [l.temp, " K"],
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Generated Power",
                      children: l.power,
                    }),
                  ],
                }),
            }),
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.TurboLift = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.TurboLift = function (e, t) {
        for (
          var n,
            i = (0, r.useBackend)(t),
            l = i.act,
            d = i.data,
            u = 0,
            s = Object.values(d.decks);
          u < s.length;
          u++
        ) {
          var m = s[u];
          m.z === d.current && (n = m.deck);
        }
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          width: 300,
          height: 300,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            scrollable: !0,
            children: [
              (0, o.createComponentVNode)(2, a.NoticeBox, {
                children:
                  (d.online &&
                    ((n && "Currently at deck " + n) ||
                      "Unable to determine current deck.")) ||
                  (0, o.createFragment)(
                    [
                      (0, o.createTextVNode)(
                        "This lift is currently offline. Please contact a Nanotrasen lift repair technician."
                      ),
                    ],
                    4
                  ),
              }),
              (0, o.createComponentVNode)(2, a.Section, {
                title: "Lift panel",
                children: Object.keys(d.decks).map(function (e) {
                  var t = d.decks[e];
                  return (0, o.createComponentVNode)(
                    2,
                    a.Button,
                    {
                      fluid: !0,
                      color:
                        (d.current === t.z ? "blue" : t.queued && "good") ||
                        "normal",
                      content: "Deck " + t.deck + ": " + t.name,
                      bold: d.current === t.z,
                      disabled: !d.online,
                      onClick: function () {
                        d.current !== t.z &&
                          (t.queued || l("goto", { deck: e }));
                      },
                    },
                    e
                  );
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.TurretControl = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3),
        i = n(59);
      t.TurretControl = function (e, t) {
        var n = (0, r.useBackend)(t),
          l = n.act,
          d = n.data,
          u = d.locked && !d.siliconUser,
          s = d.enabled,
          m = d.lethal,
          p = d.shootCyborgs;
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 305,
          height: 172,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, i.InterfaceLockNoticeBox),
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: [
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Turret Status",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: s ? "power-off" : "times",
                        content: s ? "Enabled" : "Disabled",
                        selected: s,
                        disabled: u,
                        onClick: function () {
                          return l("power");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Turret Mode",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: m ? "exclamation-triangle" : "minus-circle",
                        content: m ? "Lethal" : "Stun",
                        color: m ? "bad" : "average",
                        disabled: u,
                        onClick: function () {
                          return l("mode");
                        },
                      }),
                    }),
                    (0, o.createComponentVNode)(2, a.LabeledList.Item, {
                      label: "Target Cyborgs",
                      children: (0, o.createComponentVNode)(2, a.Button, {
                        icon: p ? "check" : "times",
                        content: p ? "Yes" : "No",
                        selected: p,
                        disabled: u,
                        onClick: function () {
                          return l("shoot_silicons");
                        },
                      }),
                    }),
                  ],
                }),
              }),
            ],
          }),
        });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.GenericUplink = t.Uplink = void 0);
      var o = n(0),
        r = n(19),
        a = n(2),
        c = n(1),
        i = n(52),
        l = n(3);
      t.Uplink = function (e, t) {
        var n = (0, a.useBackend)(t).data.telecrystals;
        return (0, o.createComponentVNode)(2, l.Window, {
          theme: "syndicate",
          resizable: !0,
          width: 620,
          height: 580,
          children: (0, o.createComponentVNode)(2, l.Window.Content, {
            scrollable: !0,
            children: (0, o.createComponentVNode)(2, d, {
              currencyAmount: n,
              currencySymbol: "TC",
            }),
          }),
        });
      };
      var d = function (e, t) {
        var n,
          l,
          d = e.currencyAmount,
          s = void 0 === d ? 0 : d,
          m = e.currencySymbol,
          p = void 0 === m ? "cr" : m,
          C = (0, a.useBackend)(t),
          h = C.act,
          N = C.data,
          V = N.compactMode,
          b = N.lockable,
          f = N.categories,
          g = void 0 === f ? [] : f,
          v = (0, a.useLocalState)(t, "searchText", ""),
          k = v[0],
          w = v[1],
          B = (0, a.useLocalState)(
            t,
            "category",
            null == (n = g[0]) ? void 0 : n.name
          ),
          x = B[0],
          _ = B[1],
          L = (0, r.createSearch)(k, function (e) {
            return e.name + e.desc;
          }),
          y =
            (k.length > 0 &&
              g
                .flatMap(function (e) {
                  return e.items || [];
                })
                .filter(L)
                .filter(function (e, t) {
                  return t < 25;
                })) ||
            (null ==
            (l = g.find(function (e) {
              return e.name === x;
            }))
              ? void 0
              : l.items) ||
            [];
        return (0, o.createComponentVNode)(2, c.Section, {
          title: (0, o.createComponentVNode)(2, c.Box, {
            inline: !0,
            color: s > 0 ? "good" : "bad",
            children: [(0, i.formatMoney)(s), " ", p],
          }),
          buttons: (0, o.createFragment)(
            [
              (0, o.createTextVNode)("Search"),
              (0, o.createComponentVNode)(2, c.Input, {
                value: k,
                onInput: function (e, t) {
                  return w(t);
                },
                mx: 1,
              }),
              (0, o.createComponentVNode)(2, c.Button, {
                icon: V ? "list" : "info",
                content: V ? "Compact" : "Detailed",
                onClick: function () {
                  return h("compact_toggle");
                },
              }),
              !!b &&
                (0, o.createComponentVNode)(2, c.Button, {
                  icon: "lock",
                  content: "Lock",
                  onClick: function () {
                    return h("lock");
                  },
                }),
            ],
            0
          ),
          children: (0, o.createComponentVNode)(2, c.Flex, {
            children: [
              0 === k.length &&
                (0, o.createComponentVNode)(2, c.Flex.Item, {
                  children: (0, o.createComponentVNode)(2, c.Tabs, {
                    vertical: !0,
                    children: g.map(function (e) {
                      var t;
                      return (0, o.createComponentVNode)(
                        2,
                        c.Tabs.Tab,
                        {
                          selected: e.name === x,
                          onClick: function () {
                            return _(e.name);
                          },
                          children: [
                            e.name,
                            " (",
                            (null == (t = e.items) ? void 0 : t.length) || 0,
                            ")",
                          ],
                        },
                        e.name
                      );
                    }),
                  }),
                }),
              (0, o.createComponentVNode)(2, c.Flex.Item, {
                grow: 1,
                basis: 0,
                children: [
                  0 === y.length &&
                    (0, o.createComponentVNode)(2, c.NoticeBox, {
                      children:
                        0 === k.length
                          ? "No items in this category."
                          : "No results found.",
                    }),
                  (0, o.createComponentVNode)(2, u, {
                    compactMode: k.length > 0 || V,
                    currencyAmount: s,
                    currencySymbol: p,
                    items: y,
                  }),
                ],
              }),
            ],
          }),
        });
      };
      t.GenericUplink = d;
      var u = function (e, t) {
        var n = e.compactMode,
          l = e.currencyAmount,
          d = e.currencySymbol,
          u = (0, a.useBackend)(t).act,
          s = (0, a.useLocalState)(t, "hoveredItem", {}),
          m = s[0],
          p = s[1],
          C = (m && m.cost) || 0,
          h = e.items.map(function (e) {
            var t = m && m.name !== e.name,
              n = l - C < e.cost,
              o = t && n,
              r = l < e.cost || o;
            return Object.assign({}, e, { disabled: r });
          });
        return n
          ? (0, o.createComponentVNode)(2, c.Table, {
              children: h.map(function (e) {
                return (0, o.createComponentVNode)(
                  2,
                  c.Table.Row,
                  {
                    className: "candystripe",
                    children: [
                      (0, o.createComponentVNode)(2, c.Table.Cell, {
                        bold: !0,
                        children: (0, r.decodeHtmlEntities)(e.name),
                      }),
                      (0, o.createComponentVNode)(2, c.Table.Cell, {
                        collapsing: !0,
                        textAlign: "right",
                        children: (0, o.createComponentVNode)(2, c.Button, {
                          fluid: !0,
                          content: (0, i.formatMoney)(e.cost) + " " + d,
                          disabled: e.disabled,
                          tooltip: e.desc,
                          tooltipPosition: "left",
                          onmouseover: function () {
                            return p(e);
                          },
                          onmouseout: function () {
                            return p({});
                          },
                          onClick: function () {
                            return u("buy", { name: e.name });
                          },
                        }),
                      }),
                    ],
                  },
                  e.name
                );
              }),
            })
          : h.map(function (e) {
              return (0, o.createComponentVNode)(
                2,
                c.Section,
                {
                  title: e.name,
                  level: 2,
                  buttons: (0, o.createComponentVNode)(2, c.Button, {
                    content: e.cost + " " + d,
                    disabled: e.disabled,
                    onmouseover: function () {
                      return p(e);
                    },
                    onmouseout: function () {
                      return p({});
                    },
                    onClick: function () {
                      return u("buy", { name: e.name });
                    },
                  }),
                  children: (0, r.decodeHtmlEntities)(e.desc),
                },
                e.name
              );
            });
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Vending = void 0);
      var o = n(0),
        r = n(6),
        a = n(2),
        c = n(1),
        i = n(3),
        l = function (e, t) {
          var n = (0, a.useBackend)(t),
            i = n.act,
            l = n.data,
            d = e.product,
            u = e.productStock,
            s = e.custom,
            m =
              !l.onstation ||
              0 === d.price ||
              (!d.premium &&
                l.department &&
                l.user &&
                l.department === l.user.department);
          return (0, o.createComponentVNode)(2, c.Table.Row, {
            children: [
              (0, o.createComponentVNode)(2, c.Table.Cell, {
                collapsing: !0,
                children: d.img
                  ? (0, o.createVNode)(1, "img", null, null, 1, {
                      src: "data:image/jpeg;base64," + d.img,
                      style: {
                        "vertical-align": "middle",
                        "horizontal-align": "middle",
                      },
                    })
                  : (0, o.createVNode)(
                      1,
                      "span",
                      (0, r.classes)(["vending32x32", d.path]),
                      null,
                      1,
                      {
                        style: {
                          "vertical-align": "middle",
                          "horizontal-align": "middle",
                        },
                      }
                    ),
              }),
              (0, o.createComponentVNode)(2, c.Table.Cell, {
                bold: !0,
                children: d.name,
              }),
              (0, o.createComponentVNode)(2, c.Table.Cell, {
                collapsing: !0,
                textAlign: "center",
                children: (0, o.createComponentVNode)(2, c.Box, {
                  color: s
                    ? "good"
                    : u <= 0
                    ? "bad"
                    : u <= d.max_amount / 2
                    ? "average"
                    : "good",
                  children: [u, " in stock"],
                }),
              }),
              (0, o.createComponentVNode)(2, c.Table.Cell, {
                collapsing: !0,
                textAlign: "center",
                children:
                  (s &&
                    (0, o.createComponentVNode)(2, c.Button, {
                      fluid: !0,
                      content: l.access ? "FREE" : d.price + " cr",
                      onClick: function () {
                        return i("dispense", { item: d.name });
                      },
                    })) ||
                  (0, o.createComponentVNode)(2, c.Button, {
                    fluid: !0,
                    disabled:
                      0 === u || (!m && (!l.user || d.price > l.user.cash)),
                    content: m ? "FREE" : d.price + " cr",
                    onClick: function () {
                      return i("vend", { ref: d.ref });
                    },
                  }),
              }),
            ],
          });
        };
      t.Vending = function (e, t) {
        var n,
          r = (0, a.useBackend)(t),
          d = (r.act, r.data),
          u = !1;
        return (
          d.vending_machine_input
            ? ((n = d.vending_machine_input), (u = !0))
            : (n = d.extended_inventory
                ? [].concat(d.product_records, d.coin_records, d.hidden_records)
                : [].concat(d.product_records, d.coin_records)),
          (0, o.createComponentVNode)(2, i.Window, {
            resizable: !0,
            width: 400,
            height: 550,
            children: (0, o.createComponentVNode)(2, i.Window.Content, {
              scrollable: !0,
              children: [
                !!d.onstation &&
                  (0, o.createComponentVNode)(2, c.Section, {
                    title: "User",
                    children:
                      (d.user &&
                        (0, o.createComponentVNode)(2, c.Box, {
                          children: [
                            "Welcome, ",
                            (0, o.createVNode)(1, "b", null, d.user.name, 0),
                            ",",
                            " ",
                            (0, o.createVNode)(
                              1,
                              "b",
                              null,
                              d.user.job || "Unemployed",
                              0
                            ),
                            "!",
                            (0, o.createVNode)(1, "br"),
                            "Your balance is ",
                            (0, o.createVNode)(
                              1,
                              "b",
                              null,
                              [d.user.cash, (0, o.createTextVNode)(" credits")],
                              0
                            ),
                            ".",
                          ],
                        })) ||
                      (0, o.createComponentVNode)(2, c.Box, {
                        color: "light-gray",
                        children: [
                          "No registered ID card!",
                          (0, o.createVNode)(1, "br"),
                          "Please contact your local HoP!",
                        ],
                      }),
                  }),
                (0, o.createComponentVNode)(2, c.Section, {
                  title: "Products",
                  children: (0, o.createComponentVNode)(2, c.Table, {
                    children: n.map(function (e) {
                      return (0,
                      o.createComponentVNode)(2, l, { custom: u, product: e, productStock: d.stock[e.name] }, e.name);
                    }),
                  }),
                }),
              ],
            }),
          })
        );
      };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Vote = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      n(24);
      t.Vote = function (e, t) {
        var n = (0, r.useBackend)(t).data,
          d = n.mode,
          s = n.question,
          m = n.lower_admin;
        return (0, o.createComponentVNode)(2, c.Window, {
          resizable: !0,
          title:
            "Vote" +
            (d
              ? ": " +
                (s
                  ? s.replace(/^\w/, function (e) {
                      return e.toUpperCase();
                    })
                  : d.replace(/^\w/, function (e) {
                      return e.toUpperCase();
                    }))
              : ""),
          width: 400,
          height: 500,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            overflowY: "scroll",
            children: (0, o.createComponentVNode)(2, a.Flex, {
              direction: "column",
              height: "100%",
              children: [
                !!m && (0, o.createComponentVNode)(2, i),
                (0, o.createComponentVNode)(2, l),
                (0, o.createComponentVNode)(2, u),
              ],
            }),
          }),
        });
      };
      var i = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data,
            l = i.avm,
            d = i.avr,
            u = i.avmap,
            s = i.voting,
            m = i.upper_admin;
          return (0, o.createComponentVNode)(2, a.Flex.Item, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              mb: 1,
              title: "Admin Options",
              children: [
                (0, o.createComponentVNode)(2, a.Collapsible, {
                  title: "Start a Vote",
                  children: (0, o.createComponentVNode)(2, a.Flex, {
                    mt: 2,
                    justify: "space-between",
                    children: [
                      (0, o.createComponentVNode)(2, a.Flex.Item, {
                        children: [
                          (0, o.createComponentVNode)(2, a.Box, {
                            mb: 1,
                            children: [
                              (0, o.createComponentVNode)(2, a.Button, {
                                disabled: !m || !u,
                                onClick: function () {
                                  return c("map");
                                },
                                children: "Map",
                              }),
                              !!m &&
                                (0, o.createComponentVNode)(
                                  2,
                                  a.Button.Checkbox,
                                  {
                                    ml: 1,
                                    color: "red",
                                    checked: !u,
                                    onClick: function () {
                                      return c("toggle_map");
                                    },
                                    children: ["Disable", u ? "" : "d"],
                                  }
                                ),
                            ],
                          }),
                          (0, o.createComponentVNode)(2, a.Box, {
                            mb: 1,
                            children: [
                              (0, o.createComponentVNode)(2, a.Button, {
                                disabled: !m || !d,
                                onClick: function () {
                                  return c("restart");
                                },
                                children: "Restart",
                              }),
                              !!m &&
                                (0, o.createComponentVNode)(
                                  2,
                                  a.Button.Checkbox,
                                  {
                                    ml: 1,
                                    color: "red",
                                    checked: !d,
                                    onClick: function () {
                                      return c("toggle_restart");
                                    },
                                    children: ["Disable", d ? "" : "d"],
                                  }
                                ),
                            ],
                          }),
                          (0, o.createComponentVNode)(2, a.Box, {
                            mb: 1,
                            children: [
                              (0, o.createComponentVNode)(2, a.Button, {
                                disabled: !m || !l,
                                onClick: function () {
                                  return c("gamemode");
                                },
                                children: "Gamemode",
                              }),
                              !!m &&
                                (0, o.createComponentVNode)(
                                  2,
                                  a.Button.Checkbox,
                                  {
                                    ml: 1,
                                    color: "red",
                                    checked: !l,
                                    onClick: function () {
                                      return c("toggle_gamemode");
                                    },
                                    children: ["Disable", l ? "" : "d"],
                                  }
                                ),
                            ],
                          }),
                        ],
                      }),
                      (0, o.createComponentVNode)(2, a.Flex.Item, {
                        children: (0, o.createComponentVNode)(2, a.Button, {
                          disabled: !m,
                          onClick: function () {
                            return c("custom");
                          },
                          children: "Create Custom Vote",
                        }),
                      }),
                    ],
                  }),
                }),
                (0, o.createComponentVNode)(2, a.Collapsible, {
                  title: "View Voters",
                  children: (0, o.createComponentVNode)(2, a.Box, {
                    mt: 2,
                    width: "100%",
                    height: 6,
                    overflowY: "scroll",
                    children: s.map(function (e) {
                      return (0,
                      o.createComponentVNode)(2, a.Box, { children: e }, e);
                    }),
                  }),
                }),
              ],
            }),
          });
        },
        l = function (e, t) {
          var n,
            c = (0, r.useBackend)(t).data,
            i = c.mode,
            l = c.choices;
          return (
            (n =
              0 === l.length
                ? "No choices available!"
                : (l.length < 10) | ("custom" === i)
                ? (0, o.createComponentVNode)(2, d, {
                    choices: l,
                    tally: "Votes:",
                    startIndex: 0,
                    margin: 1,
                  })
                : (0, o.createComponentVNode)(2, a.Flex, {
                    justify: "space-between",
                    direction: "row",
                    children: [
                      (0, o.createComponentVNode)(2, a.Flex, {
                        direction: "column",
                        children: (0, o.createComponentVNode)(2, d, {
                          choices: l.filter(function (e, t) {
                            return t < l.length / 2;
                          }),
                          tally: "|",
                          startIndex: 0,
                          margin: 0,
                        }),
                      }),
                      (0, o.createComponentVNode)(2, a.Flex, {
                        direction: "column",
                        ml: 1,
                        children: (0, o.createComponentVNode)(2, d, {
                          choices: l.filter(function (e, t) {
                            return t > l.length / 2;
                          }),
                          tally: "|",
                          startIndex: Math.ceil(l.length / 2),
                          margin: 0,
                        }),
                      }),
                    ],
                  })),
            (0, o.createComponentVNode)(2, a.Flex.Item, {
              mb: 1,
              grow: 1,
              children: (0, o.createComponentVNode)(2, a.Section, {
                fill: !0,
                title: "Choices",
                children: n,
              }),
            })
          );
        },
        d = function (e, t) {
          var n,
            c = (0, r.useBackend)(t),
            i = c.act,
            l = c.data.selectedChoice;
          return null == (n = e.choices)
            ? void 0
            : n.map(function (t, n) {
                var r;
                return (0, o.createComponentVNode)(
                  2,
                  a.Flex,
                  {
                    justify: "space-between",
                    direction: "row",
                    mb: e.margin,
                    children: [
                      (0, o.createComponentVNode)(2, a.Flex, {
                        children: [
                          (0, o.createComponentVNode)(2, a.Button, {
                            onClick: function () {
                              i("vote", { index: n + e.startIndex + 1 });
                            },
                            disabled: t === e.choices[l - e.startIndex - 1],
                            children:
                              null == (r = t.name)
                                ? void 0
                                : r.replace(/^\w/, function (e) {
                                    return e.toUpperCase();
                                  }),
                          }),
                          (0, o.createComponentVNode)(2, a.Box, {
                            mt: 0.4,
                            ml: 1,
                            children:
                              t === e.choices[l - e.startIndex - 1] &&
                              (0, o.createComponentVNode)(2, a.Icon, {
                                color: "green",
                                name: "vote-yea",
                              }),
                          }),
                        ],
                      }),
                      (0, o.createComponentVNode)(2, a.Box, {
                        ml: 1,
                        children: [e.tally, " ", t.votes],
                      }),
                    ],
                  },
                  n
                );
              });
        },
        u = function (e, t) {
          var n = (0, r.useBackend)(t),
            c = n.act,
            i = n.data,
            l = i.upper_admin,
            d = i.time_remaining;
          return (0, o.createComponentVNode)(2, a.Flex.Item, {
            children: (0, o.createComponentVNode)(2, a.Section, {
              children: (0, o.createComponentVNode)(2, a.Flex, {
                justify: "space-between",
                children: [
                  !!l &&
                    (0, o.createComponentVNode)(2, a.Button, {
                      onClick: function () {
                        c("cancel");
                      },
                      color: "red",
                      children: "Cancel Vote",
                    }),
                  (0, o.createComponentVNode)(2, a.Box, {
                    fontSize: 1.5,
                    textAlign: "right",
                    children: ["Time Remaining: ", d, "s"],
                  }),
                ],
              }),
            }),
          });
        };
    },
    function (e, t, n) {
      "use strict";
      (t.__esModule = !0), (t.Wires = void 0);
      var o = n(0),
        r = n(2),
        a = n(1),
        c = n(3);
      t.Wires = function (e, t) {
        var n = (0, r.useBackend)(t),
          i = n.act,
          l = n.data,
          d = l.wires || [],
          u = l.status || [];
        return (0, o.createComponentVNode)(2, c.Window, {
          width: 320,
          height: 30 * d.length + 150,
          children: (0, o.createComponentVNode)(2, c.Window.Content, {
            children: [
              (0, o.createComponentVNode)(2, a.Section, {
                children: (0, o.createComponentVNode)(2, a.LabeledList, {
                  children: d.map(function (e) {
                    return (0, o.createComponentVNode)(
                      2,
                      a.LabeledList.Item,
                      {
                        className: "candystripe",
                        label: e.color,
                        labelColor: e.color,
                        color: e.color,
                        buttons: (0, o.createFragment)(
                          [
                            (0, o.createComponentVNode)(2, a.Button, {
                              content: e.cut ? "Mend" : "Cut",
                              onClick: function () {
                                return i("cut", { wire: e.color });
                              },
                            }),
                            (0, o.createComponentVNode)(2, a.Button, {
                              content: "Pulse",
                              onClick: function () {
                                return i("pulse", { wire: e.color });
                              },
                            }),
                            (0, o.createComponentVNode)(2, a.Button, {
                              content: e.attached ? "Detach" : "Attach",
                              onClick: function () {
                                return i("attach", { wire: e.color });
                              },
                            }),
                          ],
                          4
                        ),
                        children:
                          !!e.wire &&
                          (0, o.createVNode)(
                            1,
                            "i",
                            null,
                            [
                              (0, o.createTextVNode)("("),
                              e.wire,
                              (0, o.createTextVNode)(")"),
                            ],
                            0
                          ),
                      },
                      e.color
                    );
                  }),
                }),
              }),
              !!u.length &&
                (0, o.createComponentVNode)(2, a.Section, {
                  children: u.map(function (e) {
                    return (0,
                    o.createComponentVNode)(2, a.Box, { children: e }, e);
                  }),
                }),
            ],
          }),
        });
      };
    },
  ])
);
