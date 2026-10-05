
import 'package:shattably/components/components.dart';
import 'package:shattably/features/home/presention/widgets/login/service_login_screen.dart';

import 'package:shattably/network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value)
    {
      navigateAndFinish(context, ServiceLoginScreen());
    }
  });
}