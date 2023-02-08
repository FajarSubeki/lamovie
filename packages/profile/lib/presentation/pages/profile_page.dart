import 'package:flutter/material.dart';
import 'package:profile/presentation/widgets/button_widget.dart';
import 'package:profile/presentation/widgets/profile_widget.dart';
import 'package:core/core.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () {

            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildUpgradeButton(),
              const SizedBox(width: 16),
              buildGithubButton()
            ],
          )),
          const SizedBox(height: 24),
          buildAbout(user),
        ],
      ),
    );

  }

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.position,
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Linkedin',
    backgroundColor: kLightBlue,
    onClicked: () {
      // _linkedin();
    },
  );

  Widget buildGithubButton() => ButtonWidget(
    text: 'Github',
    backgroundColor: kDark,
    onClicked: () {
      // _linkedin();
    },
  );

  // _linkedin() async {
  //   const url =
  //       'https://www.linkedin.com/in/fajar-sastroredjo/';// or add your URL here
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }


  Widget buildAbout(User user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user.about,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );

}