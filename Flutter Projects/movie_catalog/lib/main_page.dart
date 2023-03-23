import 'package:flutter/material.dart';
import '../components/main_tab_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return MainTabController();
  }
}