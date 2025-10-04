import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../login_page.dart';

part 'login_state.dart';
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser({required String email, required String password}) async {
    try {
      emit(LoginLoading()); // بنصدر حالة التحميل

      // استخدام email و password مباشرة بدون ! لأنهم "required"
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(LoginSuccess()); // بنصدر حالة النجاح لو التسجيل تم بنجاح

    } on FirebaseAuthException catch (e) {
      // هنا بنتعامل مع الأخطاء الخاصة بـ Firebase Authentication

      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage : 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMessage : 'كلمة المرور خاطئة.'));
      } else if (e.code == 'invalid-email') {
emit(LoginFailure(errorMessage: 'صيغة البريد الإلكتروني غير صحيحة.'));
      } else {
        emit(LoginFailure(errorMessage: 'حدث خطأ: ${e.message ?? "غير معروف"}'));
      }
    } catch (e) {
      // هنا بنتعامل مع أي أخطاء تانية مش خاصة بـ Firebase Authentication
      emit(LoginFailure(errorMessage : 'somthing worng'));
    }
  }
}




