
import 'package:get_it/get_it.dart';

import '../auth/auth_bloc/auth_cubit.dart';
import '../auth/auth_repo/auth_repo.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthRepo>(AuthRepo());
  getIt.registerSingleton<AuthCubit>(AuthCubit(authRepo: getIt()));
}
