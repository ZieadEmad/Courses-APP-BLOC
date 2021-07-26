import 'package:course_app/screens/profile/cubit/states.dart';
import 'package:course_app/shared/componentes/components.dart';
import 'package:course_app/shared/network/local/shared_prefrence.dart';
import 'package:course_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileStates> {

  ProfileCubit() : super(ProfileStatesInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

   var profile = {};
  getProfile(){
    emit(ProfileStatesLoading());

    DioHelper.postData(
        path: 'lms/api/v1/my-account',
        token: getToken(),

    ).then((value) {
      emit(ProfileStatesSuccess());
      // print(value);
      profile=value.data['result'] ;
      print('=========== ${profile['image']}');
       //print(value.data['result']['']);
      // print(value.data['result']);
      // print(value.data['result']['full_name']);
    }).catchError((e)
    {
      emit(ProfileStatesError(e.toString()));
      print(e.toString());
    });
  }


}