import 'package:baby_care/core/models/navbar_item.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/features/dashboard/analytic_page.dart';
import 'package:baby_care/features/dashboard/home_page.dart';
import 'package:baby_care/features/dashboard/insight_page.dart';
import 'package:baby_care/features/dashboard/profile_page.dart';
import 'package:baby_care/features/shop/shop_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigationLayout extends StatefulWidget {
  const NavigationLayout({super.key});

  @override
  State<NavigationLayout> createState() => _NavigationLayoutState();
}

class _NavigationLayoutState extends State<NavigationLayout> {
  int currentIndex = 0;
  final List<NavbarItem> navbarItemList = [
    NavbarItem(
      page: HomePage(),
      icon: CupertinoIcons.house,
      pageName: "Pregnancy Tracker",
      label: "Home",
    ),
    NavbarItem(
      page: InsightPage(),
      icon: CupertinoIcons.lightbulb,
      pageName: "Health Article",
      label: "Insight",
    ),
    NavbarItem(
      page: AnalyticPage(),
      icon: Icons.auto_graph_rounded,
      pageName: "Health Insight",
      label: "Analytic",
    ),
    NavbarItem(
      page: ProfilePage(),
      icon: CupertinoIcons.slider_horizontal_3,
      pageName: "Profile",
      label: "Profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage("assets/images/navbar-bg.png"),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                child: navbarItem(navbarItemList[0].icon, currentIndex == 0),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                child: navbarItem(navbarItemList[1].icon, currentIndex == 1),
              ),
              SizedBox(width: 32),
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                child: navbarItem(navbarItemList[2].icon, currentIndex == 2),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                child: navbarItem(navbarItemList[3].icon, currentIndex == 3),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (item) => ShopHomePage()),
          );
        },
        child: PhysicalModel(
          elevation: 10,
          color: AppColors.navYellow,
          shape: BoxShape.circle,
          child: SizedBox(
            width: 56,
            height: 56,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                "assets/images/shopping-bag-icon.svg",
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          navbarItemList[currentIndex].pageName,
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: InkWell(onTap: () {}, child: Icon(CupertinoIcons.calendar)),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(CupertinoIcons.bell),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: navbarItemList.map((item) => item.page).toList(),
      ),
    );
  }
}

Widget navbarItem(IconData icon, bool isActive) {
  return SizedBox(
    height: 40,
    child: Column(
      spacing: 4,
      children: [
        Icon(icon),
        Visibility(
          visible: isActive,
          child: Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.navYellow,
            ),
          ),
        ),
      ],
    ),
  );
}
