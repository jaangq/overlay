# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils flag-o-matic

PB=$(echo ${PV} | sed -e "s/\.[^\.]*$//g")

DESCRIPTION="A graphical grub2 settings manager"
HOMEPAGE="https://launchpad.net/grub-customizer"
SRC_URI="https://launchpad.net/${PN}/${PB}/${PV}/+download/${PN}_${PV}.tar.gz"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-cpp/gtkmm:3.0
	  	dev-libs/openssl
	  	x11-themes/hicolor-icon-theme
		sys-boot/grub:2
		app-arch/libarchive"

RDEPEND="${DEPEND}"

src_configure() {
	CMAKE_BUILD_TYPE="release"
	glib_path="/usr/include/"$(ls /usr/include/ | sed -n "/^glib-/p")
	local mycmakeargs=(-DCMAKE_INSTALL_PREFIX=/usr -DEO_SOURCE_DIR:PATH=$glib_path)
	append-cxxflags -I$glib_path
	append-cflags -I$glib_path
	append-cppflags -I$glib_path
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	insinto /etc/grub-customizer
	newins "${FILESDIR}/grub.cfg" grub.cfg
}