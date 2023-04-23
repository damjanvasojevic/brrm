import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future _signIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(
                height: 4,
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
                ),
                icon: const Icon(
                  Icons.lock_open,
                  size: 32,
                ),
                label: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: _signIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
