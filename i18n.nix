{ pkgs, ... }:
{
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = [
    (pkgs.ibus-engines.libpinyin.overrideAttrs (old: {
      # https://github.com/archlinux/svntogit-community/blob/packages/ibus-libpinyin/trunk/PKGBUILD
      configurePhase = "./autogen.sh --prefix=$out --libexecdir=$out/lib/${old.pname} --enable-boost --enable-opencc --enable-cloud-input-mode";
      prePatch = ''substituteInPlace autogen.sh --replace "which" "${pkgs.which}/bin/which"'';
      buildInputs = with pkgs; old.buildInputs ++ [ gnome.gnome-common boost opencc libsoup json-glib lua ];
    }))
  ];

  # i18n.inputMethod.enabled = "fcitx5";
  # i18n.inputMethod.fcitx5.addons = [ pkgs.fcitx5-chinese-addons ];
}
