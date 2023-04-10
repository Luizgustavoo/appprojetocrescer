class Erros {
  final String key;

  static const Map<String, String> errors = {
    "USER_NOT_FOUND": "Usuário não encontrado!",
    "EMAIL_PASSWORD_INVALID": "Email e/ou senha invalido(s)!",
  };

  Erros(this.key);

  @override
  String toString() {
    if (errors.containsKey(key)) {
      return errors[key];
    } else {
      return "Erro na autenticação!";
    }
  }
}
