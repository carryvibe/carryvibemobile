import 'package:flutter/widgets.dart';

mixin RegisterViewModelDelegate {
  void didNextButtonTapped();
}

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModelDelegate? delegate;
  RegisterViewModel() {
    init();
  }

  void init() {}
}
