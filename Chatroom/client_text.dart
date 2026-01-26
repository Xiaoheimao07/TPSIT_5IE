import 'dart:convert';
import 'dart:io';

void main() async {
  stdout.write("Inserisci il tuo username: ");
  final username = stdin.readLineSync()!.trim();

  final socket = await Socket.connect("127.0.0.1", 3000);
  print("Connesso al server!");

  socket.write("$username si è unito alla chat.\n");

  // Ascolta messaggi dagli altri client
  socket.listen((data) {
    print(utf8.decode(data).trim());
  });

  // Invia messaggi
  stdin.listen((data) {
    final msg = utf8.decode(data).trim();
    socket.write("$username: $msg\n");
  });
}
