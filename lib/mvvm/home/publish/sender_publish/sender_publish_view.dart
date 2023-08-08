import 'dart:convert';
import 'dart:io';
import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_dropdown.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/maps_select_last_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_model.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/publish/publish_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/publish/sender_publish/sender_publish_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class SenderPublishView extends StatelessWidget {
  final PublishViewModel viewModel;
  SenderPublishView({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return SenderPublishScreen(viewModel: viewModel);
  }
}

class SenderPublishScreen extends StatefulWidget {
  final PublishViewModel viewModel;
  SenderPublishScreen({required this.viewModel});
  @override
  _SenderPublishState createState() =>
      _SenderPublishState(viewModel: viewModel);
}

class _SenderPublishState extends State<SenderPublishScreen> {
  final PublishViewModel viewModel;
  _SenderPublishState({required this.viewModel});

  TextEditingController cargo = TextEditingController();
  TextEditingController cargoDescription = TextEditingController();
  String cargoSize = "";
  TextEditingController cargoWeight = TextEditingController();
  TextEditingController startLocation = TextEditingController();
  TextEditingController finishLocation = TextEditingController();
  TextEditingController recipientName = TextEditingController();
  TextEditingController recipientPhone = TextEditingController();
  List<String> base64 = [];
  FocusNode startFocus = FocusNode();
  FocusNode finishFocus = FocusNode();
  Places? startPlace, finishPlace;
  SelectMaps? startMaps, finishMaps;

  @override
  void initState() {
    super.initState();
    cargoSize = viewModel.getCargoSizes().first;
  }

  Future<void> _getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _resizeImageAndConvertToBase64(image);
      });
    }
  }

  void _resizeImageAndConvertToBase64(XFile _image) {
    if (_image != null) {
      File file = File(_image.path);
      print(file.readAsBytes());
      img.Image? image = img.decodeImage(file.readAsBytesSync());

      int targetWidth = 600;
      int targetHeight = (image!.height * targetWidth / image.width).round();

      img.Image resizedImage =
          img.copyResize(image, width: targetWidth, height: targetHeight);

      List<int> resizedBytes = img.encodeJpg(resizedImage, quality: 85);

      setState(() {
        base64.add(base64Encode(resizedBytes));
      });
    }
  }

  void _openSearchScreen(
      BuildContext context, TextEditingController controller) async {
    var places = await viewModel.getAllPlaces();
    if (places != null) {
      controller == startLocation
          ? startFocus.unfocus()
          : finishFocus.unfocus();
      final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SearchView(
                    onLocationSelected: (Places location) {
                      Navigator.pop(context, location);
                    },
                    viewModel: SearchViewModel(
                        service: viewModel.service, places: places),
                  ),
              fullscreenDialog: true));

      if (result != null) {
        var resultPlace = result as Places;
        final resultMap = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MapSelectLastView(
                      selectMaps: (SelectMaps maps) {
                        Navigator.pop(context, maps);
                      },
                      lat: resultPlace.lat,
                      long: resultPlace.lng,
                    )));

        if (resultMap != null) {
          if (controller == startLocation) {
            startPlace = resultPlace;
            startMaps = resultMap;
          } else {
            finishPlace = resultPlace;
            finishMaps = resultMap;
          }
          setState(() {
            controller.text = resultPlace.formattedAdres;
          });
        }
      }
    }
  }

  void _showBottomSheet(BuildContext context) {
    if (base64.length == 3) {
      GFToast.showToast("En fazla 3 fotoğraf ekleyebilirsiniz.", context,
          toastPosition: GFToastPosition.BOTTOM);
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SecondaryButton(
                  text: "Kamera",
                  onPressed: () {
                    Navigator.pop(context);
                    _getImage(ImageSource.camera);
                  }),
              SecondaryButton(
                  text: "Galeriden Seç",
                  onPressed: () {
                    Navigator.pop(context);
                    _getImage(ImageSource.gallery);
                  }),
            ],
          ),
        );
      },
    );
  }

  void postSender() async {
    BaseResponseModel response = await viewModel.postSender(SenderRequestModel(
        content: cargo.text,
        description: cargoDescription.text,
        cargoSize: cargoSize,
        cargoWeight: int.parse(cargoWeight.text),
        departurePlacesId: startPlace?.id ?? "",
        departurePoint: startMaps?.Point ?? "",
        departureCity: startMaps?.City ?? "",
        departureCountry: startMaps?.Country ?? "",
        departureDistrict: startMaps?.District ?? "",
        departureAddress: startMaps?.Address ?? "",
        destinationPlacesId: finishPlace?.id ?? "",
        destinationPoint: finishMaps?.Point ?? "",
        destinationCity: finishMaps?.City ?? "",
        destinationCountry: finishMaps?.Country ?? "",
        destinationDistrict: finishMaps?.District ?? "",
        destinationAddress: finishMaps?.Address ?? "",
        photoFirst: base64[0],
        photoSecond: base64.length > 1 ? base64[1] : null,
        photoThird: base64.length > 2 ? base64[2] : null,
        recipientName: recipientName.text,
        recipientPhone: recipientPhone.text));
    if (response.isStatus == true) {
      GFToast.showToast("İlan Başarılı ile yayınlanmıştır.", context,
          toastPosition: GFToastPosition.BOTTOM);
      setState(() {
        cargo.text = "";
        cargoDescription.text = "";
        cargoWeight.text = "";
        startLocation.text = "";
        finishLocation.text = "";
        recipientName.text = "";
        recipientPhone.text = "";
        base64 = [];
      });
    } else {
      GFToast.showToast(
          "Beklenmeyen bir hata oluştu, Tekrar deneyiniz.", context,
          toastPosition: GFToastPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 8),
      CustomSecondLabel(
          text: "Kargonu paylaş, Hızlı ve Güvenli teslim edilsin"),
      constraint,
      CustomTextField(controller: cargo, labelText: "Kargo nedir?"),
      constraint,
      CustomTextField(
          controller: cargoDescription, labelText: "Kargo Detayları"),
      constraint,
      CustomDropdown(
          dropdown: cargoSize,
          onChanged: (newValue) => setState(() {
                cargoSize = newValue as String;
              }),
          items: viewModel.getCargoSizes()),
      constraint,
      CustomTextField(controller: cargoWeight, labelText: "Kilo"),
      constraint,
      CustomLocationTextField(
        controller: startLocation,
        labelText: "Kalkış noktası",
        onTap: () => _openSearchScreen(context, startLocation),
        onChanged: (value) {
          setState(() {
            startLocation.text = value;
          });
        },
        focusNode: startFocus,
      ),
      constraint,
      CustomLocationTextField(
        controller: finishLocation,
        labelText: "Varış noktası",
        onTap: () => _openSearchScreen(context, finishLocation),
        onChanged: (value) {
          setState(() {
            finishLocation.text = value;
          });
        },
        focusNode: finishFocus,
      ),
      constraint,
      CustomTextField(controller: recipientName, labelText: "Alıcı Ad Soyad"),
      constraint,
      CustomTextField(controller: recipientPhone, labelText: "Alıcı Numarası"),
      constraint,
      if (base64.length != 0) images(),
      PrimaryButton(
          text: "Fotoğrafı Yükle",
          onPressed: () {
            _showBottomSheet(context);
          }),
      constraint,
      PrimaryButton(
          text: "Yayınla",
          onPressed: () {
            if (cargo.text != "" &&
                cargoDescription.text != "" &&
                cargoWeight.text != "" &&
                recipientName.text != "" &&
                recipientPhone.text != "" &&
                startLocation.text != "" &&
                finishLocation.text != "" &&
                cargoSize != viewModel.getCargoSizes().first &&
                base64.length != 0 &&
                int.tryParse(cargoWeight.text) != null &&
                int.tryParse(recipientPhone.text) != null &&
                recipientPhone.text.length == 11) {
              postSender();
            } else {
              var text = "Lütfen eksikleri tamamlayınız.";
              if (recipientPhone.text.length > 11)
                text = "Lütfen Alıcı telefon numarasını kontrol ediniz.";
              else if (base64.length == 0)
                text = "Lütfen en az bir fotoğraf yükleyiniz.";
              else if (cargoWeight.text.length > 0 &&
                  int.tryParse(cargoWeight.text) == null)
                text = "Lütfen Kargo ağırlık bilgisini sayı olarak giriniz.";
              GFToast.showToast(text, context,
                  toastPosition: GFToastPosition.BOTTOM);
            }
          }),
      SizedBox(height: 8),
    ]);
  }

  Widget images() {
    List<Widget> widgets = [];
    base64.forEach((element) {
      widgets.add(Image.memory(
        base64Decode(element),
        fit: BoxFit.cover,
        width: 100,
        height: 100,
      ));
      widgets.add(SizedBox(
        width: 8,
      ));
    });
    return Row(children: widgets);
  }
}
