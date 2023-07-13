import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/widgets.dart';

mixin RegisterViewModelDelegate {
  void didNextButtonTapped();
}

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModelDelegate? delegate;
  Service service;
  RegisterViewModel({required this.service});
}
