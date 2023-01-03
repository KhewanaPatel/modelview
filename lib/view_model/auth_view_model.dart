import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:modelview/model/user_model.dart';
import 'package:modelview/respository/auth_repository.dart';
import 'package:modelview/utils/utils.dart';
import 'package:modelview/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../utils/routes/routes_name.dart';


class AuthViewModel with ChangeNotifier {

  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUploading => _signUpLoading;


  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }


  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();

}


  Future<void> loginApi(dynamic data, BuildContext context) async {

    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      setLoading(false);

      final userPreference=Provider.of<UserViewModel>(context,listen: false);
      userPreference.saveUser(
        UserModel(
          token: value["token"].toString()
        )
      );

      Utils.flushBarErrorMessages("Login Successfully", context);
      Navigator.pushNamed(context, RoutesName.home);

      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error,stackTrace) {
      setLoading(false);

      Utils.flushBarErrorMessages(error.toString(), context);
      if(kDebugMode) {
        print(error.toString());
      }
    });
  }
  Future<void> signupApi(dynamic data, BuildContext context) async {

    setSignUpLoading(true);

    _myRepo.signupApi(data).then((value) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessages("Signup Successfully", context);
      Navigator.pushNamed(context, RoutesName.home);

      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error,stackTrace) {
      setSignUpLoading(false);

      Utils.flushBarErrorMessages(error.toString(), context);
      if(kDebugMode) {
        print(error.toString());
      }
    });
  }
}
