EAPI="4"

inherit eutils unpacker

MY_TAG="2_3_0_035"

DESCRIPTION="Vidyo Endpoint Application"
HOMEPAGE="http://www.vidyo.com"
SRC_URI="amd64? ( https://information-technology.web.cern.ch/sites/information-technology.web.cern.ch/files/VidyoDesktopInstaller-ubuntu64-TAG_VD_${MY_TAG}.deb )
		 x86? ( https://information-technology.web.cern.ch/sites/information-technology.web.cern.ch/files/VidyoDesktopInstaller-ubuntu-TAG_VD_${MY_TAG}.deb )"

LICENSE="vidyodesktop"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="fetch strip"

RDEPEND="net-dns/libidn
		 x11-libs/libXv
		 x11-libs/libXext
		 x11-libs/libX11
		 virtual/opengl
		 virtual/glu
		 x11-libs/libXfixes
		 x11-libs/libXrandr
		 media-libs/alsa-lib
		 dev-qt/qtgui
		 dev-qt/qtcore
		 sys-apps/util-linux
		 sys-devel/gcc
		 sys-libs/zlib"

DEPEND="dev-util/patchelf"

pkg_nofetch() {
	einfo "Please download the VidyoDesktopInstaller"
	einfo "(VidyoDesktopInstaller-ubuntu64-TAG_VD_${MY_TAG}.deb) from"
	einfo "https://information-technology.web.cern.ch/services/fe/downloads/Vidyo"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	unpack_deb ${A}
	#ubuntu hack not needed anymore
	#for file in Makefile totally_ubuntu.c; do
	#	cp ${FILESDIR}/${file} . || die "cannot cp ${FILESDIR}/${file}"
	#done
}

src_prepare() {
	local x="opt/vidyo/VidyoDesktop/VidyoDesktop"
	patchelf --set-rpath '$ORIGIN' "${x}" || \
		die "patchelf failed on ${x}"
}

S=${WORKDIR}

QA_PREBUILT="opt/vidyo/VidyoDesktop/VidyoDesktop"

src_install() {
	exeinto /opt/vidyo/VidyoDesktop
	doexe opt/vidyo/VidyoDesktop/VidyoDesktop || die

	insinto /opt/vidyo/VidyoDesktop
	#ubuntu hack not needed anymore
	#doins totally_ubuntu.so || die
	#doins ${FILESDIR}/ubuntu-lsb-release || die
	doins usr/share/pixmaps/vidyo_icon.png || die

	exeinto /opt/bin
	newexe ${FILESDIR}/VidyoDesktop_nopreload VidyoDesktop || die

	make_desktop_entry VidyoDesktop VidyoDesktop /opt/vidyo/VidyoDesktop/vidyo_icon.png
}
