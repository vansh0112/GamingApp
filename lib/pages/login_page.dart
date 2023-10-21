  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';

  class LoginPage extends StatefulWidget{
      final void Function()? onPressed;
      const LoginPage({super.key, required this.onPressed});
      @override
      State<LoginPage> createState() => _LoginPageState();
  }


  class _LoginPageState extends State<LoginPage>{

    final _formkey = GlobalKey<FormState>();
    bool isLoading = false;
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();

    signInWithEmailAndPassword() async{
      try {
        setState(() {
          isLoading = true;
        });
            await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _email.text,
      password: _password.text,
    );
    setState(() {
      isLoading=false;
    });
  } on FirebaseAuthException catch (e) {
    setState(() {
      isLoading=false;
    });
    if (e.code == 'user-not-found') {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No User Found for that email")
        ),
      );
    } else if (e.code == 'wrong-password') {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Wrong Password provided for that user")
        ),
      );
    }
  }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Login"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: OverflowBar(
                overflowSpacing: 20,
                children: [
                  TextFormField(
                    controller: _email,
                    validator: (text){
                      if (text == null || text.isEmpty){
                        return 'Email is Empty';
                    }
                      return null;
                  },
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextFormField(
                    controller: _password,
                    validator: (text){
                      if (text == null || text.isEmpty){
                        return 'Password is Empty';
                    }
                      return null;
                  },
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: (){
                      if (_formkey.currentState!.validate()){
                        signInWithEmailAndPassword();
                      }
                    },
                    child:isLoading
                      ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      ) 
                    : const Text("Login"),
                  ),
            
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: widget.onPressed,
                    child: const Text("Signup"),
                  ),
            
                ),
              ],
                    ),
            ),
        ),
      ),
    );
    }
  }