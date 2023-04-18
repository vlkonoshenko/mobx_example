import 'package:mobx/mobx.dart';
import 'package:mobx_example/utils/shared_preferences_helper.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final SharedPreferencesHelper _sp = SharedPreferencesHelper();

  @observable
  bool loading = false;

  @action
  void login() {
    loading = true;
    Future.delayed(const Duration(seconds: 2));
    loading = false;
    _sp.set('IS_LOGIN', true);
    isLoggedIn = true;
  }

  @action
  void signUp() {
    loading = true;
    Future.delayed(const Duration(seconds: 2));
    loading = false;
    isLoggedIn = true;
  }

  @action
  Future<void> checkLogin() async {
    isLoggedIn = await _sp.get('IS_LOGIN', false);
  }

  @observable
  String email = "";

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = "";

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get isFormValid => email.length > 6 && password.length > 6;

  @observable
  bool? isLoggedIn;

  @action
  void loggout() {
    isLoggedIn = false;
    loading = false;
    email = '';
    _sp.set('IS_LOGIN', false);
    password = '';
  }
}
