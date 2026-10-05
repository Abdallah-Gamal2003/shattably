import 'package:shattably/features/auth/presentation/auth_cubits.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shattably/components/components.dart';
import 'package:shattably/features/home/presention/widgets/login/service_login_screen.dart';
import 'package:shattably/features/home/presention/widgets/menu/cubit/cubit.dart';
import 'package:shattably/features/home/presention/widgets/menu/cubit/states.dart';
import 'package:shattably/features/home/presention/widgets/menu/widgets/about_app/about_app_screen.dart';
import 'package:shattably/features/home/presention/widgets/menu/widgets/languages/language_screen.dart';
import 'package:shattably/features/home/presention/widgets/menu/widgets/terms_and_conditions/terms_and_condition_screen.dart';

import 'widgets/share_app/share_screen.dart';
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
                      icon: const Icon(Icons.language_outlined , color: Colors.grey,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LanguagesScreen(),
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
                    const SizedBox(
                      width: 25.0,
                    ),
                    const Text(
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
                const SizedBox(
                  height: 20.0,
                ),
                myDivider(),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.info_outline , color: Colors.grey,),
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutAppScreen(),),);
                      },
                      iconSize: 25.0,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    const Text(
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
                const SizedBox(
                  height: 20.0,
                ),
                myDivider(),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.zoom_out , color: Colors.grey,),
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const TermsAndConditionScreen(),),);
                      },
                      iconSize: 25.0,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    const Text(
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
                const SizedBox(
                  height: 20.0,
                ),
                myDivider(),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.share , color: Colors.grey,),
                      onPressed: () {
                        //Share.share('https://web.whatsapp.com/', subject: 'Look what I made!');
                        sharePressed();
                      },
                      iconSize: 25.0,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    const Text(
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
                const SizedBox(
                  height: 20.0,
                ),
                myDivider(),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.logout , color: Colors.grey,),
                      onPressed: () async {
                        await context.read<SessionCubit>().logout();
        if (!context.mounted) return;
                        navigateTo(context, ServiceLoginScreen());
                      },
                      iconSize: 25.0,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    const Text(
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
