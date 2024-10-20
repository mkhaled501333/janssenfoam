import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/core/functions.dart';

class ServerStutus extends StatelessWidget {
  const ServerStutus({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isServerOnlineStream(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Row(
          children: [
            const Text(
              "server stutues :",
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
            const Gap(5),
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: snapshot.data == null
                    ? Colors.red
                    : snapshot.data!
                        ? const Color.fromARGB(255, 111, 255, 116)
                        : Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            const Gap(5),
            Text(
              snapshot.data == null
                  ? 'offline'
                  : snapshot.data!
                      ? 'online'
                      : "offline",
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        );
      },
    );
  }
}
