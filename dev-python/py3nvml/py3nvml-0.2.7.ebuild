# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )
inherit distutils-r1

DESCRIPTION="Python 3 Bindings for the NVIDIA Management Library"
HOMEPAGE="
		https://pypi.org/project/py3nvml/
		https://github.com/fbcotter/py3nvml
"
SRC_URI="https://github.com/fbcotter/${PN}/archive/refs/tags/${PV}.tar.gz"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"
