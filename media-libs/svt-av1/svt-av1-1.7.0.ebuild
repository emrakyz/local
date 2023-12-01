EAPI=8

inherit cmake-multilib flag-o-matic

DESCRIPTION="Scalable Video Technology for AV1 (SVT-AV1 Encoder and Decoder)"
HOMEPAGE="https://gitlab.com/AOMediaCodec/SVT-AV1"

if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/AOMediaCodec/SVT-AV1.git"
else
	SRC_URI="https://gitlab.com/AOMediaCodec/SVT-AV1/-/archive/v${PV}/SVT-AV1-v${PV}.tar.bz2"
	KEYWORDS="amd64 arm arm64 ~hppa ~ia64 ~loong ~mips ~ppc ppc64 ~riscv sparc x86"
	S="${WORKDIR}/SVT-AV1-v${PV}"
fi

LICENSE="BSD-2 Apache-2.0 BSD ISC LGPL-2.1+ MIT"
SLOT="0"

BDEPEND="amd64? ( dev-lang/yasm )"

multilib_src_configure() {
	append-ldflags -Wl,-z,noexecstack

	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DCMAKE_OUTPUT_DIRECTORY="${BUILD_DIR}"
	)

	[[ ${ABI} != amd64 ]] && mycmakeargs+=( -DCOMPILE_C_ONLY=ON )

	cmake_src_configure
}
