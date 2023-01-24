import 'package:flutter/foundation.dart';
import 'package:localsend_app/gen/assets.gen.dart';
import 'package:localsend_app/gen/strings.g.dart';
import 'package:localsend_app/util/platform_check.dart';
import 'package:tray_manager/tray_manager.dart';

enum TrayEntry {
  open,
  close,
}

Future<void> initTray() async {
  if (!checkPlatformIsDesktop()) {
    return;
  }
  try {
    await trayManager.setIcon(
      checkPlatform([TargetPlatform.windows]) ? Assets.img.logo32Ico : Assets.img.logo32Png.path,
    );
    final items = [
      MenuItem(
        key: TrayEntry.open.name,
        label: t.general.open,
      ),
      MenuItem(
        key: TrayEntry.close.name,
        label: t.general.close,
      ),
    ];
    await trayManager.setContextMenu(Menu(items: items));
    await trayManager.setToolTip(t.appName);
  } catch (e) {
    print(e);
  }
}