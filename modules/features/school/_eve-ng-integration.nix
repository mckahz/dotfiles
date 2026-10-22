{
  appimageTools,
  dpkg,
  lib,
  libpng,
  libxkbfile,
  requireFile,
  stdenvNoCC,
  version ? "9.0.1",
}:

let
  appimage = stdenvNoCC.mkDerivation {
    pname = "eve-ng-integration-image";
    inherit version;

    src =
      let
        sources = {
          "0.5.0" = {
            name = "eve-ng-integration_0.5.0-0~80~ubuntu26.10.1_all.deb";
            # Use the following command to generate the hash for the .deb file
            # openssl dgst -sha256 -binary ~/Downloads/CiscoPacketTracer_<Version>_Ubuntu_64bit.deb | openssl base64 -A
            hash = "sha256-zwjYlr+mBvL4lZQXhEJWIJ/MUCyEG9jGxYnc01KIZzM=";
          };
        };
      in
      requireFile {
        inherit (sources."${version}") name hash;
        url = "https://launchpad.net/~smartfinn/+archive/ubuntu/eve-ng-integration/+files/eve-ng-integration_0.5.0-0~80~ubuntu26.10.1_all.deb";
      };

    nativeBuildInputs = [
      dpkg
    ];

    installPhase = ''
      runHook preInstall

      # cp opt/pt/packettracer.AppImage $out

      runHook postInstall
    '';
  };

in
appimageTools.wrapType2 rec {
  pname = "eve-ng-integration";
  inherit version;

  src = appimage;

  extraPkgs = _: [
    libpng
    libxkbfile
  ];

  extraBwrapArgs = [
    # fixes launch on wayland when the user sets QT_QPA_PLATFORM=wayland:
    # "Fatal: This application failed to start because no Qt platform plugin could be initialized."
    "--setenv QT_QPA_PLATFORM xcb"
  ];

  extraInstallCommands =
    let
      contents = appimageTools.extract { inherit pname version src; };
    in
    ''
      mv $out/bin/${pname} $out/bin/packettracer9

      install -Dm444 ${contents}/CiscoPacketTracer-9.0.1.desktop $out/share/applications/cisco-packet-tracer-9.desktop
      install -Dm444 ${contents}/CiscoPacketTracerPtsa-9.0.1.desktop $out/share/applications/cisco-packet-tracer-ptsa-9.desktop
      substituteInPlace $out/share/applications/* \
        --replace-fail "Exec=@EXEC_PATH@" "Exec=packettracer9" \
        --replace-fail "Icon=app" "Icon=cisco-packet-tracer-9"

      install -Dm444 ${contents}/usr/share/icons/hicolor/48x48/apps/app.png $out/share/icons/hicolor/48x48/apps/cisco-packet-tracer-9.png
      cp -r ${contents}/usr/share/icons/gnome/48x48/mimetypes $out/share/icons/hicolor/48x48/

      for desktop in $out/share/applications/*.desktop; do
        sed -i '/^\[Desktop Entry\]/a StartupWMClass=PacketTracer' "$desktop"
      done
    '';

  meta = {
    description = "Network simulation tool from Cisco";
    homepage = "https://www.netacad.com/courses/packet-tracer";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [
      gepbird
    ];
    mainProgram = "packettracer9";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
