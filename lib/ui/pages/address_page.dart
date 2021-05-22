part of 'pages.dart';

class AddressPage extends StatefulWidget {
  final User user;
  final String password;
  final File pictureFile;

  AddressPage(this.user, this.password, this.pictureFile);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController houseNumController = TextEditingController();
  bool invalidPhone = false;
  bool invalidAddress = false;
  bool invalidHouseNum = false;
  bool isLoading = false;
  List<String> cities;
  String selectedCity;

  @override
  void initState() {
    super.initState();
    cities = ['Select your city', 'Jakarta', 'Bandung', 'Surabaya'];
    selectedCity = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: "Address",
      subtitle: "Make sure it's valid",
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
              child: Text("Phone No.", style: blackFontStyle2),
            ),
            CustomTextField(
              controller: phoneController,
              action: TextInputAction.next,
              type: TextInputType.number,
              hintText: 'Type your phone number',
              validator: invalidPhone,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 16, 0, 6),
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
              margin: EdgeInsets.only(top: defaultMargin, bottom: 40),
              child: isLoading
                  ? loadingIndicator
                  : ElevatedButton(
                      style: mainButtonStyle,
                      child: Text("Sign Up Now", style: blackFontStyle3),
                      onPressed: () async {
                        if (phoneController.text.isEmpty) {
                          setState(() => invalidPhone = true);
                        } else if (addressController.text.isEmpty) {
                          setState(() => invalidAddress = true);
                        } else if (houseNumController.text.isEmpty) {
                          setState(() => invalidHouseNum = true);
                        } else if (selectedCity == 'Select your city') {
                          showSnackbar('You have to fill in all of the fields');
                        } else {
                          setState(() => isLoading = true);

                          User user = widget.user.copyWith(
                            phoneNumber: phoneController.text,
                            address: addressController.text,
                            houseNumber: houseNumController.text,
                            city: selectedCity,
                          );

                          await context.read<UserCubit>().signUp(
                              user, widget.password,
                              pictureFile: widget.pictureFile);
                          UserState state = context.read<UserCubit>().state;

                          if (state is UserLoaded) {
                            context.read<FoodCubit>().getFoods();
                            context.read<TransactionCubit>().getTransactions();
                            Get.to(SuccessSignUpPage());
                          } else {
                            setState(() => isLoading = false);
                            showSnackbar((context.read<UserCubit>().state
                                    as UserLoadingFailed)
                                .message);
                          }
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackbar(String message) {
    Get.snackbar("", "",
        margin: EdgeInsets.fromLTRB(16, 40, 16, 40),
        backgroundColor: redColor,
        icon: Icon(
          MdiIcons.closeCircleOutline,
          color: Colors.white,
        ),
        titleText: Text(
          'Sign Up Failed',
          style: whiteFontStyle.copyWith(fontWeight: FontWeight.w600),
        ),
        messageText: Text(message, style: whiteFontStyle));
  }
}
