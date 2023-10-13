import 'package:flutter/material.dart';
import '../../../core/provider/get_un_user_data_provider.dart';
import '../../../core/string/app_color.dart';
import '../../../core/string/app_images.dart';
import '../../posts/screens/home_posts.dart';
import '../../register/screens/login_screen.dart';
import '../widget/item_of_home.dart';

class HomeScreen extends StatelessWidget {
  final String uid;

  const HomeScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.watch<GetUnUserDataProvider>().stateOfGetDoctorMediaData?.userName??''),
        actions:  [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 27),
            child: IconButton(
              onPressed: (){
                Provider.of<GetUnUserDataProvider>(
                    context,
                    listen: false).logOutProvider();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  LoginScreen(),
                  ),
                );
              },
              icon: Icon(Icons.logout),
            ),
          )
        ],
        backgroundColor: AppColor.greyColor,
        elevation: 0,
      ),
      backgroundColor: AppColor.greyColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 34, vertical: 30),
        child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20,
              crossAxisSpacing: 23,
              // childAspectRatio: 1.5,
              crossAxisCount: 2,
            ),
            children: [

              itemOfHome(context: context, icon: AppImages.iconCompass, title: 'News feed', onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return HomePostsScreen(uid:uid);
                    }));
              },countOfNotification:5),

            ],
            ),
      ),
    );
  }
}
