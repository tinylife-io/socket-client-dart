// Copyright 2018 Food Tiny Authors. All rights reserved.
// Note that this is NOT an open source project
// Unauthorized copying of this file, via any medium is strictly prohibited
// Proprietary and confidential for the commercial

import 'package:test/test.dart';
import 'package:socket_client_dart/socket_flutter.dart';

void main() {
  test("Client:integration", () async {
    // Client connection is not allowed to retry
    // another connection is connected
    Client.isDebug = true;
    var client = new Client('ws://localhost:3000', 100);
    client.authenticate({
      "scope": "Mobile",
      "version": "v1_0",
      "platform": "Android",
      "device": "Sony Xperia Z",
      "osVersion": "1234",
      "ipAddress": "127.0.0.1"
    });
    client.onConnection(() {
      client.on("UserAuthSignIn", (Message message) {
        print(message.serialize());
        expect("UserAuthSignIn", equals(message.event));
        expect('{"status": "OK"}', equals(message.message));
      });
      client.send("UserAuthSignIn", {});
    });
    await client.connect();
  });

  test("Client:canTerminate", () async {
    // Client connection is not allowed to retry
    // another connection is connected
//    var client = new Client("");
//    client.isTerminated = true;
//    assert(client.canTerminate(), true);
  });
}