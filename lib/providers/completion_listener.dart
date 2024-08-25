
// @riverpod
// Stream<List<String>> chat(ChatRef ref) async* {
//   // Connect to an API using sockets, and decode the output
//   final socket = await Socket.connect('my-api', 4242);
//   ref.onDispose(socket.close);

//   var allMessages = const <String>[];
//   await for (final message in socket.map(utf8.decode)) {
//     // A new message has been received. Let's add it to the list of all messages.
//     allMessages = [...allMessages, message];
//     yield allMessages;
//   }
// }



import 'package:masnoon_dua/utils/dua_player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
Stream<void> aa(){
  return DuaPlayer().listenToAudioCompletion();
}