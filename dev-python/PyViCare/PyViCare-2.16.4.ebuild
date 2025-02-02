# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Library to communicate with the Viessmann ViCare API"
HOMEPAGE="https://github.com/somm15/PyViCare https://pypi.org/project/PyViCare/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND=">=dev-python/requests-oauthlib-1.1.0[${PYTHON_USEDEP}]
	dev-python/pkce[${PYTHON_USEDEP}]"
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

src_prepare() {
	sed -i "s/setuptools-git-versioning<1.8.0//g" -i setup.py || die
	eapply_user
}

distutils_enable_tests pytest
