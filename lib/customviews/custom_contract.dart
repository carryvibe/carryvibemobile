import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/common_service.dart';
import 'package:carryvibemobile/util/contract_view.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomContract extends StatelessWidget {
  final String text;
  final String textButton;
  final Contract contract;
  final Service service;
  const CustomContract(
      {Key? key,
      required this.text,
      required this.textButton,
      required this.contract,
      required this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onPressed() async {
      final model = await CommonService(service: service).getContract(contract);
      if (model != null &&
          model.isStatus == true &&
          model.responseModel != null) {
        final contractModel = ContractModel.fromJson(model.responseModel);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ContractView(contractModel: contractModel),
                fullscreenDialog: true));
      } else {
        GFToast.showToast(model?.message ?? ServiceConstants.error, context,
            toastPosition: GFToastPosition.BOTTOM);
      }
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: (text + " "),
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontSize: AppConstants.fontSizeLarge),
        children: <TextSpan>[
          TextSpan(
            text: textButton,
            style: const TextStyle(
              color: appColor,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onPressed,
          )
        ],
      ),
    );
  }
}

class CustomApproveContract extends StatefulWidget {
  final String text;
  final String textButton;
  final Contract contract;
  final Service service;
  final Function(bool) selected;

  const CustomApproveContract({
    Key? key,
    required this.text,
    required this.textButton,
    required this.contract,
    required this.service,
    required this.selected,
  }) : super(key: key);

  @override
  _CustomApproveContractState createState() => _CustomApproveContractState(
      text: text,
      textButton: textButton,
      contract: contract,
      selected: selected,
      service: service);
}

class _CustomApproveContractState extends State<CustomApproveContract> {
  final String text;
  final String textButton;
  final Contract contract;
  final Service service;
  final Function(bool) selected;
  bool selectedValue = false;
  _CustomApproveContractState(
      {required this.text,
      required this.textButton,
      required this.contract,
      required this.service,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    void onPressed() async {
      final model = await CommonService(service: service).getContract(contract);
      if (model != null &&
          model.isStatus == true &&
          model.responseModel != null) {
        final contractModel = ContractModel.fromJson(model.responseModel);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContractApproveView(
                      contractModel: contractModel,
                      selected: (bool value) {
                        selected(value);
                        Navigator.pop(context);
                        setState(() {
                          selectedValue = value;
                        });
                      },
                    ),
                fullscreenDialog: true));
      } else {
        GFToast.showToast(model?.message ?? ServiceConstants.error, context,
            toastPosition: GFToastPosition.BOTTOM);
      }
    }

    return Row(
      children: [
        Checkbox(
          value: selectedValue,
          onChanged: (bool? value) {
            if (value == true) {
              onPressed();
            }
          },
        ),
        Expanded(
          // RichText'i Expanded widget'ı ile sar
          child: RichText(
            text: TextSpan(
              text: (text + " "),
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontSize: AppConstants.fontSizeLarge),
              children: <TextSpan>[
                TextSpan(
                  text: textButton,
                  style: const TextStyle(
                    color: appColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onPressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
