part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool invalidEmail = false;
  bool invalidPass = false;

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: "Sign In",
      subtitle: "Find your best ever meal",
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 26, 0, 6),
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
              margin: EdgeInsets.only(top: defaultMargin),
              child: ElevatedButton(
                style: mainButtonStyle,
                child: Text('Sign In', style: blackFontStyle3),
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      !emailController.text.contains('@')) {
                    setState(() => invalidEmail = true);
                  } else if (passwordController.text.isEmpty ||
                      passwordController.text.length < 8) {
                    setState(() => invalidPass = true);
                  } else {
                    setState(() => isLoading = true);

                    await context
                        .read<UserCubit>()
                        .signIn(emailController.text, passwordController.text);
                    UserState state = context.read<UserCubit>().state;

                    if (state is UserLoaded) {
                      context.read<FoodCubit>().getFoods();
                      context.read<TransactionCubit>().getTransactions();
                      Get.off(MainPage());
                    } else {
                      setState(() => isLoading = false);
                      Get.snackbar("", "",
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 40),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: redColor,
                          icon: Icon(
                            MdiIcons.closeCircleOutline,
                            color: Colors.white,
                          ),
                          titleText: Text(
                            'Sign In Failed',
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
            Container(
              width: double.infinity,
              height: 45,
              margin: EdgeInsets.only(top: defaultMargin),
              child: isLoading
                  ? loadingIndicator
                  : ElevatedButton(
                      style: greyButtonStyle,
                      child: Text('Create New Account', style: whiteFontStyle),
                      onPressed: () {
                        Get.to(SignUpPage());
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
