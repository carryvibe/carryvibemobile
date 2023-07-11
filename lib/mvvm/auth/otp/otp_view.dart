import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/auth/otp/otp_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/home_view.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class OtpView extends StatefulWidget {
  final OtpViewModel viewModel;
  const OtpView({required this.viewModel});
  @override
  OtpViewState createState() => OtpViewState(viewModel: viewModel);
}

class OtpViewState extends State<OtpView> {
  final OtpViewModel viewModel;

  OtpViewState({required this.viewModel});
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
    void verifyOtp() async {
      var value = "";
      _controllers.forEach((element) {
        value += element.text;
      });
      final model = await viewModel.verifyOtp(value);
      if (model.isStatus ?? false) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
            (route) => false);
      }
      GFToast.showToast(model?.message ?? ServiceConstants.error, context,
          toastPosition: GFToastPosition.BOTTOM);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
      ),
      body: CustomView(
        children: [
          CustomLabel(text: 'SMS Doğrulama'),
          CustomSubLabel(
              text: viewModel.phoneNumber() +
                  ' Nolu Telefonuna gelen doğrulama kodunu gir.'),
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
                verifyOtp();
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
