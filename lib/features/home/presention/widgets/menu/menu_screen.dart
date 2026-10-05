import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:share_plus/share_plus.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/features/home/presention/widgets/login/service_login_screen.dart';
import 'package:shattably/features/home/presention/widgets/menu/cubit/cubit.dart';
import 'package:shattably/features/home/presention/widgets/menu/cubit/states.dart';
import 'package:shattably/features/home/presention/widgets/menu/widgets/about_app/about_app_screen.dart';
import 'package:shattably/features/home/presention/widgets/menu/widgets/languages/language_screen.dart';
import 'package:shattably/features/home/presention/widgets/menu/widgets/terms_and_conditions/terms_and_condition_screen.dart';
import'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shattably/features/home/presention/widgets/register/service_register_screen.dart';

import 'widgets/share_app/share_screen.dart';
class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceMenuCubit, ServiceMenuStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white24,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.language_outlined , color: Colors.grey,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LanguagesScreen(),
                          ),
                        );
                      },
                      iconSize: 25.0,
                      color: Colors.green,
                    ),
                    // DropdownButton<Language>(
                    //
                    //   icon: const Icon(
                    //     Icons.language,
                    //     color: Colors.blue,
                    //   ),
                    //   //LOOOOOOOOOOOOOOOOOOOOOK HERE
                    //   onChanged: (Language? language) {
                    //     // Language.languageList().first ==1;
                    //     // Language.languageList().first ==2;
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>LanguagesScreen(),),);
                    //   },
                    //   items: Language.languageList()
                    //       .map<DropdownMenuItem<Language>>(
                    //         (e) => DropdownMenuItem<Language>(
                    //       value: e,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //         children: [
                    //           Text(
                    //             e.flag,
                    //             style: const TextStyle(
                    //                 fontSize: 25,
                    //             ),
                    //           ),
                    //           Text(e.name)
                    //         ],
                    //       ),
                    //     ),
                    //   ).toList(),
                    // ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Text(
                      'اللغات',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                          color: Colors.green,
                          fontFamily: 'Tajawal'
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                myDivider(),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.info_outline , color: Colors.grey,),
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutAppScreen(),),);
                      },
                      iconSize: 25.0,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Text(
                      'عن التطبيق',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                          color: Colors.green,
                          fontFamily: 'Tajawal'
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                myDivider(),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.zoom_out , color: Colors.grey,),
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditionScreen(),),);
                      },
                      iconSize: 25.0,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Text(
                      'الشروط و الاحكام',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                          color: Colors.green,
                          fontFamily: 'Tajawal'
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                myDivider(),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.share , color: Colors.grey,),
                      onPressed: () {
                        //Share.share('https://web.whatsapp.com/', subject: 'Look what I made!');
                        SharePressed();
                      },
                      iconSize: 25.0,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Text(
                      'مشاركة',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                        color: Colors.green,
                        fontFamily: 'Tajawal'
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                myDivider(),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.logout , color: Colors.grey,),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        navigateTo(context, ServiceLoginScreen());
                      },
                      iconSize: 25.0,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Text(
                      'تسجيل خروج',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                          color: Colors.green,
                          fontFamily: 'Tajawal'
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//"https://play.google.com/store/apps/details?id=com.instructivetech.testapp
