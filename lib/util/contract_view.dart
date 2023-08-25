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
