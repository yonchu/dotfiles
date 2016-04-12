let g:user_zen_removetag_key = ''
let g:use_zen_complete_tag = 1
let g:user_zen_settings = {
      \  'lang' : 'ja',
      \  'html' : {
      \    'filters' : 'html',
      \    'snippets' : {
      \      'jq' : "<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js\"></script>\n<script>\n\\$(function() {\n\t|\n})()\n</script>",
      \      'cd' : "<![CDATA[|]]>",
      \    },
      \  },
      \  'perl' : {
      \    'aliases' : {
      \      'req' : "require '|'"
      \    },
      \    'snippets' : {
      \      'use' : "use strict\nuse warnings\n\n",
      \      'w' : "warn \"${cursor}\";",
      \    },
      \  },
      \  'php' : {
      \    'extends' : 'html',
      \    'filters' : 'html,c',
      \  },
      \  'javascript' : {
      \    'snippets' : {
      \      'jq' : "\\$(function() {\n\t\\${cursor}\\${child}\n});",
      \      'jq:json' : "\\$.getJSON(\"${cursor}\", function(data) {\n\t\\${child}\n});",
      \      'jq:each' : "\\$.each(data, function(index, item) {\n\t\\${child}\n});",
      \      'fn' : "(function() {\n\t\\${cursor}\n})();",
      \      'tm' : "setTimeout(function() {\n\t\\${cursor}\n}, 100);",
      \    },
      \    'use_pipe_for_cursor' : 0,
      \  },
      \  'css' : {
      \    'filters' : 'fc',
      \    'snippets' : {
      \      'box-shadow' : "-webkit-box-shadow: 0 0 0 # 000;\n-moz-box-shadow: 0 0 0 0 # 000;\nbox-shadow: 0 0 0 # 000;",
      \    },
      \  },
      \  'less' : {
      \    'filters' : 'fc',
      \    'extends' : 'css',
      \  },
      \ 'java' : {
      \  'snippets' : {
      \   'main': "public static void main(String[] args) {\n\t|\n}",
      \   'println': "System.out.println(\"|\");",
      \   'class': "public class | {\n}\n",
      \  },
      \ },
      \ }
