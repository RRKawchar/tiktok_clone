import 'package:flutter/material.dart';
import 'package:tiktok_clone_app/constants.dart';
import 'package:tiktok_clone_app/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tiktok clone",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: buttonColor),
            ),
            const Text(
              "Login",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin:const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                labelText: "Email",
                controller: _emailController,
                icon: Icons.email,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin:const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                labelText: "Password",
                controller: _passController,
                icon: Icons.lock,
                isObsecure: true,
              ),
            ),
            const SizedBox(height: 25,),
            Container(
              width: MediaQuery.of(context).size.width-40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius:const BorderRadius.all(Radius.circular(5))
              ),
              child: InkWell(
                onTap: ()=>authController.loginUser(_emailController.text, _passController.text),
                child: const Center(
                  child: Text("Login",style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Text("Don't have an account ? ",style: TextStyle(fontSize: 20),),
                InkWell(
                    onTap: (){
                      print("navigating user");
                    },
                    child: Text("Register ",style: TextStyle(fontSize: 20,color: buttonColor),))
              ],
            )

          ],
        ),
      ),
    );
  }
}
