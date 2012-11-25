# -*- coding: utf-8 -*-

# from __future__ import print_function

import sys
import os
import io
import itertools
import functools
import re

try:
    from see import see
except ImportError:
    pass

# debug
#try:
    #from sitecustomize import info
    #sys.excepthook = info
    #print
    #print 'Set excepthook for automatically debug.'
#except ImportError:
    #print
    #print 'Could not set excepthook for automatically debug.'
    #pass

# inspect
#   http://d.hatena.ne.jp/maedana/20070919/1190206853
import inspect
igd = inspect.getdoc
igs = inspect.getsource
igf = inspect.getfile
igsl = inspect.getsourcelines

# http://www.ianlewis.org/jp/ipython-virtualenv
#import site
#if 'VIRTUAL_ENV' in os.environ:
    #virtual_env = os.path.join(os.environ.get('VIRTUAL_ENV'),
                               #'lib',
                               #'python%d.%d' % sys.version_info[:2],
                               #'site-packages')
    #site.addsitedir(virtual_env)
    #print 'VIRTUAL_ENV ->', virtual_env
    #del virtual_env
#del site

# http://methane.hatenablog.jp/entry/20120422/1335110487
#def _load_venv():
    #import os
    #if 'VIRTUAL_ENV' in os.environ:
        #activate_this = os.path.join(os.environ['VIRTUAL_ENV'], 'bin/activate_this.py')
        #with open(activate_this) as f:
            #exec(f.read(), dict(__file__=activate_this))

#_load_venv()
#del _load_venv
