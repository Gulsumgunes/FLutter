import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class User {
  final String username;

  User(this.username);
}

// Temsil edilen bir ürünü tanımlayan sınıf
class Product {
  final String name;
  final String imageUrl;

  Product(this.name, this.imageUrl);
}

// Kullanıcının sepetine eklenen bir ürünü temsil eden sınıf
class CartItem {
  final String productName;
  final String imageUrl;

  CartItem(this.productName, this.imageUrl);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giriş Ekranı',
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<CartItem> cartItems = [];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pastahane'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String username = _usernameController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(User(username), _addToCart),
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _addToCart(Product product) {
    setState(() {
      cartItems.add(CartItem(product.name, product.imageUrl));
    });
  }
}


class ProductScreen extends StatelessWidget {
  final User user;
  final Function(Product) addToCart;


  const ProductScreen(this.user, this.addToCart);

  @override
  Widget build(BuildContext context) {
    List<Product> products = [
      Product('Pembe Şeritli Pasta', 'assets/images/pasta1.jpg'),
      Product('Pembe Dağınık Pasta', 'assets/images/pasta2.jpg'),
      Product('Beyaz Çiçekli pasta', 'assets/images/pasta3.jpg'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${user.username}'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Sepete Git'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(user, addToCart),
                  ),
                );

              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 2.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(products[index], user, addToCart);
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final User user;
  final Function(Product) addToCart;

  const ProductItem(this.product, this.user, this.addToCart);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            product.imageUrl,
            height: 125,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          Text(product.name),
          ElevatedButton(
            onPressed: () {
              _showSnackBar(context, 'Ürün sepete eklendi: ${product.name}');
              addToCart(product);
            },
            child: const Text('Sepete Ekle'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  final User user;
  final Function(Product) addToCart;

  const CartScreen(this.user, this.addToCart);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text('Sepetiniz boş.'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cartItems[index].productName),
                  leading: Image.asset(
                    cartItems[index].imageUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
    );
  }
}

