// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shattably/features/home/presention/layout/cubit/cubit.dart';
// import 'package:shattably/features/home/presention/layout/cubit/states.dart';
// import 'package:shattably/features/home/presention/widgets/main/widgets/cards_view/one_card_screen.dart';
// import 'package:shattably/features/home/presention/widgets/main/widgets/google_maps/google_maps_screen.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// String job = "";
//
// class CardHomeScreen extends StatelessWidget {
//   String? textTitle;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//
//           backgroundColor: Colors.black38,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//
//
//
//
//           ),
//           body: Column(
//
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               width: 165,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                   color: Colors.deepOrange, // Border color
//                                   width: 3.0, // Border width
//                                 ),
//                               ),
//                               child: OneCard(
//                                 imageForCard: 'electrician.png',
//                                 textTitle:
//                                 '${AppLocalizations.of(context)!.electrician}',
//                                 function: () {
//                                   job = "كهربائي";
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => RequestForm(job)),
//                                   );
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20.0,
//                             ),
//                             Container(
//                               width: 165,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                   color: Colors.deepOrange, // Border color
//                                   width: 3.0, // Border width
//                                 ),
//                               ),
//                               child: OneCard(
//                                 imageForCard: 'plumber.png',
//                                 textTitle:
//                                 '${AppLocalizations.of(context)!.plumber}',
//                                 function: () {
//                                   job = "سباك";
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => RequestForm(job)),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20.0,
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               width: 165,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                   color: Colors.deepOrange, // Border color
//                                   width: 3.0, // Border width
//                                 ),
//                               ),
//                               child: OneCard(
//                                 imageForCard: 'carpenter.png',
//                                 textTitle:
//                                 '${AppLocalizations.of(context)!.carpenter}',
//                                 function: () {
//                                   job = "نجار";
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => RequestForm(job)),
//                                   );
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20.0,
//                             ),
//                             Container(
//                               width: 165,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                   color: Colors.deepOrange, // Border color
//                                   width: 3.0, // Border width
//                                 ),
//                               ),
//                               child: OneCard(
//                                 imageForCard: 'painter.png',
//                                 textTitle:
//                                 '${AppLocalizations.of(context)!.painter}',
//                                 function: () {
//                                   job = "نقاش";
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => RequestForm(job)),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20.0,
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               width: 165,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                   color: Colors.deepOrange, // Border color
//                                   width: 3.0, // Border width
//                                 ),
//                               ),
//                               child: OneCard(
//                                 imageForCard: 'ceramic_tiles.png',
//                                 textTitle:
//                                 '${AppLocalizations.of(context)!.ceramicTiles}',
//                                 function: () {
//                                   job = "سيراميك";
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => RequestForm(job)),
//                                   );
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20.0,
//                             ),
//                             Container(
//                               width: 165,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                   color: Colors.deepOrange, // Border color
//                                   width: 3.0, // Border width
//                                 ),
//                               ),
//                               child: OneCard(
//                                 imageForCard: 'simth.png',
//                                 textTitle:
//                                 '${AppLocalizations.of(context)!.smith}',
//                                 function: () {
//                                   job = "حداد";
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => RequestForm(job)),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20.0,
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               width: 165,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                   color: Colors.deepOrange, // Border color
//                                   width: 3.0, // Border width
//                                 ),
//                               ),
//                               child: OneCard(
//                                 imageForCard: 'conditioning.png',
//                                 textTitle:
//                                 '${AppLocalizations.of(context)!.conditioning}',
//                                 function: () {
//                                   job = "تكييف";
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => RequestForm(job)),
//                                   );
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20.0,
//                             ),
//                             Container(
//                               width: 165,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                   color: Colors.deepOrange, // Border color
//                                   width: 3.0, // Border width
//                                 ),
//                               ),
//                               child: OneCard(
//                                 imageForCard: 'parquet.png',
//                                 textTitle:
//                                 '${AppLocalizations.of(context)!.parquet}',
//                                 function: () {
//                                   job = "باركية";
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => RequestForm(job)),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20.0,
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               width: 165,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                   color: Colors.deepOrange, // Border color
//                                   width: 3.0, // Border width
//                                 ),
//                               ),
//                               child: OneCard(
//                                 imageForCard: 'portal.png',
//                                 textTitle:
//                                 '${AppLocalizations.of(context)!.portal}',
//                                 function: () {
//                                   job = "الموتال";
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => RequestForm(job)),
//                                   );
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20.0,
//                             ),
//                             Container(
//                               width: 165,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                   color: Colors.deepOrange, // Border color
//                                   width: 3.0, // Border width
//                                 ),
//                               ),
//                               child: OneCard(
//                                 imageForCard: 'marble.png',
//                                 textTitle:
//                                 '${AppLocalizations.of(context)!.marble}',
//                                 function: () {
//                                   job = "رخام";
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => RequestForm(job)),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/features/home/presention/layout/cubit/cubit.dart';
import 'package:shattably/features/home/presention/layout/cubit/states.dart';
import 'package:shattably/features/home/presention/widgets/main/widgets/google_maps/google_maps_screen.dart';

String job = "";

class CardHomeScreen extends StatelessWidget {
  const CardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,

          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildServiceCardRow(context, 'electrician.png',
                      "كهربائي", 'كهربائي', 'plumber.png',
                      "سباك", 'سباك'),
                  const SizedBox(height: 20),
                  _buildServiceCardRow(context, 'carpenter.png',
                      "نجار", 'نجار', 'painter.png',
                      "نقاش", 'نقاش'),
                  const SizedBox(height: 20),
                  _buildServiceCardRow(context, 'ceramic_tiles.png',
                      "سيراميك", 'سيراميك', 'simth.png',
                      "حداد", 'حداد'),
                  const SizedBox(height: 20),
                  _buildServiceCardRow(context, 'conditioning.png',
                      "تكييف", 'تكييف', 'parquet.png',
                      "باركيه", 'باركية'),
                  const SizedBox(height: 20),
                  _buildServiceCardRow(context, 'portal.png',
                      "الموتال", 'الموتال', 'marble.png',
                      "رخام", 'رخام'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildServiceCardRow(BuildContext context, String image1, String title1, String job1, String image2, String title2, String job2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildServiceCard(context, image1, title1, job1),
        _buildServiceCard(context, image2, title2, job2),
      ],
    );
  }

  Widget _buildServiceCard(BuildContext context, String image, String title, String jobTitle) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          job = jobTitle;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RequestForm(job)),
          );
        },
        child: Container(
          height: 180,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/$image',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
