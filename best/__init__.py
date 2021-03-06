"""
.. module:: best
    :platform: Unix, Windows
    :synopsis: Implementation of various Bayesian algorithms for
    uncertainty propagation and stochastic inverse problems.

.. moduleauthor:: Ilias Bilionis <ebilionis@gmail.com>

The purpose of BEST is to serve as a platform for the development of fully
Bayesian algorithms to be applied in uncertainty propagation and stochastic
inverse problems.

Dependencies
------------
The package depends on the following external libraries:
    * Numpy
    * Scipy
    * mpi4py

Modules
-------
BEST is split in several (mostly) independent submodules:
    * :ref:`Linear Algebra <best.linalg>`
        Some linear algebra routines

"""


__all__ = ['Object', 'core', 'misc', 'domain', 'maps', 'linalg',
           'random', 'rvm', 'gp', 'design', 'uq', 'inverse', 'smc']


from ._basic_objects import *

from . import core
from . import misc # Fix
from . import domain # Fix
from . import linalg
from . import maps # Fix
from . import random # Fix
from . import gpc
from . import rvm
from . import gp # Fix
from . import design
from . import uq # Fix
from . import inverse # Fix
from . import smc
