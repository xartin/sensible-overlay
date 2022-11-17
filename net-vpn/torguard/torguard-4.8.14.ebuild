# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="torguard anonymous VPN - NOT related to TOR project"
HOMEPAGE="https://torguard.net"
SRC_URI="https://updates.torguard.biz/Software/Linux/torguard-v${PV}-amd64-arch.tar.gz -> ${P}.tar.gz
		x86?	( https://updates.torguard.biz/Software/Linux/torguard-v${PV}-i386-arch.tar.gz -> ${P}.tar.gz )"

LICENSE="custom"
SLOT="0"
# KEYWORDS="~amd64 ~x86"
KEYWORDS="~amd64"
IUSE="sudo"
RDEPEND="acct-user/torguard
		acct-group/torguard
		sys-apps/iproute2
		net-vpn/openvpn[iproute2]
		net-vpn/wireguard-tools[wg-quick]
		net-misc/stunnel
		dev-qt/qtwidgets
		sys-process/psmisc
		dev-qt/qtnetwork[libproxy]
		net-proxy/shadowsocks-libev
		sudo? ( lxqt-base/lxqt-sudo )"
DEPEND="${RDEPEND}"

# S=${WORKDIR}/${PN}-v${PV}-amd64-arch
S="${WORKDIR}/${PN}-v${PV}-amd64-arch/${PN}-v${PV}-amd64-arch"
# S=${WORKDIR}/${PN}-v${PV}-amd64-arch

src_unpack() {
	default
	# cd "${S}" || die "Couldn't cd into the source directory ${S}"
	cd "${WORKDIR}/${PN}-v${PV}-amd64-arch" || die "Couldn't cd into the source directory ${S}"
	# TODO: fix x86 installation :(
	# tar xpf ${PN}-v${PV}-amd64-arch.tar.gz || die "tar failed"
	unpack ./${PN}-v${PV}-amd64-arch.tar.gz || die "tar failed"
}

src_prepare() {
	default
	# We are not using the bundled libs
	sed -i 's/^export.*$//' "${S}/opt/${PN}/bin/${PN}-wrapper"
}

src_install() {
	doins -r "${S}/usr"
	newbin "${S}/opt/${PN}/bin/${PN}-wrapper" "${PN}"

	insinto /opt/${PN}/bin/
	insopts -m755
	dostrip -x "${EROOT}/opt/${PN}/bin/${PN}" "${EROOT}/opt/${PN}/bin/openconnect"
	doins -r "${S}/opt/${PN}/bin/${PN}"
	doins "${S}/opt/${PN}/bin/openconnect"
	doins "${S}/opt/${PN}/bin/vpnc-script"

	# torguard sysusers conf
	insinto /usr/lib/sysusers.d
	newins "${FILESDIR}/${PN}.sysusers" "${PN}.conf"

	# sudoers file
	insinto /
	insopts -m0440
	doins -r "${S}/etc"

	# Let's use the system implementation of openvpn
	dosym "/usr/sbin/openvpn" "${EROOT}/opt/${PN}/bin/openvpn_v2_5"
	# 20181219 - using the wrapper instead of using the binary directly
	# dosym "${EROOT}/opt/${PN}/bin/${PN}" "${EROOT}/usr/bin/${PN}"
}
