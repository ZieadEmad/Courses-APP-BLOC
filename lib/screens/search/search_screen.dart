import 'package:conditional_builder/conditional_builder.dart';
import 'package:course_app/screens/search/cubit/cubit.dart';
import 'package:course_app/screens/search/cubit/states.dart';
import 'package:course_app/shared/colors/colors_common.dart';
import 'package:course_app/shared/componentes/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(

        listener: (context,state){},
        builder: (context,state){

          var searchCourse =SearchCubit.get(context).searchCourse;

          return Scaffold(
            body:  Column(
              children: [
                SizedBox(height: 20),
                buildSearchTextForm(context: context,searchController: searchController),
                SizedBox(height: 20),
                buildListViewCategories(),
                SizedBox(height: 40),
                buildListOFProducts(searchCourse: searchCourse, state: state)
              ],
            ),
          );
        },
      ),
    );
  }
  Widget buildSearchTextForm({context,searchController})=>  Container(
    margin: EdgeInsets.all(10),
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: 10, right: 80, top: 10, bottom: 10),
          width: 400,
          height: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Colors.white,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Start Search...',
            ),
            keyboardType: TextInputType.text,
            controller: searchController,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 330),
          child: InkWell(
            onTap: () {
              SearchCubit.get(context).getCourses(searchController.text);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: defaultColor,
                  borderRadius: BorderRadius.circular(16)),
              width: 70,
              height: 58,
              child: Center(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
  Widget buildListViewCategories()=> Container(
    height: 100.0,
    padding: EdgeInsets.symmetric(
      horizontal: 20.0,
    ),
    child: ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) =>
          buildSearchCategoryItem(cat[index], context),
      separatorBuilder: (context, index) => SizedBox(
        width: 10.0,
      ),
      itemCount: cat.length,
    ),
  );
  Widget buildListOFProducts({state,searchCourse})=>  Expanded(
    child: ConditionalBuilder(
      condition: state is! SearchStatesLoading,
      builder: (context)=>  ConditionalBuilder(
        condition: searchCourse.length > 0,
        builder: (context)=> ListView.separated(
          // physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          itemBuilder: (context, index) =>
              buildCourseItems(searchCourse[index]),
          separatorBuilder: (context, index) => SizedBox(
            height: 25.0,
          ),
          itemCount: searchCourse.length,
        ),
        fallback: (context)=> Center(
          child: Text('No Courses Found',
            style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 16,
            ),),
        ),
      ),
      fallback: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
