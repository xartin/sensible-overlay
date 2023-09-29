# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs unpacker

DESCRIPTION="torguard anonymous VPN - NOT related to TOR project"
HOMEPAGE="https://torguard.net"
SRC_URI="https://updates.torguard.biz/Software/Linux/torguard-v${PV}-amd64-arch.tar.gz -> ${P}.tar.gz
		x86?	( https://updates.torguard.biz/Software/Linux/torguard-v${PV}-i386-arch.tar.gz -> ${P}.tar.gz )"

#BUILD="build.206.2+gb3ec8fb"
#_FULL_VERSION="${PV}-${BUILD}"

LICENSE="custom"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror bindist"
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

src_prepare() {
	default
	# We are not using the bundled libs
	sed -i 's/^export.*$//' "${S}/opt/${PN}/bin/${PN}-wrapper"
}

src_install() {
        # Create default library folder with correct permissions
        keepdir /opt/torguard
        fowners torguard:torguard /opt/torguard
	insinto /opt/${PN}/bin/
	
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
