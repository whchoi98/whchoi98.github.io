/* whchoi98.github.io - 테마 토글 / 홈 검색 / 태그 필터 / 글 목차 */
(function () {
  "use strict";

  /* ---------- 테마 ---------- */
  document.querySelectorAll("[data-theme-pick]").forEach(function (btn) {
    btn.addEventListener("click", function () {
      var t = btn.getAttribute("data-theme-pick");
      document.documentElement.classList.toggle("dark", t === "dark");
      try { localStorage.setItem("whchoi98-blog-theme", t); } catch (e) {}
    });
  });

  /* ---------- 언어 (한/EN) ---------- */
  document.querySelectorAll("[data-lang-pick]").forEach(function (btn) {
    btn.addEventListener("click", function () {
      var l = btn.getAttribute("data-lang-pick");
      document.documentElement.classList.toggle("lang-en", l === "en");
      try { localStorage.setItem("whchoi98-blog-lang", l); } catch (e) {}
      var search = document.getElementById("home-search");
      if (search) search.placeholder = l === "en" ? "Search - title, tags" : "검색 - 제목, 태그";
      document.dispatchEvent(new CustomEvent("langchange", { detail: { lang: l } }));
    });
  });
  if (document.documentElement.classList.contains("lang-en")) {
    var s0 = document.getElementById("home-search");
    if (s0) s0.placeholder = "Search - title, tags";
  }

  /* ---------- 홈 검색 ---------- */
  function isEn() { return document.documentElement.classList.contains("lang-en"); }
  var search = document.getElementById("home-search");
  var list = document.getElementById("post-list");
  if (search && list) {
    var cards = Array.prototype.slice.call(list.querySelectorAll(".post-card"));
    var label = document.getElementById("result-label");
    var empty = document.getElementById("no-results");
    var total = window.POST_COUNT || cards.length;
    var applySearch = function () {
      var q = search.value.trim().toLowerCase();
      var shown = 0;
      cards.forEach(function (c) {
        var hit = !q || (c.getAttribute("data-search") || "").toLowerCase().indexOf(q) !== -1;
        c.hidden = !hit;
        if (hit) shown++;
      });
      if (label) {
        label.textContent = isEn()
          ? (q ? shown + " results" : "All " + total + " posts · newest first")
          : (q ? shown + "편 검색됨" : "전체 " + total + "편 · 최신순");
      }
      if (empty) empty.hidden = !(q && shown === 0);
    };
    search.addEventListener("input", applySearch);
    document.addEventListener("langchange", applySearch);
    applySearch();
  }

  /* ---------- 태그 필터 ---------- */
  var chipRow = document.getElementById("tag-chips");
  var tagList = document.getElementById("tag-list");
  if (chipRow && tagList) {
    var tagCards = Array.prototype.slice.call(tagList.querySelectorAll(".post-card"));
    var counts = {};
    tagCards.forEach(function (c) {
      (c.getAttribute("data-tags") || "").split("|").forEach(function (t) {
        if (t) counts[t] = (counts[t] || 0) + 1;
      });
    });
    var names = Object.keys(counts).sort(function (a, b) {
      return counts[b] - counts[a] || a.localeCompare(b);
    });
    var heading = document.getElementById("tag-heading");
    var current = null;

    function apply(tag) {
      current = tag;
      var shown = 0;
      tagCards.forEach(function (c) {
        var tags = (c.getAttribute("data-tags") || "").split("|");
        var hit = !tag || tags.indexOf(tag) !== -1;
        c.hidden = !hit;
        if (hit) shown++;
      });
      var en = document.documentElement.classList.contains("lang-en");
      if (heading) {
        heading.textContent = en
          ? (tag ? shown + ' posts tagged "' + tag + '"' : "All " + tagCards.length + " posts · " + names.length + " tags")
          : (tag ? '"' + tag + '" 태그의 글 ' + shown + "편" : "전체 " + tagCards.length + "편 · " + names.length + "개 태그");
      }
      chipRow.querySelectorAll(".chip-lg").forEach(function (b) {
        b.classList.toggle("active", (b.getAttribute("data-tag") || null) === tag);
      });
      try {
        var url = tag ? "?tag=" + encodeURIComponent(tag) : location.pathname;
        history.replaceState(null, "", url);
      } catch (e) {}
    }

    function chip(labelText, tag) {
      var b = document.createElement("button");
      b.type = "button";
      b.className = "chip-lg";
      b.textContent = labelText;
      if (tag) b.setAttribute("data-tag", tag);
      b.addEventListener("click", function () { apply(tag); });
      return b;
    }

    chipRow.appendChild(chip("전체 " + tagCards.length, null));
    names.forEach(function (n) { chipRow.appendChild(chip(n + " " + counts[n], n)); });

    tagList.querySelectorAll(".chip-btn").forEach(function (b) {
      b.addEventListener("click", function () { apply(b.getAttribute("data-tag")); });
    });

    var q = new URLSearchParams(location.search).get("tag");
    apply(q && counts[q] ? q : null);

    document.addEventListener("langchange", function () {
      var first = chipRow.querySelector(".chip-lg");
      if (first) first.textContent = (document.documentElement.classList.contains("lang-en") ? "All " : "전체 ") + tagCards.length;
      apply(current);
    });
  }

  /* ---------- Mac 터미널 코드블록 (article 내 pre 장식 + 복사) ---------- */
  Array.prototype.forEach.call(document.querySelectorAll(".article pre"), function (pre) {
    if (pre.closest(".term-box")) return;
    var code = pre.querySelector("code") || pre;
    var box = document.createElement("div");
    box.className = "term-box";
    var head = document.createElement("div");
    head.className = "term-head";
    var dots = document.createElement("span");
    dots.className = "mac-dots";
    dots.setAttribute("aria-hidden", "true");
    for (var di = 0; di < 3; di++) dots.appendChild(document.createElement("i"));
    var spacer = document.createElement("span");
    spacer.className = "term-spacer";
    head.appendChild(dots);
    head.appendChild(spacer);
    var btn = document.createElement("button");
    btn.type = "button";
    btn.className = "term-copy";
    function label(base) {
      var en = document.documentElement.classList.contains("lang-en");
      return en ? (base === "idle" ? "Copy" : "Copied") : (base === "idle" ? "복사" : "복사됨");
    }
    btn.textContent = label("idle");
    document.addEventListener("langchange", function () { if (!btn.classList.contains("copied")) btn.textContent = label("idle"); });
    btn.addEventListener("click", function () {
      var t = code.textContent;
      function done() {
        btn.textContent = label("done");
        btn.classList.add("copied");
        setTimeout(function () { btn.textContent = label("idle"); btn.classList.remove("copied"); }, 1600);
      }
      function fallback() {
        var ta = document.createElement("textarea");
        ta.value = t; ta.style.position = "fixed"; ta.style.opacity = "0";
        document.body.appendChild(ta); ta.select();
        try { document.execCommand("copy"); done(); } catch (e) {}
        document.body.removeChild(ta);
      }
      if (navigator.clipboard && navigator.clipboard.writeText) navigator.clipboard.writeText(t).then(done).catch(fallback);
      else fallback();
    });
    head.appendChild(btn);
    pre.parentNode.insertBefore(box, pre);
    box.appendChild(head);
    box.appendChild(pre);
  });

  /* ---------- 조회수 (GoatCounter public counter) ---------- */
  var vc = document.querySelector("[data-views]");
  if (vc) {
    var code = vc.getAttribute("data-goat-code");
    var path = location.pathname;
    fetch("https://" + code + ".goatcounter.com/counter/" + encodeURIComponent(path) + ".json")
      .then(function (r) { if (!r.ok) throw new Error(r.status); return r.json(); })
      .then(function (d) {
        var raw = String(d.count || "").replace(/[\s\u2009\u202f]/g, "");
        var n = parseInt(raw, 10);
        if (!isFinite(n)) return;
        var txt = n.toLocaleString("en-US");
        Array.prototype.forEach.call(vc.querySelectorAll("[data-views-n]"), function (el) {
          el.textContent = txt;
        });
        vc.hidden = false;
      })
      .catch(function () { /* 계정 미생성/미공개/네트워크 실패 시 숨김 유지 */ });
  }

  /* ---------- 글 목차 (h2 스크롤 스파이) ---------- */
  var article = document.getElementById("article");
  var tocAside = document.getElementById("toc-aside");
  var tocNav = document.getElementById("toc-nav");
  if (article && tocAside && tocNav) {
    var heads = Array.prototype.slice.call(article.querySelectorAll("h2"));
    heads = heads.filter(function (h) { return h.id; });
    if (heads.length >= 2) {
      tocAside.hidden = false;
      var links = heads.map(function (h) {
        var a = document.createElement("a");
        a.href = "#" + h.id;
        a.textContent = h.textContent;
        tocNav.appendChild(a);
        return a;
      });
      var raf = null;
      function onScroll() {
        if (raf) return;
        raf = requestAnimationFrame(function () {
          raf = null;
          var active = 0;
          heads.forEach(function (h, i) {
            if (h.getBoundingClientRect().top <= 130) active = i;
          });
          links.forEach(function (a, i) { a.classList.toggle("active", i === active); });
        });
      }
      window.addEventListener("scroll", onScroll, { passive: true });
      onScroll();
    }
  }
})();
