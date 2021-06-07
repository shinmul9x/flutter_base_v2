import 'package:base/languages/languages.dart';
import 'package:base/library.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            CustomButton(
              child: Text(
                L.instance.hello,
                style: AppTextTheme.t16W700(Colors.white),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xff26B9D1),
                  Color(0xff6F5CF7),
                ],
              ),
              onPressed: () async {
                var result = await DialogHelper.showDialog(
                  'nothin',
                  onOk: () => Get.back(result: 'a'),
                );
                print(result);
              },
            ),
            CustomButton.icon(
              label: Text(
                L.instance.hello,
                style: AppTextTheme.t16W700(Colors.white),
              ),
              icon: Icon(Icons.play_arrow),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xff26B9D1),
                  Color(0xff6F5CF7),
                ],
              ),
              onPressed: () async {
                var result = await DialogHelper.showDialog(
                  'nothin',
                  onOk: () => Get.back(result: 'a'),
                );
                print(result);
              },
            )
          ],
        ),
      ),
    );
  }
}
