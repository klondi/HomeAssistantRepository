# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="a library for controlling certain robot vacuums"
HOMEPAGE="https://github.com/wpietri/sucks https://pypi.org/project/sucks/"
SRC_URI="https://github.com/wpietri/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"
RESTRICT="!test? ( test )"

#DOCS="README.rst"

RDEPEND=">=dev-python/sleekxmppfs-1.3.4[${PYTHON_USEDEP}]
	>=dev-python/click-6[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.4[${PYTHON_USEDEP}]
	>=dev-python/pycountry-convert-0.5[${PYTHON_USEDEP}]
	>=dev-python/stringcase-1.2[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		>=dev-python/mock-1.3[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
