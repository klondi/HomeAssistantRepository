# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="A Blink camera Python library running on Python 3."
HOMEPAGE="https://github.com/fronzbot/blinkpy https://pypi.org/project/blinkpy/"
SRC_URI="https://github.com/fronzbot/blinkpy/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.rst"

RDEPEND=">=dev-python/python-dateutil-2.8.1[${PYTHON_USEDEP}]
		 >=dev-python/requests-2.24.0[${PYTHON_USEDEP}]
		 >=dev-python/python-slugify-4.0.1[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/testtools-2.4.0[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
