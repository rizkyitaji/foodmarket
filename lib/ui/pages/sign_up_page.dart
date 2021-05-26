part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  User user;
  File pictureFile;
  PickedFile pickedFile;
  bool invalidName = false;
  bool invalidEmail = false;
  bool invalidPass = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: "Sign Up",
      subtitle: "Register and eat",
      onBackButtonPressed: () {
        Get.back();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            GestureDetector(
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
                width: 110,
                height: 110,
                margin: EdgeInsets.only(top: 26),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/photo_border.png'),
                  ),
                ),
                child: (pictureFile != null)
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(pictureFile),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/photo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 16, 0, 6),
              child: Text("Full Name", style: blackFontStyle2),
            ),
            CustomTextField(
              controller: nameController,
              action: TextInputAction.next,
              caps: TextCapitalization.words,
              hintText: 'Type your full name',
              validator: invalidName,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 16, 0, 6),
              child: Text("Email Address", style: blackFontStyle2),
            ),
            CustomTextField(
              controller: emailController,
              action: TextInputAction.next,
              type: TextInputType.emailAddress,
              hintText: 'Type your email address',
              validator: invalidEmail,
              email: true,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 16, 0, 6),
              child: Text("Password", style: blackFontStyle2),
            ),
            CustomTextField(
              obscureText: true,
              controller: passwordController,
              action: TextInputAction.done,
              hintText: 'Type your password',
              validator: invalidPass,
              password: true,
            ),
            Container(
              width: double.infinity,
              height: 45,
              margin: EdgeInsets.only(top: defaultMargin, bottom: 40),
              child: ElevatedButton(
                style: mainButtonStyle,
                child: Text("Continue", style: blackFontStyle3),
                onPressed: () {
                  if (nameController.text.isEmpty) {
                    setState(() => invalidName = true);
                  } else if (emailController.text.isEmpty ||
                      !emailController.text.contains('@')) {
                    setState(() => invalidEmail = true);
                  } else if (passwordController.text.isEmpty ||
                      passwordController.text.length < 8) {
                    setState(() => invalidPass = true);
                  } else if (pictureFile == null) {
                    Get.snackbar(null, null,
                        margin: EdgeInsets.fromLTRB(24, 40, 24, 40),
                        backgroundColor: redColor,
                        borderRadius: 8,
                        messageText: Text(
                          'You have to upload your profile picture!',
                          textAlign: TextAlign.center,
                          style: whiteFontStyle,
                        ));
                  } else {
                    Get.to(AddressPage(
                      User(
                        name: nameController.text,
                        email: emailController.text,
                      ),
                      passwordController.text,
                      pictureFile,
                    ));
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
