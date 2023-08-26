import 'package:flutter/cupertino.dart';

class SlidingSegmentedControlDemo extends StatefulWidget {
  const SlidingSegmentedControlDemo({super.key});

  @override
  _SlidingSegmentedControlDemoState createState() =>
      _SlidingSegmentedControlDemoState();
}

class _SlidingSegmentedControlDemoState
    extends State<SlidingSegmentedControlDemo> {
  int _currentSegment = 0; // Current selected segment index

  final Map<int, Widget> logoWidgets = {
    0: const Text('posts '),
    1: const Text('channels'),

  };
final Map<int,Widget> icons=<int,Widget>{
  0:Container(color: CupertinoColors.activeBlue,height: 200,),
   1:Container(color: CupertinoColors.activeGreen,height: 200,),
};
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:const CupertinoNavigationBar(
        middle: Text('Sliding Segmented Control'),
      ),
      child: Padding(
        padding:  EdgeInsets.only(top: 160,left: MediaQuery.of(context).size.width/4.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align widgets at the top
          children: [
            CupertinoSlidingSegmentedControl(thumbColor: CupertinoColors.lightBackgroundGray,padding: EdgeInsets.all(8),
              children: logoWidgets,
              onValueChanged: ( value) {
                setState(() {
                  _currentSegment = value!;
                });
              },
              groupValue: _currentSegment,
            ),
            const SizedBox(height: 20),
            // Display the content of the selected tab based on _currentSegment
            icons[_currentSegment]!,
          ],
        ),
      ),
    );
  }
}