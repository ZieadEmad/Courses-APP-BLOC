import 'package:course_app/shared/colors/colors_common.dart';
import 'package:course_app/shared/network/remote/dio_helper.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryModel {
  String title;
  IconData iconData;

  CategoryModel(this.title, this.iconData);
}

List<CategoryModel> cat = [
  CategoryModel(
    'Mobile App',
    Icons.lightbulb_outline,
  ),
  CategoryModel(
    'UI & UX',
    Icons.lightbulb_outline,
  ),
  CategoryModel(
    'Front End',
    Icons.lightbulb_outline,
  ),
  CategoryModel(
    'Back End',
    Icons.lightbulb_outline,
  ),
  CategoryModel(
    'ML',
    Icons.lightbulb_outline,
  ),
  CategoryModel(
    'AI',
    Icons.lightbulb_outline,
  ),
  CategoryModel(
    'IOT',
    Icons.lightbulb_outline,
  ),
];



void initApp() {
  DioHelper();
}



Widget defaultButton({
  Color background = Colors.indigo,
  double radius = 25.0,
  double width = double.infinity,
  @required Function function,
  @required String text,
  bool toUpper = true,
}) => Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: FlatButton(
        onPressed: function,
        child: Text(
          toUpper ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget headText(String text) => Text(
      text,
      style: TextStyle(
        fontSize: 25,
      ),
    );

Widget captionText(String text) => Text(
      text,
      style: TextStyle(
        fontSize: 16,
      ),
    );

Widget detailsText(String text) => Text(
      text,
      style: TextStyle(
        fontSize: 14,
      ),
    );

Widget logo() => Image(
      image: AssetImage('assets/images/mainLogo.png'),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);

Widget defualtTextBox({
  String title,
  String hint = ' ',
  bool isPassword = false,
  @required TextEditingController controller,
  @required TextInputType type,
}) => Container(
      padding: EdgeInsetsDirectional.only(
        start: 15,
        end: 10,
        top: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) detailsText(title),
          TextFormField(
            obscureText: isPassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
            controller: controller,
            keyboardType: type,
          ),
        ],
      ),
    );

void buildProgress({context, text, bool error = false}) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (!error) CircularProgressIndicator(),
                if (!error)
                  SizedBox(
                    width: 20,
                  ),
                Expanded(child: Text(text)),
              ],
            ),
            if (error) SizedBox(height: 20),
            if (error)
              defaultButton(
                function: () {
                  Navigator.pop(context);
                },
                text: "Cancel",
              ),
          ],
        ),
      ),
    );

void showToast({@required text, @required error}) => Fluttertoast.showToast(
    msg: text.toString(),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: error ? Colors.red : Colors.green,
    textColor: Colors.white,
    fontSize: 16.0);

Widget buildOneCardSettings({
  title,
  @required Function firstFunction,
  @required Function secondFunction,
  @required Function thirdFunction,
  @required fisrtText,
  @required secondText,
  @required thirdText,
  @required firstHeroTag,
  @required secondHeroTag,
  @required thirdHeroTag,
}) {
  return Column(
    children: [
      buildCardTitleSettings(title: title),
      Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  buildOneRowCardSettings(
                    function: firstFunction,
                    text: fisrtText,
                    heroTag: firstHeroTag,
                  ),
                  buildOneRowCardSettings(
                    function: secondFunction,
                    text: secondText,
                    heroTag: secondHeroTag,
                  ),
                  buildOneRowCardSettings(
                    function: thirdFunction,
                    text: thirdText,
                    heroTag: thirdHeroTag,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildOneRowCardSettings({@required text, @required Function function, @required String heroTag}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      FloatingActionButton(
        heroTag: heroTag,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        onPressed: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              OMIcons.keyboardArrowRight,
              color: Colors.black,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildCardTitleSettings({@required title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 30,
      ),
      Container(
        child: Text(title),
      ),
    ],
  );
}

Widget buildOneBox({
  @required title,
  @required Widget child,
  Function function,
  double width = 200,
  double height = 200,
}) {
  return Container(
    width: width,
    height: height,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
         // spreadRadius:5,
          blurRadius: 20,
        ),
      ]
    ),
    child: InkWell(
      onTap: function,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: defaultColor,
              child: Center(
                child: child,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
      ),
    ),
  );
}



Widget buildSearchCategoryItem(CategoryModel model, context) => GestureDetector(
  onTap: () {
  },
  child: Container(
    height: 100.0,
    width: 100.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        15.0,
      ),
      color: Colors.white,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 15.0,
          child: Icon(
            model.iconData,
            size: 16.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          model.title,
          style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    ),
  ),
);

Widget buildCourseItems(course) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0,),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0,),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0,),
      child: ExpansionTileCard(
        baseColor: Colors.white,
        expandedColor: Colors.white,
        elevation: 0.0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),

                color:defaultColor,
                image: DecorationImage(image: NetworkImage(course['image']),),
              ),
              width: 60,
              height: 60,
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${course['title']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      // RatingBar.builder(
                      //   initialRating: 4.5,
                      //   minRating: 1,
                      //   direction: Axis.horizontal,
                      //   allowHalfRating: true,
                      //   itemCount: 5,
                      //   itemSize: 10.0,
                      //   ignoreGestures: true,
                      //   itemPadding: EdgeInsets.zero,
                      //   itemBuilder: (context, _) => Icon(
                      //     Icons.star,
                      //     color: Colors.amber,
                      //   ),
                      //   onRatingUpdate: (rating)
                      //   {
                      //     print(rating);
                      //   },
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${course['description']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onExpansionChanged: (value)
        {

        },
        children: <Widget>[
          Text('test'),
        ],
      ),
    ),
  );
}

Widget buildProfileItem({@required title, @required Widget shape,@required function}) => Expanded(
  child: GestureDetector(
    onTap: function,
    child: Container(
      height: 140.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 10,
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30.0,
            child: shape,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            title.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  ),
);
