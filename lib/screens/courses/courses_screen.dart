import 'package:conditional_builder/conditional_builder.dart';
import 'package:course_app/screens/courses/cubit/cubit.dart';
import 'package:course_app/screens/courses/cubit/states.dart';
import 'package:course_app/shared/colors/colors_common.dart';
import 'package:flutter/material.dart';
import 'package:course_app/shared/componentes/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CoursesCubit()..getCourses(),
      child: BlocConsumer<CoursesCubit, CoursesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var Courses = CoursesCubit.get(context).courses;
          return ConditionalBuilder(
            condition: state is! CoursesStatesLoading,
            builder: (context) => ConditionalBuilder(
              condition: state is! CoursesStatesError,
              builder: (context) => ConditionalBuilder(
                condition: Courses.length != 0,
                builder: (context) => Column(
                  children: [
                    // Container(
                    //   height: 100.0,
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 20.0,
                    //   ),
                    //   child: ListView.separated(
                    //     physics: BouncingScrollPhysics(),
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (context, index) =>
                       //      buildSearchCategoryItem(cat[index], context),
                    //     separatorBuilder: (context, index) => SizedBox(
                    //       width: 10.0,
                    //     ),
                    //     itemCount: cat.length,
                    //   ),
                    // ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        itemBuilder: (context, index) =>
                            buildCourseItems(Courses[index]),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 25.0,
                        ),
                        itemCount: Courses.length,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(),
                        if(state is! CoursesStatesLoadingMore && CoursesCubit.get(context).currentPage <= CoursesCubit.get(context).totalPage)
                        MaterialButton(
                          onPressed: (){
                            if( CoursesCubit.get(context).currentPage <= CoursesCubit.get(context).totalPage)
                            CoursesCubit.get(context).getMoreCourses();
                          } ,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Load more',style: TextStyle(color: Colors.white),),
                              SizedBox(width: 5,),
                              Icon(Icons.arrow_downward_rounded,color: Colors.white,size: 20,),
                            ],
                          ),
                          height: 40,
                          color: defaultColor,
                        ),
                        if(state is CoursesStatesLoadingMore)
                        CircularProgressIndicator(),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
                fallback: (context) => Center(
                  child: Text(
                    'No Courses Yet!!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              fallback: (context) => Center(
                child: Text(
                  'Error !!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
