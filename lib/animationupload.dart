import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UploadingAnimation extends StatefulWidget {
  @override
  _UploadingAnimationState createState() => _UploadingAnimationState();
}

class _UploadingAnimationState extends State<UploadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    // Simulating video upload progress
    simulateUploadProgress();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void simulateUploadProgress() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _progress += 0.2;
        if (_progress < 1.0) {
          simulateUploadProgress();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16.0),
          Text(
            'Uploading...',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: _progress,
            minHeight: 10.0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 8.0),
          SpinKitThreeBounce(
            color: Colors.blue,
            size: 20.0,
          ),
        ],
      ),
    );
  }
}
