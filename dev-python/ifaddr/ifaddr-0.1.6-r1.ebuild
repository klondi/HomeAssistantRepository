# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Enumerates all IP addresses on all network adapters of the system."
HOMEPAGE="https://github.com/pydron/ifaddr"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 x86 amd64-linux x86-linux"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

python_test() {
	py.test -v || die "Tests failed under ${EPYTHON}"
}
