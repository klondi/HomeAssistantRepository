# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="API package for rememberthemilk.com"
HOMEPAGE="https://bitbucket.org/rtmapi/rtmapi https://pypi.org/project/RtmAPI/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README"

RDEPEND=">=dev-python/httplib2-0.6.0[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

PATCHES=( "${FILESDIR}/RtmAPI-0.7.2-2to3.patch" )

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
