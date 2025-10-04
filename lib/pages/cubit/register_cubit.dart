import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());


  Future<void> registerUser({required String email,required String password}) async {
    try {
      emit(RegisterLoading());
      UserCredential user = await FirebaseAuth.
      instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!);
      emit(RegisterSuccess());

    } on FirebaseAuthException catch (e) {
      // هنا بنتعامل مع الأخطاء الخاصة بـ Firebase Authentication

      if (e.code == 'user-not-found') {
        emit(RegisterFailure(errorMessage : 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(RegisterFailure(errorMessage : 'كلمة المرور خاطئة.'));
      } else if (e.code == 'invalid-email') {
        emit(RegisterFailure(errorMessage: 'صيغة البريد الإلكتروني غير صحيحة.'));
      } else {
        emit(RegisterFailure(errorMessage: 'حدث خطأ: ${e.message ?? "غير معروف"}'));
      }
    }catch(e){
      emit(RegisterFailure(errorMessage: 'try again ${e.toString()}'));
    }
  }

}
