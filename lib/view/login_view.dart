import 'package:flutter/material.dart';
import 'package:modelview/res/components/round_button.dart';
import 'package:modelview/utils/routes/routes_name.dart';
import 'package:modelview/utils/utils.dart';
import 'package:modelview/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}



class _LoginViewState extends State<LoginView> {

  ValueNotifier<bool> _obsecurePassword =
  ValueNotifier<bool>(true); //hide eyes icon

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  FocusNode _emailnode = FocusNode();
  FocusNode _passnode = FocusNode();
  @override

  void dispose(){
    // TODO:implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();

    _emailnode.dispose();
    _passnode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel=Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        appBar: AppBar(
          title: Text("LOGIN SCREEN"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                focusNode: _emailnode,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email",
                    labelText: "email",
                    prefixIcon: Icon(Icons.alternate_email)),
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, _emailnode, _passnode);
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passController,
                      obscureText: _obsecurePassword.value,
                      obscuringCharacter: "*",
                      focusNode: _passnode,
                      decoration: InputDecoration(
                          hintText: "Password",
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock_outlined),
                          suffixIcon: InkWell(
                              onTap: () {
                                _obsecurePassword.value =
                                    !_obsecurePassword.value;
                              },
                              child: Icon(_obsecurePassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility))),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                  title: "login",
                  loading: authViewModel.loading,
                  onPress: () {
                    if (_emailController.text.isEmpty) {
                      Utils.flushBarErrorMessages("plz enter ur email", context);

                    } else if (_passController.text.isEmpty) {
                      Utils.flushBarErrorMessages("plz enter ur pass", context);

                    } else if (_passController.text.length < 6) {
                      Utils.flushBarErrorMessages("plz enter ur pass", context);
                    } else {
                      Map data={
                        "email":_emailController.text.toString(),
                        "password":_passController.text.toString(),
                      };
                      authViewModel.loginApi(data,context);
                      print("api hit");
                    }
                  },
                  ),
              InkWell(onTap: (){
                Navigator.pushNamed(context,RoutesName.signup);
              },
                  child: Text("Don't have an account? Signup"))
              ],
          ),
        ));
  }
}
