# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit systemd


SRC_URI="https://github.com/Lusitaniae/apache_exporter/releases/download/v${PV}/apache_exporter-${PV}.linux-amd64.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
DESCRIPTION="Prometheus exporter for apache metrics"
HOMEPAGE="https://github.com/Lusitaniae/apache_exporter"
LICENSE="MIT"
SLOT="0"
RESTRICT="bindist strip test"
IUSE=""

DEPEND=">=dev-lang/go-1.12
	>=dev-util/promu-0.5.0"

RDEPEND="acct-user/apache_exporter"

MY_PN=apache_exporter
S="${WORKDIR}/${MY_PN}"

src_install() {
	dobin apache_exporter/apache_exporter
	dodoc README.md
	systemd_dounit "${FILESDIR}/${PN}.service"
	insinto /etc/sysconfig
	newins "${FILESDIR}/sysconfig.apache_exporter" apache_exporter
	popd || die
	keepdir /var/log/apache_exporter
	fowners apache_exporter:apache_exporter /var/log/apache_exporter
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}
