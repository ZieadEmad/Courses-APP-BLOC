import 'package:course_app/screens/courses/cubit/states.dart';
import 'package:course_app/shared/componentes/components.dart';
import 'package:course_app/shared/network/local/shared_prefrence.dart';
import 'package:course_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesCubit extends Cubit<CoursesStates> {

  CoursesCubit() : super(CoursesStatesInitial());

  static CoursesCubit get(context) => BlocProvider.of(context);

List courses = [];
int totalPage = 0 ;
int currentPage = 1 ;

  getCourses(){
    emit(CoursesStatesLoading());

    DioHelper.postData(
        path: 'lms/api/v1/courses',
      token: getToken(),
      query:
      {
      'page': currentPage ,
      }

    ).then((value) {
      emit(CoursesStatesSuccess());
      courses=value.data['result']['data'] as List;

      currentPage ++;
      totalPage = value.data['result']['last_page'];

     print(value.data.toString());
    }).catchError((e)
    {
      emit(CoursesStatesError(e.toString()));
      print(e.toString());
    });
  }

  getMoreCourses(){
    emit(CoursesStatesLoadingMore());
    DioHelper.postData(
        path: 'lms/api/v1/courses',
        token: getToken(),
        query:
        {
          'page':currentPage ,
        }

    ).then((value) {
      emit(CoursesStatesSuccess());
      courses.addAll(value.data['result']['data'] as List);
      currentPage ++;
      print(value.data.toString());
    }).catchError((e)
    {
      emit(CoursesStatesError(e.toString()));
      print(e.toString());
    });
  }

}