import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:todo_dapp_front/TodoContract.g.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web3_connect/web3_connect.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class TodoListModel extends ChangeNotifier {
  List<Task> todos = [];
  bool isLoading = false;
  late int taskCount;
  final String _rpcUrl =
      "https://polygon-mumbai.g.alchemy.com/v2/ItHA6NcoaTnSQygeJ_YuhnzG_DcYsMog";
  final String _wsUrl =
      "wss://polygon-mumbai.g.alchemy.com/v2/ItHA6NcoaTnSQygeJ_YuhnzG_DcYsMog";
  final String _deepLink =
      "wc:00e46b69-d0cc-4b3e-b6a2-cee442f97188@1?bridge=https%3A%2F%2Fbridge.walletconnect.org&key=91303dedf64285cbbaf9120f6e9d160a5c8aa3deb67017a3874cd272323f48ae";

  late Web3Client _client;

  EthereumAddress? _contractAddress;

  Web3Connect? _connection;
  TodoContract? _todoContract;

  TodoListModel() {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    _client.printErrors = true;
    //_client = Web3Client(_rpcUrl, Client());
  }

  Future setConnection(Web3Connect c) async {
    isLoading = true;
    notifyListeners();

    _connection = c;
    await getAbi();
    _todoContract = TodoContract(address: _contractAddress!, client: _client);

    await getTodos();
    notifyListeners();
  }

  Future<void> getAbi() async {
    final abiStringFile =
        await rootBundle.loadString("smartcontract/TodoContract.json");
    final jsonAbi = jsonDecode(abiStringFile);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["80001"]["address"]);
  }

  getTodos() async {
    if (_todoContract != null) {
      isLoading = true;
      notifyListeners();
      BigInt totalTask = await _todoContract!.taskCount();
      taskCount = totalTask.toInt();
      todos.clear();
      for (var i = 0; i < totalTask.toInt(); i++) {
        var temp = await _todoContract!.todos(BigInt.from(i));
        todos.add(Task(
            id: temp.index.toInt(),
            taskName: temp.taskName,
            isCompleted: temp.isComplete));
      }
      isLoading = false;
      todos = todos.reversed.toList();
      notifyListeners();
    }
  }

  _transaction(String functionName, List<dynamic> parameters) async {
    if (_connection != null) {
      isLoading = true;
      notifyListeners();
      final function = _todoContract!.self.function(functionName);
      final transaction = Transaction.callContract(
          contract: _todoContract!.self,
          function: function,
          from: EthereumAddress.fromHex(_connection!.account),
          parameters: parameters);
      final f = _client.sendTransaction(_connection!.credentials, transaction,
          chainId: 80001);

      if (!await launchUrlString(_deepLink)) {
        throw "Could not launch $_deepLink";
      }
      await f;
      isLoading = false;
      notifyListeners();
    }
  }

  addTask(String taskNameData) async {
    await _transaction("createTask", [taskNameData]);
  }

  updateTask(int id, String taskNameData) async {
    await _transaction("updateTask", [BigInt.from(id), taskNameData]);
  }

  deleteTask(int id) async {
    await _transaction("deleteTask", [BigInt.from(id)]);
  }

  toggleComplete(int id) async {
    await _transaction("toggleComplete", [BigInt.from(id)]);
    // await _todoContract?.toggleComplete(BigInt.from(id),
    //     credentials: _connection!.credentials);
    //await getTodos();
  }
}

class Task {
  final int id;
  final String taskName;
  final bool isCompleted;
  Task({required this.id, required this.taskName, required this.isCompleted});
}
