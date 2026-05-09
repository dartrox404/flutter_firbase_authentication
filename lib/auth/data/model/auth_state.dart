class AuthState {
  final String name;
  final String email;
  final String password;
  final String? namerror;
  final String? emailerror;
  final String? passworderror;
  final bool isloading;
  final bool ispasswordhidden;

  AuthState({
    this.name = "",
    this.email = "",
    this.password = "",
    this.namerror,
    this.emailerror,
    this.passworderror,
    this.isloading = false,
    this.ispasswordhidden = true,
  });

  bool get loginValidation =>
      email.isNotEmpty &&
      password.isNotEmpty &&
      emailerror == null &&
      passworderror == null;

  bool get signupValidation =>
      email.isNotEmpty &&
      name.isNotEmpty &&
      password.isNotEmpty &&
      emailerror == null &&
      namerror == null &&
      passworderror == null;

  static const _auth = Object();

  AuthState copyWith({
    String? name,
    String? email,
    String? password,
    Object? emailerror,
    Object? namerror,
    Object? passworderror,
    bool? isloading,
    bool? ispasswordhidden,
  }) {
    return AuthState(
      isloading: isloading ?? this.isloading,
      ispasswordhidden: ispasswordhidden ?? this.ispasswordhidden,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      namerror: _auth == namerror ? this.namerror : namerror as String?,
      emailerror: _auth == emailerror ? this.emailerror : emailerror as String?,
      passworderror: _auth == passworderror
          ? this.passworderror
          : passworderror as String?,
    );
  }
}
