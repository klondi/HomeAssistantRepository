# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Modern password hashing for software and servers"
HOMEPAGE="https://github.com/pyca/bcrypt/ https://pypi.org/project/bcrypt/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="amd64 ~arm ~arm64 x86 amd64-linux x86-linux"
IUSE="test"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	>=dev-python/cffi-1.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]"
DEPEND="${COMMON_DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/pytest-3.2.1[${PYTHON_USEDEP}] )"
RDEPEND="${COMMON_DEPEND}"

python_test() {
	esetup.py test
}
