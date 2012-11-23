#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
sys.setdefaultencoding('utf-8')


#
# Automatically start the debugger on an exception.
#
# http://code.activestate.com/recipes/65287-automatically-start-the-debugger-on-an-exception/
#
# When Python runs a script and an uncatched exception is raised,
# a traceback is printed and the script is terminated.
# Python2.1 has introduced sys.excepthook,
# which can be used to override the handling of uncaught exceptions.
# This allows to automatically start the debugger on an unexpected exception,
# even if python is not running in interactive mode.
#
# How to use:
#   The debugger is only started when python is run in non-interactive mode.
#   If you do not use it, should run python scripts with -O option,
#   Because constant variable `__debug__` is `1` by default.
#
# Note:
#   Sometimes sys.excepthook gets redefined by other modules,
#   for instance if you are using IPython embedded shell.
#   In this case, insert following after all the imports in your script
#
#     from sitecustomize import info sys.excepthook=info
#
def info(type, value, tb):
    if hasattr(sys, 'ps1') or not sys.stderr.isatty() or \
            not sys.stdin.isatty() or not sys.stdout.isatty() or \
            type == SyntaxError:  # there is nothing to be done on syntax errors
        # we are in interactive mode or we don't have a tty-like
        # device, so we call the default hook
        sys.__excepthook__(type, value, tb)
    else:
        import traceback
        import pdb
        # we are NOT in interactive mode, print the exception...
        traceback.print_exception(type, value, tb)
        print
        # ...then start the debugger in post-mortem mode.
        pdb.pm()


if __debug__:
    #sys.excepthook = info
    pass
