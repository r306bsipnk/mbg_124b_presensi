
import 'package:presensi/views/profile_page.dart';

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: CardProfile()
    );
  }
}

