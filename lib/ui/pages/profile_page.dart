part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 0;
  List<String> account = [
    'Edit Profile',
    'Home Address',
    'Security',
    'Payments',
    'Sign Out'
  ];
  List<String> foodmarket = [
    'Rate App',
    'Help Center',
    'Privacy & Policy',
    'Terms & Conditions'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    margin: EdgeInsets.only(top: 30, bottom: 16),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/photo_border.png'),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ShowPhotoDialog(
                            (context.read<UserCubit>().state as UserLoaded)
                                .user
                                .picturePath,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              (context.read<UserCubit>().state as UserLoaded)
                                  .user
                                  .picturePath,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    (context.read<UserCubit>().state as UserLoaded).user.name,
                    style: blackFontStyle1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6, bottom: 30),
                    child: Text(
                      (context.read<UserCubit>().state as UserLoaded)
                          .user
                          .email,
                      style: greyFontStyle,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: defaultMargin, bottom: 100),
              color: Colors.white,
              child: Column(
                children: [
                  CustomTabBar(
                    titles: ['Account', 'FoodMarket'],
                    selectedIndex: selectedIndex,
                    onTap: (index) {
                      setState(() => selectedIndex = index);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: (selectedIndex == 0 ? account : foodmarket)
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(
                              left: defaultMargin,
                              right: defaultMargin,
                              bottom: 16,
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                if (e == 'Edit Profile') {
                                  Get.to(EditProfilePage());
                                } else if (e == 'Home Address') {
                                  Get.to(HomeAddressPage());
                                } else if (e == 'Sign Out') {
                                  context.read<UserCubit>().signOut();
                                  Get.offAll(SignInPage());
                                } else {
                                  Get.snackbar(null, null,
                                      margin:
                                          EdgeInsets.fromLTRB(24, 40, 24, 0),
                                      backgroundColor: Colors.black,
                                      duration: Duration(seconds: 1),
                                      messageText: Text(
                                        'This features is under development!',
                                        textAlign: TextAlign.center,
                                        style: whiteFontStyle,
                                      ));
                                }
                              },
                              child: ProfileListItem(e),
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
