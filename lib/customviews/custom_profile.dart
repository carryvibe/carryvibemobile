import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/manager/user_default_manager.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';

class CustomProfile extends StatelessWidget {
  Future<String> getName() async {
    String? name =
        await UserDefaultManager.shared().getValue(UserKeys.firstName) +
            await UserDefaultManager.shared().getValue(UserKeys.lastName);
    return name ?? "";
  }

  Future<String> getAvatar() async {
    String? name = await UserDefaultManager.shared().getValue(UserKeys.avatar);
    if (name == "") {
      name = avatarImgUrl;
    }
    return name ?? avatarImgUrl;
  }

  const CustomProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<String>(
          future: getAvatar(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Yükleniyor simgesi
            } else if (snapshot.hasError) {
              // Hata durumunda varsayılan bir avatar gösterilebilir.
              return GFAvatar(
                backgroundImage: NetworkImage(avatarImgUrl),
                shape: GFAvatarShape.circle,
                size: GFSize.LARGE * 2,
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(),
                  GFAvatar(
                    backgroundImage:
                        NetworkImage(snapshot.data ?? avatarImgUrl),
                    shape: GFAvatarShape.circle,
                    size: GFSize.LARGE * 2,
                  ),
                  const Spacer()
                ],
              );
            }
          },
        ),
        FutureBuilder<String>(
          future: getName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Yükleniyor simgesi
            } else if (snapshot.hasError) {
              return CustomSecondLabel(
                  text: "Hata"); // Hata durumunda bir metin göster
            } else {
              return CustomSecondLabel(text: snapshot.data ?? "");
            }
          },
        ),
      ],
    );
  }
}
