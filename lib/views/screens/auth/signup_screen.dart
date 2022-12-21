import 'package:flutter/material.dart';
import 'package:tiktok_clone_app/constants.dart';
import 'package:tiktok_clone_app/views/widgets/text_input_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
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
              "Register",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage("https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"),
                  backgroundColor: Colors.black,
                ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(onPressed: (){}, icon:const Icon(Icons.add_a_photo)))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin:const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                labelText: "User Name",
                controller: _usernameController,
                icon: Icons.person,
              ),
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
              height: 15,
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
            const SizedBox(height: 30,),
            Container(
              width: MediaQuery.of(context).size.width-40,
              height: 50,
              decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius:const BorderRadius.all(Radius.circular(5))
              ),
              child: InkWell(
                onTap: (){
                  print("Register User");
                },
                child: const Center(
                  child: Text("Sign up",style: TextStyle(
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
                const Text("Already have an account ? ",style: TextStyle(fontSize: 20),),
                InkWell(
                    onTap: (){
                      print("navigating user");
                    },
                    child: Text("Login ",style: TextStyle(fontSize: 20,color: buttonColor),))
              ],
            )

          ],
        ),
      ),
    );
  }
}
