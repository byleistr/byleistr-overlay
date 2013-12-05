# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4


DESCRIPTION="Switch between optimus and discrete graphics X configuration."

SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="
	app-admin/eselect-opengl
	x11-drivers/nvidia-drivers
	media-libs/mesa
	"
S=${WORKDIR}

src_install() {
	newconfd "${FILESDIR}"/optimus-switch.confd optimus-switch
	newinitd "${FILESDIR}"/optimus-switch.initd optimus-switch
	insinto /etc/optimus-switch
	doins "${FILESDIR}"/xorg.conf.nvidia
}
