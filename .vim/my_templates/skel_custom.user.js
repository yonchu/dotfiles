// ==UserScript==
// @name
// @namespace      http://d.hatena.ne.jp/yonchu
// @version        0.0.1
// @description
// @include
// @exclude
// @license        MIT License(http://en.wikipedia.org/wiki/MIT_License)
// @see            http://d.hatena.ne.jp/yonchu/
// ==/UserScript==
// Version History:
//   0.0.1 - 20xx/xx/xx release

(function() {
  // Greasemonkey Manual:API
  //  http://wiki.greasespot.net/API_reference

  //-------------------------------------------------------------------------
  // AutoPagerizeでループする部分(検索結果とか)の処理
  //-------------------------------------------------------------------------
  // AutoPagerize対応
  if( window.AutoPagerize ) {
    // AutoPagerizeにて読み込み完了時に、引数のメソッドが呼ばれる
    window.AutoPagerize.addFilter(
      function( doms ) {
        for( var i=0; i<doms.length; i++ ) {
          loop(dom[i]);
        }
      }
     )
  }

  loop(document);

  function loop(dom){
  }


  //-------------------------------------------------------------------------
  // common
  //-------------------------------------------------------------------------

  // htmlテキストをDOMにコンバート
  function convertToHTMLDocument(html) {
    var xsl = (new DOMParser()).parseFromString(
    '<?xml version="1.0"?>\
      <stylesheet version="1.0" xmlns="http://www.w3.org/1999/XSL/Transform">\
      <output method="html"/>\
     </stylesheet>', "text/xml");

    var xsltp = new XSLTProcessor();
    xsltp.importStylesheet(xsl);

    var doc = xsltp.transformToDocument(document.implementation.createDocument("", "", null));
    doc.appendChild(doc.createElement("html"));

    var range = doc.createRange();
    range.selectNodeContents(doc.documentElement);
    doc.documentElement.appendChild(range.createContextualFragment(html));

    return doc;
  }

  // CSSを追加
  function addStyle(css) {
    if (typeof GM_addStyle != 'undefined') {
      GM_addStyle(css);
      return;
    }
    var head = document.getElementsByTagName('head')[0];
    var style = document.createElement("style");
    style.type = "text/css";
    style.appendChild(document.createTextNode(css));
    head.appendChild(style);
  }

  // CSSセレクトで指定したノードのNodeListを取得
  function(name) {
    return document.querySelector(name);
  }

  // DOM取得系
  function I(id) {
    return document.getElementById(id);
  }

  function $T(tab, dom) {
    if( !dom || dom == undefined ) {
      $T( tab, document );
    }
    return dom.getElementsByTagName(tab);
  }

  function $C(class, dom) {
    if( !dom || dom == undefined ) {
      $C( class, document );
    }

    var retnode = [];
    var myclass = new RegExp('\\b'+class+'\\b');
    var elem = dom.getElementsByTagName('*');
    for (var i = 0; i < elem.length; i++) {
      var classes = elem[i].className;
      if (myclass.test(classes)) retnode.push(elem[i]);
    }
    return retnode;
  }

  // firebugにログ出力
  function log( str ) {
    if( console ) {
      console.log( str );
    }
  }

  // firebugにエラー出力
  function err( str ) {
    if( console ) {
      console.error( str );
    } else {
      alert( str );
    }
  }

  // ロード中のgifアニメ
  var loadingImg =
    'data:image/gif;base64,'+
    'R0lGODlhEAAQAPIAAP///wAAAMLCwkJCQgAAAGJiYoKCgpKSkiH5BAAKAAAAIf4VTWFkZSBieSBB'+
    'amF4TG9hZC5pbmZvACH/C05FVFNDQVBFMi4wAwEAAAAsAAAAABAAEAAAAzMIutz+MMpJaxNjCDoI'+
    'GZwHTphmCUWxMcK6FJnBti5gxMJx0C1bGDndpgc5GAwHSmvnSAAAIfkEAAoAAAAsAAAAABAAEAAA'+
    'AzQIutz+TowhIBuEDLuw5opEcUJRVGAxGSBgTEVbGqh8HLV13+1hGAeAINcY4oZDGbIlJCoSACH5'+
    'BAAKAAAALAAAAAAQABAAAAM2CLoyIyvKQciQzJRWLwaFYxwO9BlO8UlCYZircBzwCsyzvRzGqCsC'+
    'We0X/AGDww8yqWQan78EACH5BAAKAAAALAAAAAAQABAAAAMzCLpiJSvKMoaR7JxWX4WLpgmFIQwE'+
    'MUSHYRwRqkaCsNEfA2JSXfM9HzA4LBqPyKRyOUwAACH5BAAKAAAALAAAAAAQABAAAAMyCLpyJytK'+
    '52QU8BjzTIEMJnbDYFxiVJSFhLkeaFlCKc/KQBADHuk8H8MmLBqPyKRSkgAAIfkEAAoAAAAsAAAA'+
    'ABAAEAAAAzMIuiDCkDkX43TnvNqeMBnHHOAhLkK2ncpXrKIxDAYLFHNhu7A195UBgTCwCYm7n20p'+
    'SgAAIfkEAAoAAAAsAAAAABAAEAAAAzIIutz+8AkR2ZxVXZoB7tpxcJVgiN1hnN00loVBRsUwFJBg'+
    'm7YBDQTCQBCbMYDC1s6RAAAh+QQACgAAACwAAAAAEAAQAAADMgi63P4wykmrZULUnCnXHggIwyCO'+
    'x3EOBDEwqcqwrlAYwmEYB1bapQIgdWIYgp5bEZAAADs=';

  // 上と同じサイズの透明なGIF
  var noImg = 'data:image/gif;base64,'+
    'R0lGODlhAQABAPcAALGVfrGVfgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAEALAAAAAABAAEA'+
    'AAgEAAMEBAA7';
})();
