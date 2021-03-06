"""Unit-tests for best.maps.CovarianceFunction.

Author:
    Ilias Bilionis

Date:
    8/15/2013
"""


if __name__ == '__main__':
    import fix_path


import unittest
import numpy as np
import math
from best.maps import *
import scipy.stats as stats
import matplotlib.pyplot as plt


class RBFTest(unittest.TestCase):

    def test_cov(self):
        f = CovarianceFunctionSE(1)
        x = np.linspace(-5, 5, 100)
        X = np.random.randn(10)
        phi = f.to_basis(X, hyp=1.)
        plt.plot(x, phi(x))
        plt.plot(x, f(0, x, hyp=1.).T)
        plt.show()
        plt.plot(x, f.d(0, x, hyp=1.)[:, :, 0].T)
        plt.show()
        plt.plot(x, f.d(0, x, hyp=1.)[:, :, 0].T)
        plt.show()
        x = np.random.randn(10)
        y = np.random.randn(20)
        f.hyp = 1.
        g = CovarianceFunctionSE(1)
        h = f + g
        h.hyp = [1., 1.2]
        print str(h)
        x = np.random.randn(1)
        y = np.linspace(-4, 4, 100)
        fxy = f(x, y, hyp=1.)
        gxy = g(x, y, hyp=1.2)
        hxy = h(x, y)
        dfxy = f.d(x, y, hyp=1.)
        dgxy = g.d(x, y, hyp=1.2)
        dhxy = h.d(x, y)
        q = f * g
        q.hyp = [1., 1.2]
        #plt.plot(y, fxy + gxy)
        #plt.plot(y, hxy)
        #plt.plot(y, dfxy + dgxy)
        plt.plot(y, q.d(x, y))
        plt.show()


if __name__ == '__main__':
    unittest.main()