# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 qmake-utils eutils

DESCRIPTION="Qt Frontend for Cachegrind"
HOMEPAGE="https://www.kde.org/applications/development/kcachegrind
http://kcachegrind.sourceforge.net"

EGIT_REPO_URI="git://anongit.kde.org/kcachegrind"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
"

RDEPEND="
	media-gfx/graphviz
"

EGIT_COMMIT="v${PV}"

src_prepare() {
	eqmake5
}

src_install() {
	dobin qcachegrind/qcachegrind
	domenu qcachegrind/qcachegrind.desktop
	newicon -s 32 kcachegrind/hi32-app-kcachegrind.png kcachegrind.png
	newicon -s 48 kcachegrind/hi48-app-kcachegrind.png kcachegrind.png
}
