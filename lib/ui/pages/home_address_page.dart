part of 'pages.dart';

class HomeAddressPage extends StatefulWidget {
  @override
  _HomeAddressPageState createState() => _HomeAddressPageState();
}

class _HomeAddressPageState extends State<HomeAddressPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController houseNumController = TextEditingController();
  bool isLoading = false;
  bool invalidAddress = false;
  bool invalidHouseNum = false;
  List<String> cities;
  String selectedCity;

  @override
  void initState() {
    super.initState();
    cities = ['Select your city', 'Jakarta', 'Bandung', 'Surabaya'];
    selectedCity = (context.read<UserCubit>().state as UserLoaded).user.city;
    addressController.text =
        (context.read<UserCubit>().state as UserLoaded).user.address;
    houseNumController.text =
        (context.read<UserCubit>().state as UserLoaded).user.houseNumber;
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Home Address',
      subtitle: 'Make sure your address is valid',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 26, 0, 6),
              child: Text("Address", style: blackFontStyle2),
            ),
            CustomTextField(
              controller: addressController,
              action: TextInputAction.next,
              caps: TextCapitalization.words,
              hintText: 'Type your address',
              validator: invalidAddress,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 16, 0, 6),
              child: Text("House No.", style: blackFontStyle2),
            ),
            CustomTextField(
              controller: houseNumController,
              action: TextInputAction.done,
              type: TextInputType.number,
              hintText: 'Type your house number',
              validator: invalidHouseNum,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 16, 0, 6),
              child: Text("City", style: blackFontStyle2),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: DropdownButton<dynamic>(
                value: selectedCity,
                isExpanded: true,
                underline: SizedBox(),
                items: cities
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: (e.contains('Select your city'))
                                ? greyFontStyle
                                : blackFontStyle3,
                          ),
                        ))
                    .toList(),
                onChanged: (item) {
                  setState(() => selectedCity = item);
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 45,
              margin: EdgeInsets.symmetric(vertical: defaultMargin),
              child: isLoading
                  ? Center(
                      child: loadingIndicator,
                    )
                  : ElevatedButton(
                      style: mainButtonStyle,
                      child: Text('Save'),
                      onPressed: () async {
                        if (addressController.text.isEmpty) {
                          setState(() => invalidAddress = true);
                        } else if (houseNumController.text.isEmpty) {
                          setState(() => invalidHouseNum = true);
                        } else if (selectedCity == 'Select your city') {
                          Get.snackbar("", "",
                              margin: EdgeInsets.fromLTRB(16, 40, 16, 40),
                              backgroundColor: redColor,
                              icon: Icon(
                                MdiIcons.closeCircleOutline,
                                color: Colors.white,
                              ),
                              titleText: Text(
                                'Sign Up Failed',
                                style: whiteFontStyle.copyWith(
                                    fontWeight: FontWeight.w600),
                              ),
                              messageText: Text(
                                'You have to fill in all of the fields',
                                style: whiteFontStyle,
                              ));
                        } else {
                          setState(() => isLoading = true);

                          User user = User(
                            address: addressController.text,
                            houseNumber: houseNumController.text,
                            city: selectedCity,
                          );

                          await context.read<UserCubit>().updateProfile(user);
                          UserState state = context.read<UserCubit>().state;

                          if (state is UserLoaded) {
                            setState(() => isLoading = false);
                            Get.snackbar("", "",
                                margin: EdgeInsets.fromLTRB(16, 40, 16, 40),
                                backgroundColor: greenColor,
                                icon: Icon(
                                  MdiIcons.checkCircleOutline,
                                  color: Colors.white,
                                ),
                                titleText: Text(
                                  'Update Success',
                                  style: whiteFontStyle.copyWith(
                                      fontWeight: FontWeight.w600),
                                ),
                                messageText: Text(
                                  'Your address has been updated',
                                  style: whiteFontStyle,
                                ));
                          } else {
                            setState(() => isLoading = false);
                            Get.snackbar("", "",
                                margin: EdgeInsets.fromLTRB(16, 40, 16, 40),
                                backgroundColor: redColor,
                                icon: Icon(
                                  MdiIcons.closeCircleOutline,
                                  color: Colors.white,
                                ),
                                titleText: Text(
                                  'Update Profile Failed',
                                  style: whiteFontStyle.copyWith(
                                      fontWeight: FontWeight.w600),
                                ),
                                messageText: Text(
                                  (context.read<UserCubit>().state
                                          as UserLoadingFailed)
                                      .message,
                                  style: whiteFontStyle,
                                ));
                          }
                        }
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
