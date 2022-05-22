import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TodoList.dart';
import 'TodoListModel.dart';
import 'package:web3_connect/web3_connect.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoListModel(),
      child: MaterialApp(home: Login()),
    );
  }
}

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final connection = Web3Connect();
  final String _rpcUrl =
      "https://polygon-mumbai.g.alchemy.com/v2/ItHA6NcoaTnSQygeJ_YuhnzG_DcYsMog";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page")),
      body: Center(
          child: ElevatedButton(
        child: const Text("Log In"),
        onPressed: () async {
          connection.enterChainId(80001);
          connection.enterRpcUrl(_rpcUrl);
          await connection.connect();
          if (connection.account != "") {
            final model = context.read<TodoListModel>();
            model.setConnection(connection);
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const TodoList())));
          }
        },
      )),
    );
  }
}
