import 'dart:async';

import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/auth/otp/otp_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/home_view.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class OtpView extends StatefulWidget {
  final OtpViewModel viewModel;
  const OtpView({required this.viewModel});
  @override
  OtpViewState createState() => OtpViewState(viewModel: viewModel);
}

class OtpViewState extends State<OtpView> {
  int seconds = 180;
  Timer? timer;
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
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      }
    });
  }

  String formatTime() {
    if (seconds == 0) {
      return "SMS Doğrulamak için süreniz dolmuştur. Yeniden otp göndererek SMS doğrulama işlemini baştan başlatabilirsiniz.";
    }
    int minute = seconds ~/ 60;
    int sec = seconds % 60;
    return viewModel.phoneNumber() +
        ' Nolu Telefonuna gelen doğrulama kodunu gir.\n Sms girmek için kalan zaman ' +
        '$minute:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    void resendOtp() async {
      final model = await viewModel.resendOtp();
      if (model.isStatus ?? false) {
        setState(() {
          seconds = 180;
          startTimer();
        });
      }
      GFToast.showToast(model?.message ?? ServiceConstants.error, context,
          toastPosition: GFToastPosition.BOTTOM);
    }

    void verifyOtp() async {
      var value = "";
      _controllers.forEach((element) {
        value += element.text;
      });
      if (value.length != 6) {
        GFToast.showToast("Lütfen boşlukları doldurunuz", context,
            toastPosition: GFToastPosition.BOTTOM);
        return;
      }
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
        service: viewModel.service,
        children: [
          CustomLabel(text: 'SMS Doğrulama'),
          CustomSubLabel(text: formatTime()),
          constraint,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return Container(
                width: 50.0,
                child: OtpTextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (value.length > 1) {
                        _controllers[index].text = value[value.length - 1];
                        value = value[value.length - 1];
                      }
                      _focusNodes[index].unfocus();
                      if (index < 5) {
                        FocusScope.of(context)
                            .requestFocus(_focusNodes[index + 1]);
                      } else {
                        verifyOtp();
                      }
                    } else if (value.length == 1) {
                      return;
                    } else if (value.length == 0) {
                      if (index != 0)
                        FocusScope.of(context)
                            .requestFocus(_focusNodes[index - 1]);
                    }
                  },
                ),
              );
            }),
          ),
          constraint,
          PrimaryButton(
              text: "Doğrula",
              onPressed: () {
                if (seconds > 0) {
                  verifyOtp();
                } else {
                  null;
                }
              }),
          constraint,
          PrimaryButton(
              text: "Yeniden Otp Gönder",
              onPressed: () {
                resendOtp();
              })
        ],
      ),
    );
  }
}
