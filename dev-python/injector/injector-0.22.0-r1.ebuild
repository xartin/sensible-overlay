# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )
inherit distutils-r1

DESCRIPTION="Python dependency injection framework"
HOMEPAGE="
		https://pypi.org/project/injector/
		https://github.com/alecthomas/injector
"
SRC_URI="https://github.com/python-injector/${PN}/archive/refs/tags/${PV}.tar.gz"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

DEPEND="dev-python/typing-extensions[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
