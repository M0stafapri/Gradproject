import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:simpleui/shared/style/colors.dart';
import '../modules/screens/sign_screens/signScreens/login.dart';
import 'cubit/layout_cubit.dart';
import 'cubit/layout_states.dart';
import 'package:simpleui/modules/screens/profile/profile_screen.dart';
import 'package:simpleui/modules/screens/certificates/certificates_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_launcher_icons/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeLayoutScreen(),
        '/profile': (context) => ProfileScreen(),
        '/certificates': (context) => CertificatesScreen(),
        'login_screen': (context) => LoginScreen(),
      },
    );
  }
}

class CacheHelper {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences?> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> putData({
    required String key,
    required dynamic value,
  }) async {
    if (_prefs == null) {
      await init();
    }
    if (value is String) return await _prefs!.setString(key, value);
    if (value is int) return await _prefs!.setInt(key, value);
    if (value is bool) return await _prefs!.setBool(key, value);
    if (value is double) return await _prefs!.setDouble(key, value);
    if (value is List<String>) return await _prefs!.setStringList(key, value);
    if (value is Map<String, dynamic>) {
      final jsonString = json.encode(value);
      return await _prefs!.setString(key, jsonString);
    }
    return false;
  }

  static dynamic getData({required String key}) {
    if (_prefs == null) return null;
    return _prefs!.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    if (_prefs == null) {
      await init();
    }
    return await _prefs!.remove(key);
  }

  static Future<bool> clearCache() async {
    if (_prefs == null) {
      await init();
    }
    return await _prefs!.clear();
  }
}

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = LayoutCubit.getInstance(context);
        return Scaffold(
          backgroundColor: Color(0xFFF5F5F5),
          body: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ),
                        Text(
                          'MyFitnessPal',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 48.w),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Expanded(
                      child: cubit.layoutScreens[cubit.bottomNavIndex],
                    ),
                    SizedBox(height: 3.h),
                    GNav(
                      gap: 6,
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 12.w),
                      tabMargin: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 12.w),
                      iconSize: 24.w,
                      color: Colors.blueGrey,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: const Color.fromARGB(255, 109, 173, 202),
                      ),
                      activeColor: const Color.fromARGB(255, 109, 173, 202),
                      backgroundColor: Colors.white,
                      tabBackgroundColor:
                          (const Color.fromARGB(255, 221, 228, 228)),
                      tabs: [
                        GButton(
                            icon: Icons.home,
                            text: 'Home',
                            iconColor: Colors.blueGrey),
                        GButton(
                            icon: Icons.person,
                            text: 'Profile',
                            iconColor: Colors.blueGrey),
                        GButton(
                            icon: Icons.camera_alt,
                            text: 'Scan Meal',
                            iconColor: Colors.blueGrey),
                      ],
                      selectedIndex: cubit.bottomNavIndex,
                      onTabChange: (index) {
                        cubit.changeBottomNavIndex(index);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  color: Colors.white,
                  child: UserAccountsDrawerHeader(
                    accountName: Text(cubit.userData?.userName ?? ''),
                    accountEmail: Text(cubit.userData?.email ?? ''),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: cubit.userData?.image != null? NetworkImage(cubit.userData!.image! as String): AssetImage( 'assets/introduction_animation/relax_image.png') as ImageProvider<Object>,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.blueGrey),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.of(context).pop();
                    cubit.changeBottomNavIndex(0);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.blueGrey),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/profile');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt, color: Colors.blueGrey),
                  title: Text('Scan Meal'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/certificates');
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.blueGrey),
                  title: Text('Log out'),
                  onTap: () {
                    cubit.userData = null;
                    CacheHelper.clearCache();
                    Navigator.pushReplacementNamed(
                        context, "login_screen");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}