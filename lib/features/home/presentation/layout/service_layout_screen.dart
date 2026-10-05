import 'package:shattably/features/home/presentation/widgets/main/home_screen.dart';
import 'package:shattably/features/orders/presentation/customer_orders_screen.dart';
import 'package:shattably/features/profile/presentation/profile_screen.dart';
import 'package:shattably/features/home/presentation/widgets/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/features/home/presentation/layout/shell_cubit.dart';

class ServiceLayout extends StatefulWidget {
  const ServiceLayout({super.key});

  @override
  State<ServiceLayout> createState() => _ServiceLayoutState();
}

class _ServiceLayoutState extends State<ServiceLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'الخدمات',
      'طلباتك',
      'صفحتك الشخصية',
      'القائمة',
    ];
    return BlocBuilder<ShellCubit, int>(
      builder: (context, state) {
        const screens = [
          HomeScreen(),
          OrderScreen(),
          ProfileScreen(),
          MenuScreen()
        ];

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              titles[state],
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.green,
              ),
            ),
          ),
          body: screens[state],
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            color: Colors.black,
            child: BottomNavigationBar(
              backgroundColor: Colors.black38,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              elevation: 0,
              onTap: (index) {
                context.read<ShellCubit>().select(index);
              },
              currentIndex: state,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                  ),
                  label: 'الصقحة الرئيسية',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  label: 'الطلبات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_rounded,
                  ),
                  label: 'الصفحة الشخصية',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'القائمة',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
