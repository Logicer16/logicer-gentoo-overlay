EAPI=6

DESCRIPTION="A greeter for LightDM using webkit"
HOMEPAGE="https://github.com/Antergos/web-greeter"
if [[ ${PV} == 9999 ]]; then
  inherit git-r3
  EGIT_REPO_URI="https://github.com/Antergos/web-greeter.git"
  EGIT_BRANCH="stable"
else
  SRC_URI="https://github.com/Antergos/web-greeter/archive/refs/tags/${PV}.tar.gz"
  # S="${WORKDIR}/web-greeter-${PV}"
  KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-libs/dbus-glib
  x11-libs/gtk+
  net-libs/webkit-gtk
  x11-misc/lightdm"
DEPEND="${RDEPEND}
  dev-util/meson"

src_compile() {
  meson --prefix=/usr --libdir=lib ..
  ninja
}

src_install() {
  ninja install

  if ! declare -p DOCS >/dev/null 2>&1 ; then
    local d
    for d in README* ChangeLog AUTHORS NEWS TODO CHANGES THANKS BUGS \
        FAQ CREDITS CHANGELOG ; do
      [[ -s "${d}" ]] && dodoc "${d}"
    done
  elif [[ $(declare -p DOCS) == "declare -a"* ]] ; then
    dodoc "${DOCS[@]}"
  else
    dodoc ${DOCS}
  fi
}

