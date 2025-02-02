# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="An API for the homematicip cloud"
HOMEPAGE="https://github.com/coreGreenberet/homematicip-rest-api https://pypi.org/project/homematicip/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.rst"

RDEPEND=">=dev-python/requests-2.24.0[${PYTHON_USEDEP}]
		>=dev-python/websocket-client-0.57.0[${PYTHON_USEDEP}]
		>=dev-python/websockets-8.1[${PYTHON_USEDEP}]
		>=dev-python/aiohttp-3.6.2[${PYTHON_USEDEP}]
		>=dev-python/async-timeout-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/aenum-2.2.4[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
