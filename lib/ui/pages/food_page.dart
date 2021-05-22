part of 'pages.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double listItemWidth =
        MediaQuery.of(context).size.width - 2 * defaultMargin;

    return ListView(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Food Market',
                        style: blackFontStyle1,
                      ),
                      Text(
                        "Let's get some foods",
                        style:
                            greyFontStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  GestureDetector(
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
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
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
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 258,
              child: BlocBuilder<FoodCubit, FoodState>(
                builder: (_, state) => (state is FoodLoaded)
                    ? ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            children: state.foods
                                .map((e) => Padding(
                                      padding: EdgeInsets.only(
                                          left: (e == state.foods.first)
                                              ? defaultMargin
                                              : 0,
                                          right: defaultMargin),
                                      child: GestureDetector(
                                          onTap: () {
                                            Get.to(FoodDetailsPage(
                                              transaction: Transaction(
                                                food: e,
                                                user: (context
                                                        .read<UserCubit>()
                                                        .state as UserLoaded)
                                                    .user,
                                              ),
                                              onBackButtonPressed: () {
                                                Get.back();
                                              },
                                            ));
                                          },
                                          child: FoodCard(e)),
                                    ))
                                .toList(),
                          )
                        ],
                      )
                    : Center(
                        child: loadingIndicator,
                      ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  CustomTabBar(
                    titles: ['New Taste', 'Popular', 'Recommended'],
                    selectedIndex: selectedIndex,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<FoodCubit, FoodState>(
                    builder: (_, state) {
                      if (state is FoodLoaded) {
                        List<Food> foods = state.foods
                            .where((element) => element.types.contains(
                                  (selectedIndex == 0)
                                      ? FoodType.new_food
                                      : (selectedIndex == 1)
                                          ? FoodType.popular
                                          : FoodType.recommended,
                                ))
                            .toList();
                        return Column(
                          children: foods
                              .map((e) => Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        defaultMargin, 0, defaultMargin, 16),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(FoodDetailsPage(
                                          transaction: Transaction(
                                            food: e,
                                            user: (context
                                                    .read<UserCubit>()
                                                    .state as UserLoaded)
                                                .user,
                                          ),
                                          onBackButtonPressed: () {
                                            Get.back();
                                          },
                                        ));
                                      },
                                      child: FoodListItem(
                                        food: e,
                                        itemWidth: listItemWidth,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        );
                      } else {
                        return SizedBox(
                          width: double.infinity,
                          height: 304, //76*4 items
                          child: Center(
                            child: loadingIndicator,
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        )
      ],
    );
  }
}
