import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class LoginUtil {

final facebookLogin = FacebookLogin();

Future<Map> LoginWithFB() async{
    
    final result = await facebookLogin.logInWithReadPermissions(['email']);
        
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=first_name,last_name,name,picture,email&access_token=${token}');
        Map profile = JSON.jsonDecode(graphResponse.body);
        
        return profile;
        break;

      case FacebookLoginStatus.cancelledByUser:
      case FacebookLoginStatus.error:
        return null;
    }

  }

LogoutFB(){
    facebookLogin.logOut();
}


}

