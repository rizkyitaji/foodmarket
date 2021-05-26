part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool invalidName = false;
  bool invalidEmail = false;
  bool invalidPhone = false;
  bool isLoading = false;
  PickedFile pickedFile;
  File pictureFile;

  @override
  void initState() {
    super.initState();
    nameController.text =
        (context.read<UserCubit>().state as UserLoaded).user.name;
    emailController.text =
        (context.read<UserCubit>().state as UserLoaded).user.email;
    phoneController.text =
        (context.read<UserCubit>().state as UserLoaded).user.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Edit Profile',
      subtitle: 'Update your profile here',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              margin: EdgeInsets.symmetric(vertical: 26),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/photo_border.png'),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    UploadPhotoDialog(
                      camera: () async {
                        Get.close(1);
                        pickedFile = await ImagePicker()
                            .getImage(source: ImageSource.camera);
                      },
                      gallery: () async {
                        Get.close(1);
                        pickedFile = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                      },
                    ),
                    enableDrag: false,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  );

                  if (pickedFile != null) {
                    setState(() => pictureFile = File(pickedFile.path));
                  }
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
            CustomTextField(
              controller: nameController,
              action: TextInputAction.next,
              caps: TextCapitalization.words,
              hintText: 'Type your full name',
              validator: invalidName,
            ),
            CustomTextField(
              marginTop: 16,
              controller: emailController,
              action: TextInputAction.next,
              type: TextInputType.emailAddress,
              hintText: 'Type your email address',
              validator: invalidEmail,
            ),
            CustomTextField(
              marginTop: 16,
              controller: phoneController,
              action: TextInputAction.done,
              type: TextInputType.number,
              hintText: 'Type your phone number',
              validator: invalidPhone,
            ),
            Container(
              width: double.infinity,
              height: 45,
              margin: EdgeInsets.only(top: defaultMargin, bottom: 40),
              child: isLoading
                  ? loadingIndicator
                  : ElevatedButton(
                      style: mainButtonStyle,
                      child: Text('Save'),
                      onPressed: () async {
                        if (nameController.text.isEmpty) {
                          setState(() => invalidName = true);
                        } else if (emailController.text.isEmpty ||
                            !emailController.text.contains('@')) {
                          setState(() => invalidEmail = true);
                        } else if (phoneController.text.isEmpty) {
                          setState(() => invalidPhone = true);
                        } else {
                          setState(() => isLoading = true);

                          User user = User(
                            name: nameController.text,
                            email: emailController.text,
                            phoneNumber: phoneController.text,
                            address:
                                (context.read<UserCubit>().state as UserLoaded)
                                    .user
                                    .address,
                            houseNumber:
                                (context.read<UserCubit>().state as UserLoaded)
                                    .user
                                    .houseNumber,
                            city:
                                (context.read<UserCubit>().state as UserLoaded)
                                    .user
                                    .city,
                          );

                          await context
                              .read<UserCubit>()
                              .updateProfile(user, pictureFile: pictureFile);
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
                                  'Your profile has been updated',
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
            ),
          ],
        ),
      ),
    );
  }
}
