import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:installment_calculator/core/network/local/cache_helper.dart';
import 'package:installment_calculator/features/form/form_cubit.dart';
import 'package:installment_calculator/features/form/form_screen.dart';
import 'package:installment_calculator/features/home/home_screen.dart';
import 'package:installment_calculator/features/sign_up/sign_up_cubit.dart';
import 'package:installment_calculator/features/sign_up/sign_up_screen.dart';
import 'core/utils/resources/bloc_observer.dart';
import 'features/home/home_cubit.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
   await Firebase.initializeApp();
   await CacheHelper.init();

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp() : super();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 720),
      builder: (context,child)=> MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => SignUpCubit()
          ),
          BlocProvider(
              create: (BuildContext context) => FormCubit()
          ),
          BlocProvider(
            create: (BuildContext context) => HomeCubit()
          ),
        ],
        child: MaterialApp(
          title: 'Installment Calculator',
          debugShowCheckedModeBanner: false,
          home: CacheHelper.getData(key: 'uId') != null?
          CacheHelper.getData(key: 'form')!= null? const HomeScreen():FormScreen()
          :
          const SignUpScreen(),
        ),
      ),
    );
  }
}