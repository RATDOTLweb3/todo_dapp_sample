// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"anonymous":false,"inputs":[{"indexed":false,"internalType":"string","name":"task","type":"string"},{"indexed":false,"internalType":"uint256","name":"taskNumber","type":"uint256"}],"name":"TaskCreated","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"taskNumber","type":"uint256"}],"name":"TaskDeleted","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"string","name":"task","type":"string"},{"indexed":false,"internalType":"uint256","name":"taskId","type":"uint256"},{"indexed":false,"internalType":"bool","name":"isComplete","type":"bool"}],"name":"TaskIsCompleteToggled","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"string","name":"task","type":"string"},{"indexed":false,"internalType":"uint256","name":"taskId","type":"uint256"}],"name":"TaskUpdated","type":"event"},{"inputs":[],"name":"taskCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"todos","outputs":[{"internalType":"uint256","name":"index","type":"uint256"},{"internalType":"string","name":"taskName","type":"string"},{"internalType":"bool","name":"isComplete","type":"bool"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"string","name":"_taskName","type":"string"}],"name":"createTask","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_taskId","type":"uint256"},{"internalType":"string","name":"_taskName","type":"string"}],"name":"updateTask","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_taskId","type":"uint256"}],"name":"toggleComplete","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_taskId","type":"uint256"}],"name":"deleteTask","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
    'TodoContract');

class TodoContract extends _i1.GeneratedContract {
  TodoContract(
      {required _i1.EthereumAddress address,
      required _i1.Web3Client client,
      int? chainId})
      : super(_i1.DeployedContract(_contractAbi, address), client, chainId);

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> taskCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, 'b6cb58a5'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Todos> todos(BigInt $param0, {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'bc8bc2b4'));
    final params = [$param0];
    final response = await read(function, params, atBlock);
    return Todos(response);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> createTask(String _taskName,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '111002aa'));
    final params = [_taskName];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> updateTask(BigInt _taskId, String _taskName,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '86533f6c'));
    final params = [_taskId, _taskName];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> toggleComplete(BigInt _taskId,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '0951e5bd'));
    final params = [_taskId];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> deleteTask(BigInt _taskId,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '560f3192'));
    final params = [_taskId];
    return write(credentials, transaction, function, params);
  }

  /// Returns a live stream of all TaskCreated events emitted by this contract.
  Stream<TaskCreated> taskCreatedEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('TaskCreated');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return TaskCreated(decoded);
    });
  }

  /// Returns a live stream of all TaskDeleted events emitted by this contract.
  Stream<TaskDeleted> taskDeletedEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('TaskDeleted');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return TaskDeleted(decoded);
    });
  }

  /// Returns a live stream of all TaskIsCompleteToggled events emitted by this contract.
  Stream<TaskIsCompleteToggled> taskIsCompleteToggledEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('TaskIsCompleteToggled');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return TaskIsCompleteToggled(decoded);
    });
  }

  /// Returns a live stream of all TaskUpdated events emitted by this contract.
  Stream<TaskUpdated> taskUpdatedEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('TaskUpdated');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return TaskUpdated(decoded);
    });
  }
}

class Todos {
  Todos(List<dynamic> response)
      : index = (response[0] as BigInt),
        taskName = (response[1] as String),
        isComplete = (response[2] as bool);

  final BigInt index;

  final String taskName;

  final bool isComplete;
}

class TaskCreated {
  TaskCreated(List<dynamic> response)
      : task = (response[0] as String),
        taskNumber = (response[1] as BigInt);

  final String task;

  final BigInt taskNumber;
}

class TaskDeleted {
  TaskDeleted(List<dynamic> response) : taskNumber = (response[0] as BigInt);

  final BigInt taskNumber;
}

class TaskIsCompleteToggled {
  TaskIsCompleteToggled(List<dynamic> response)
      : task = (response[0] as String),
        taskId = (response[1] as BigInt),
        isComplete = (response[2] as bool);

  final String task;

  final BigInt taskId;

  final bool isComplete;
}

class TaskUpdated {
  TaskUpdated(List<dynamic> response)
      : task = (response[0] as String),
        taskId = (response[1] as BigInt);

  final String task;

  final BigInt taskId;
}
