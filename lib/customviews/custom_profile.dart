import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';

class CustomProfile extends StatelessWidget {
  final String avatar;
  final String name;
  const CustomProfile({
    Key? key,
    this.avatar =
        "https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png",
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            GFAvatar(
              backgroundImage: NetworkImage(avatar),
              shape: GFAvatarShape.circle,
              size: GFSize.LARGE * 2,
            ),
            Spacer()
          ],
        ),
        CustomSecondLabel(text: name)
      ],
    );
  }
}
