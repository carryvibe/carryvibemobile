import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ContractModel {
  String contractTitle, contract;
  ContractModel({required this.contractTitle, required this.contract});

  Map<String, dynamic> toJson() =>
      {'contractTitle': contractTitle, 'contract': contract};

  factory ContractModel.fromJson(Object? json) {
    var jsonConverter = json as Map<String, dynamic>;
    return ContractModel(
        contractTitle: jsonConverter?['contractName'],
        contract: jsonConverter?['contract']);
  }
}

class ContractView extends StatelessWidget {
  ContractModel contractModel;
  ContractView({required this.contractModel});
  @override
  Widget build(BuildContext context) {
    return ContractViewPage(
        contractTitle: contractModel.contractTitle,
        contract: contractModel.contract);
  }
}

class ContractViewPage extends StatefulWidget {
  String contractTitle, contract;
  ContractViewPage(
      {required this.contractTitle, required this.contract, Key? key})
      : super(key: key);

  @override
  _ContractViewPageState createState() => new _ContractViewPageState(
      contract: contract, contractTitle: contractTitle);
}

class _ContractViewPageState extends State<ContractViewPage> {
  String contractTitle, contract;
  _ContractViewPageState({required this.contract, required this.contractTitle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(contractTitle),
          backgroundColor: appColor,
        ),
        body: SingleChildScrollView(child: Html(data: contract)));
  }
}

class ContractApproveView extends StatelessWidget {
  ContractModel contractModel;
  Function(bool) selected;
  ContractApproveView({required this.contractModel, required this.selected});
  @override
  Widget build(BuildContext context) {
    return ContractApproveViewPage(
        contractTitle: contractModel.contractTitle,
        contract: contractModel.contract,
        selected: selected);
  }
}

class ContractApproveViewPage extends StatefulWidget {
  String contractTitle, contract;
  Function(bool) selected;
  ContractApproveViewPage(
      {required this.contractTitle,
      required this.contract,
      required this.selected,
      Key? key})
      : super(key: key);

  @override
  _ContractApproveViewPageState createState() =>
      new _ContractApproveViewPageState(
          contract: contract, contractTitle: contractTitle, selected: selected);
}

class _ContractApproveViewPageState extends State<ContractApproveViewPage> {
  String contractTitle, contract;
  Function(bool) selected;
  _ContractApproveViewPageState(
      {required this.contract,
      required this.contractTitle,
      required this.selected});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contractTitle),
        backgroundColor: appColor,
      ),
      body: SingleChildScrollView(child: Html(data: contract)),
      bottomNavigationBar: BottomAppBar(
          // Altta sabit bir buton ekle
          child: PrimaryButton(
              text: "Sözleşmeyi Onayla",
              onPressed: () {
                selected(true);
              })),
    );
  }
}
