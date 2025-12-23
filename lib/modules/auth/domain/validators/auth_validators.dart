class AuthValidators {
  static String? validateEmail(String email) {
    final v = email.trim();
    if (v.isEmpty) return 'please_enter_email';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(v)) return 'invalid_email';
    return null;
  }

  static String? validatePassword(String password) {
    final v = password.trim();
    if (v.isEmpty) return 'please_enter_password';
    // إذا بدك حد أدنى
    if (v.length < 6) return 'weak_password';
    return null;
  }
}
