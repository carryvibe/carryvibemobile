import 'package:flutter/material.dart';

class AppIconView extends StatelessWidget {
  final String icon;
  final double? width;
  const AppIconView({required this.icon, required this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      icon,
      width: width,
    );
  }
}

enum IconAssest {
  logo,
  call,
  lock,
  uk,
  turkish,
  arabic,
  mail,
  checked,
  deliveryManMarker,
  locationMarker,
  restaurantMarker,
  location,
  logOut,
  warning,
  list,
  placeholder,
  money,
  profileBg,
  support,
  notificationIn,
  house,
  user,
  forgot,
  wallet,
  locationPermission,
  update,
  maintenance,
  image,
  send,
  notificationPlaceholder,
}

class AppIcon extends StatelessWidget {
  final double? width;
  final IconAssest assest;

  String getAssests() {
    switch (assest) {
      case IconAssest.logo:
        return 'assets/image/logo.png';
      case IconAssest.call:
        return 'assets/image/call.png';
      case IconAssest.lock:
        return 'assets/image/lock.png';

      case IconAssest.uk:
        return 'assets/image/united-kingdom.png';
      case IconAssest.turkish:
        return 'assets/image/turkish.png';
      case IconAssest.arabic:
        return 'assets/image/arabic.png';

      case IconAssest.mail:
        return 'assets/image/mail.png';
      case IconAssest.checked:
        return 'assets/image/checked.png';
      case IconAssest.deliveryManMarker:
        return 'assets/image/delivery_man_marker.png';
      case IconAssest.locationMarker:
        return 'assets/image/location_marker.png';
      case IconAssest.restaurantMarker:
        return 'assets/image/restaurant_marker.png';
      case IconAssest.location:
        return 'assets/image/location.png';
      case IconAssest.logOut:
        return 'assets/image/log_out.png';
      case IconAssest.warning:
        return 'assets/image/warning.png';
      case IconAssest.list:
        return 'assets/image/list.png';
      case IconAssest.placeholder:
        return 'assets/image/placeholder.jpg';
      case IconAssest.money:
        return 'assets/image/money.png';
      case IconAssest.profileBg:
        return 'assets/image/profile_bg.png';
      case IconAssest.support:
        return 'assets/image/support.png';
      case IconAssest.notificationIn:
        return 'assets/image/notification_in.png';
      case IconAssest.house:
        return 'assets/image/house.png';
      case IconAssest.user:
        return 'assets/image/user.png';
      case IconAssest.forgot:
        return 'assets/image/forgot.png';
      case IconAssest.wallet:
        return 'assets/image/wallet.png';
      case IconAssest.locationPermission:
        return 'assets/image/location_permission.png';
      case IconAssest.update:
        return 'assets/image/update.png';
      case IconAssest.maintenance:
        return 'assets/image/maintenance.png';
      case IconAssest.image:
        return 'assets/image/image.png';
      case IconAssest.send:
        return 'assets/image/send.png';
      case IconAssest.notificationPlaceholder:
        return 'assets/image/notification_placeholder.jpg';
    }
  }

  AppIcon({required this.assest, this.width = null});

  @override
  Widget build(BuildContext context) {
    return AppIconView(icon: getAssests(), width: width);
  }
}
