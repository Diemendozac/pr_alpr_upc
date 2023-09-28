import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/widgets/mobile_sidebar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MobileSideBar(),
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onError
      ),
      backgroundColor: Colors.white,
      body: Container(),

    );
  }

}
