# Copyright 2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib

AMD64_AT="AMD-APP-SDK-v${PV}-lnx64.tgz"

MY_P="AMD-APP-SDK-v${PV}-RC-lnx64"

DESCRIPTION="AMD Accelerated Parallel Processing (APP) SDK"
HOMEPAGE="http://developer.amd.com/tools/heterogeneous-computing/\
amd-accelerated-parallel-processing-app-sdk"
SRC_URI="amd64? ( ${AMD64_AT} )"
LICENSE="AMD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-admin/eselect-opencl"
DEPEND="
	${RDEPEND}"

RESTRICT="mirror strip"

AMDAPPDIR="/opt/AMDAPP"
AMD_CL="usr/$(get_libdir)/OpenCL/vendors/amd/"

QA_PREBUILT="${AMDAPPDIR}/*"
S="${WORKDIR}"

pkg_nofetch() {
	einfo "AMD doesn't provide direct download links. Please download"
	einfo "${ARCHIVE} from ${HOMEPAGE}"
}

src_unpack() {
	default
	unpack ./${MY_P}.tgz
	unpack ./icd-registration.tgz
}

src_install() {
	doins -r etc

	insinto "${AMDAPPDIR}"

	doins -r ${MY_P}/*
	fperms 755 "${AMDAPPDIR}"/bin/`arch`/clinfo

	dosym "${AMDAPPDIR}"/bin/`arch`/clinfo /opt/bin/clinfo

	dosym "${AMDAPPDIR}"/include/CL ${AMD_CL}/include/CL
	dosym "${AMDAPPDIR}"/lib/`arch`/libOpenCL.so.1 ${AMD_CL}/libOpenCL.so.1
	dosym libOpenCL.so.1 ${AMD_CL}/libOpenCL.so

}

pkg_postinst() {
	eselect opencl set --use-old amd
}
