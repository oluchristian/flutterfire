import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/login_screen.dart';
import 'package:flutter_firebase/services/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'Password', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              obscureText: true,
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'confirm password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  if (emailController.text == "" || passwordController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required'), backgroundColor: Colors.red,));
                  } else if(passwordController.text != confirmPasswordController.text){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match!'), backgroundColor: Colors.red,));
                  }else{
                    User? result = await AuthService().register(emailController.text, passwordController.text);
                    if (result != null) {
                      print('success');
                      print(result.email);
                    }
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            }, child: Text("Already have an account? Login here",),),
          ],
        ),
      ),
    );
  }
}
