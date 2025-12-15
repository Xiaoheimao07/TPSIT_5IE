import 'dart:io';

void main() async {
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 3000);
  print("Server TCP in esecuzione sulla porta 3000");

  final clients = <Socket>[];

  server.listen((client) {
    clients.add(client);
    print("Nuovo client: ${client.remoteAddress.address}");

    client.listen(
      (data) {
        // Messaggio ricevuto
        for (var c in clients) {
          if (c != client) {
            c.add(data);
          }
        }
      },
      onDone: () {
        print("Client disconnesso");
        clients.remove(client);
        client.close();
      },
      onError: (err) {
        print("Errore: $err");
        clients.remove(client);
        client.close();
      },
    );
  });
}
