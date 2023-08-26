import 'package:flutter/cupertino.dart';
class CupertinoContextMenuExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Context Menu Example'),
      ),
      child: Center(
        child: CupertinoContextMenu(enableHapticFeedback: true,
          actions: [
            CupertinoContextMenuAction(
              child:Text('Action 1'),trailingIcon: CupertinoIcons.add_circled,
              onPressed: () {
                // Handle action 1
                Navigator.pop(context);
              },
            ),
            CupertinoContextMenuAction(trailingIcon: CupertinoIcons.delete,
              child: const Text('Action 2'),
              onPressed: () {
                // Handle action 2
                Navigator.pop(context);
              },
            ),
          ],
          child: Container(
            width: 300,
            height: 300,
            child: Center(
              child: Image.asset('assets/w5.jpg')
            ),
          ),
        ),
      ),
    );
  }
}