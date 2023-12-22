import 'package:dart_console/dart_console.dart';
import 'package:push_puzzle/src/push_game.dart';

void main(List<String> arguments) async {
  final console = Console();
  // final game = PushGame();
  // game.draw();
  console.write('Press the key. To exit, press "q". \n');

  while (true) {
    final key = console.readKey();
    if (key.controlChar == ControlCharacter.none) {
      console.write('push key: ${key.char}。\n');
      // game.update(input key);
    }
    if (key.char == 'q') {
      break;
    }
  }
}
