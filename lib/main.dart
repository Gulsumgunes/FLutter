import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Giriş Ekranı',
      home: LoginScreen(),
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                  Image.asset(
                    'assets/images/flutter-banner.png', // Resim dosya yolu
                    width: 200, // Resim genişliği
                    height: 100, // Resim yüksekliği
                  ),

                const SizedBox(width: 30.0),
                const Text(
                  '',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // 'Forgot Password?' tıklandığında yapılacak işlemler
                    print('Forgot Password?');
                  },
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Giriş butonuna tıklandığında yapılacak işlemler
                String username = _emailController.text;
                String password = _passwordController.text;

                // Kullanıcı adı ve şifre kontrolü burada yapılabilir

                if (username.isNotEmpty && password.isNotEmpty) {
                  // Giriş başarılı, işlemleri burada yapabilirsiniz
                  print('Giriş Başarılı');
                } else {
                  // Giriş başarısız mesajı veya işlemleri burada yapabilirsiniz
                  print('Giriş Başarısız');
                }
              },
              style: ElevatedButton.styleFrom(

                padding: EdgeInsets.symmetric(horizontal: 85.0, vertical: 15.0),
               // Genişlik ayarı

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Şekil ayarı
                ),
              ),
                child:const Text(
                    'Login',

                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0, // Yazı boyutu ayarı
                ),
              ) ,
            ),
            const SizedBox(height: 16.0),
            const Spacer(), // Sayfanın geri kalanını aşağı itmek için Spacer ekledim
            const Text(
              'New User? Create Account',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

