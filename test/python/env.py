#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
import locale
import inspect


print '---- os.environ ----'
for key, value in os.environ.items():
    print '%s=%s' % (key, value)
print

print '---- sys.path ----'
for value in sys.path:
    print value
print

print '---- sys.version ----'
print sys.version
print

print '---- encoding ----'
print 'sys.getdefaultencoding() =', sys.getdefaultencoding()
print 'locale.getpreferredencoding() =', locale.getpreferredencoding()
print 'sys.stdin.encoding =', sys.stdin.encoding
print 'sys.stdout.encoding =', sys.stdout.encoding
print 'sys.stderr.encoding =', sys.stderr.encoding
print

print '---- type ----'
print 'os.environ =', type(os.environ)
print 'class name =', os.environ.__class__
print

print '---- debug ----'
print 'dir(os.environ) =', dir(os.environ)
print

print '---- inspect ----'
# inspect
#   http://d.hatena.ne.jp/maedana/20070919/1190206853
igd = inspect.getdoc
igs = inspect.getsource
igf = inspect.getfile
igsl = inspect.getsourcelines
try:
    print 'getdoc() =', igd(os.environ)
    print 'getsource() =', igs(os.environ)
    print 'getfile() =', igf(os.environ)
    print 'getsourcelines() =', igsl(os.environ)
except:
    print >> sys.stderr,  "\nUnexpected error:", sys.exc_info()[0]
    pass


def setPath(name, value):
    try:
        if name in os.environ:
            if os.environ[name] is not None and os.environ[name] != "":
                os.environ[name] = os.environ[name] + ";" + value
                return True

        os.environ[name] = value
        return True
    except:
        return False
