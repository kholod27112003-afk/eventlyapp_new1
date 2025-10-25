
import 'package:eventlyapp_new/generated/l10n.dart';
import 'package:eventlyapp_new/home_screen/Tabs/home_tabs/event_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_language.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_style.dart';
import 'widgets/category_items.dart';
import 'widgets/event_tab_items.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).welcome_back,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "kholod ali",
                  style: AppStyle.bold24White,
                )
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                  icon: Icon(
                    themeProvider.isDarkMode
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: AppColor.primaryLightbgColor,
                  ),
                ),
                Card(
                  color: AppColor.primaryLightbgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child: InkWell(
                      onTap: () {
                        if (languageProvider.appLanguage == "en") {
                          languageProvider.changeLanguage("ar");
                        } else {
                          languageProvider.changeLanguage("en");
                        }
                      },
                      child: Text(
                        languageProvider.appLanguage == "en" ? "EN" : "AR",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.011, horizontal: width * .03),
            height: height * .13,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColor.primaryLightbgColor,
                    ),
                    Text(
                      S.of(context).alexandria,
                      style: AppStyle.reglur16White,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                DefaultTabController(
                    length: CategoryModel.getCategoriesWithAll(context).length,
                    child: TabBar(
                        labelPadding:
                        EdgeInsets.symmetric(horizontal: width * 0.02),
                        onTap: (index) {
                          selectedIndex = index;
                          setState(() {});
                        },
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        tabAlignment: TabAlignment.start,
                        tabs: CategoryModel.getCategoriesWithAll(context)
                            .map((category) => EventTabItem(
                            isSelected: selectedIndex ==
                                CategoryModel.getCategoriesWithAll(context)
                                    .indexOf(category),
                            selectedBgColor: Theme.of(context).focusColor,
                            selectedFgColor: Theme.of(context).canvasColor,
                            unSelectedBgColor: Colors.transparent,
                            unSelectedFgColor: AppColor.primaryLightbgColor,
                            category: category))
                            .toList()))
              ],
            ),
          ),
          Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.only(top: height * 0.02),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: EventItem(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: height * 0.01,
                    );
                  },
                  itemCount: 20))
        ],
      ),
    );
  }
}
