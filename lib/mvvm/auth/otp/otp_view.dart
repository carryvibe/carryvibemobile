import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/home/home_view.dart';
import 'package:flutter/material.dart';

class OtpView extends StatefulWidget {
  @override
  OtpViewState createState() => OtpViewState();
}

class OtpViewState extends State<OtpView> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var i = 0; i < 6; i++) {
      _focusNodes[i].dispose();
      _controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
      ),
      body: CustomView(
        children: [
          CustomLabel(text: 'SMS Doğrulama'),
          CustomSubLabel(text: 'Telefonuna gelen doğrulama kodunu gir.'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return buildOTPTextField(index);
            }),
          ),
          SizedBox(height: 16.0),
          PrimaryButton(
              text: "Doğrula",
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                    (route) => false);
              })
        ],
      ),
    );
  }

  Widget buildOTPTextField(int index) {
    return Container(
      width: 50.0,
      child: OtpTextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        onChanged: (value) {
          if (value.isNotEmpty) {
            _focusNodes[index].unfocus();
            if (index < 5) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            }
          } else if (value.length == 1) {
            return;
          }
        },
      ),
    );
  }
}
