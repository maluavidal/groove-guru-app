class RegisterFailure {
  final String message;

  RegisterFailure([this.message = "Um erro ocorreu, tente novamente"]);

  factory RegisterFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return RegisterFailure('Por favor coloque uma Senha mais Forte.');
      case 'invalid-email':
        return RegisterFailure(
            'O Email não é válido ou está digitado incorretamente.');
      case 'email-already-in-use':
        return RegisterFailure('Uma conta já existe com esse Email.');
      case 'operation-not-allowed':
        return RegisterFailure('Ação não disponível, contate o Suporte.');
      case 'user-disabled':
        return RegisterFailure(
            'Seu usuário foi desabilitado, por favor entre em contato com o Suporte.');
      default:
        return RegisterFailure();
    }
  }
}
