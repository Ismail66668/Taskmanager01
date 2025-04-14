import '../screens/email_varification.dart';
import '../screens/login_screen.dart';
import '../screens/pin_veripaication.dart';
import '../screens/regestar.dart';
import '../screens/set_password.dart';

class NameRoute {
  List<Map> nameroute = {
    '/': (context) => const LoginScreen(),
    '/regstarPage': (context) => const RegestarScreen(),
    '/emailVeripication': (context) => const EmailVarification(),
    '/pinVeripication': (context) => const PinVeripaication(),
    '/setPassword': (context) => const SetPassword(),
  } as List<Map>;
}
