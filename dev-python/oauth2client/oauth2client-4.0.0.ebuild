# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Library for accessing resources protected by OAuth 2.0"
HOMEPAGE="https://github.com/google/oauth2client"
SRC_URI="https://github.com/google/oauth2client/archive/v${PV/_p/-post}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"
RESTRICT="!test? ( test )"
REQUIRED_USE="|| ( $(python_gen_useflags 'python*') )"

RDEPEND="
	>=dev-python/httplib2-0.9.1[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.1.7[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.0.5[${PYTHON_USEDEP}]
	>=dev-python/rsa-3.1.4[${PYTHON_USEDEP}]
	>=dev-python/six-1.6.1[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/keyring[${PYTHON_USEDEP}]' 'python*')
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
"

S="${WORKDIR}"/${P/_p/-post}

src_prepare() {
	# and it tries to install a 'tests' package at top level.... tsss...
	sed -i "s/packages=find_packages()/packages=find_packages(exclude=['tests','tests.*'])/g" -i setup.py || die
	eapply_user

}

python_prepare() {
	# keyring is not fuly supported by pypy yet, because dbus-python can't support pypy
	# oauth2client -> keyring -> secretstorage -> dbus-python
	# https://github.com/mitya57/secretstorage/issues/10
	case $PYTHON in
		pypy|*pypy|*pypy3) \
			find "${BUILD_DIR}/.." -name '*keyring*py' -delete ;;
	esac
}

python_test() {
	nosetests -e appengine -e django_util -e test_multiprocess_file_storage -e test_bad_positional || die
	# appengine - requires appengine
	# django_util - requires django
	# test_multiprocess_file_storage - requires fasteners
	# test_bad_positional - expects TypeError, gets ValueError
}
