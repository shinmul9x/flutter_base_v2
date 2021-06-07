import 'package:base/library.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();

    _navigateScreen();
  }

  void _navigateScreen() async {
    Future.delayed(Duration(milliseconds: 100), () {
      Get.offNamed(AppRoute.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
