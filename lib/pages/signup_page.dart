import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget{
  final void Function()? onPressed;
    const SignupPage({super.key,required this.onPressed});
    @override
    State<SignupPage> createState() => _SignupPageState();
}


class _SignupPageState extends State<SignupPage>{

  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  createUserWithEmailAndPassword() async{
  try {
    setState(() {
      isLoading = true;
    });
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _email.text,
    password: _password.text,
  );
  setState(() {
    isLoading = false;
  });
} on FirebaseAuthException catch (e) {
  setState(() {
    isLoading=false ;
  });
  if (e.code == 'weak-password') {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("The password provided is too weak"))
    );
  } else if (e.code == 'email-already-in-use') {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("The account already exists for that email."))
    );
  }
} catch (e) {
  setState(() {
    isLoading=false;
  });
  print(e);
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Signup"),
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
                      createUserWithEmailAndPassword();
                    }
                  },
                  child: isLoading
                    ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    ) 
                  : const Text("Signup"),
                ),
          
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    onPressed: widget.onPressed,
                    child : const Text("Login"),  
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