class Formater {
  static String formatarNumeroCelular(String numero) {
    // Remove todos os caracteres não numéricos do número
    String numerosApenas = numero.replaceAll(RegExp(r'[^\d]'), '');

    // Verifica se o número possui um DDD (com 2 dígitos) e um número de celular (com 9 dígitos)
    if (numerosApenas.length == 11) {
      // Formatação com DDD e número de celular (exemplo: (11) 91234-5678)
      return '(${numerosApenas.substring(0, 2)}) ${numerosApenas.substring(2, 7)}-${numerosApenas.substring(7)}';
    } else if (numerosApenas.length == 9) {
      // Formatação somente com o número de celular (exemplo: 91234-5678)
      return '${numerosApenas.substring(0, 5)}-${numerosApenas.substring(5)}';
    } else {
      // Retorna o número original se não puder ser formatado
      return numero;
    }
  }

  static String formatarRG(String rg) {
    // Remove todos os caracteres não numéricos do RG
    String numerosApenas = rg.replaceAll(RegExp(r'[^\d]'), '');

    // Verifica se o número possui pelo menos 8 dígitos
    if (numerosApenas.length >= 8) {
      // Formatação do RG com pontos e hífen (exemplo: 12.345.678-9)
      String rgFormatado = numerosApenas.substring(0, 2) +
          '.' +
          numerosApenas.substring(2, 5) +
          '.' +
          numerosApenas.substring(5, 8);

      // Caso tenha mais de 8 dígitos, adiciona o dígito verificador
      if (numerosApenas.length > 8) {
        rgFormatado += '-' + numerosApenas.substring(8);
      }

      return rgFormatado;
    } else {
      // Retorna o RG original se não puder ser formatado
      return rg;
    }
  }

  static String formatarCPF(String cpf) {
    // Remove todos os caracteres não numéricos do CPF
    String numerosApenas = cpf.replaceAll(RegExp(r'[^\d]'), '');

    // Verifica se o número possui 11 dígitos
    if (numerosApenas.length == 11) {
      // Formatação do CPF com pontos e hífen (exemplo: 123.456.789-09)
      String cpfFormatado = numerosApenas.substring(0, 3) +
          '.' +
          numerosApenas.substring(3, 6) +
          '.' +
          numerosApenas.substring(6, 9) +
          '-' +
          numerosApenas.substring(9);

      return cpfFormatado;
    } else {
      // Retorna o CPF original se não puder ser formatado
      return cpf;
    }
  }

  static String formatarCEP(String cep) {
    // Remove espaços em branco e caracteres não numéricos do CEP
    String numerosApenas = cep.replaceAll(RegExp(r'[^\d]'), '');

    // Verifica se o CEP possui 8 dígitos
    if (numerosApenas.length == 8) {
      // Formatação do CEP com hífen (exemplo: 12345-678)
      String cepFormatado =
          numerosApenas.substring(0, 5) + '-' + numerosApenas.substring(5);
      return cepFormatado;
    } else {
      // Retorna o CEP original se não puder ser formatado
      return cep;
    }
  }

  static String formatarTelefoneFixo(String telefone) {
    // Remove espaços em branco e caracteres não numéricos do telefone fixo
    String numerosApenas = telefone.replaceAll(RegExp(r'[^\d]'), '');

    // Verifica se o telefone fixo possui pelo menos 8 dígitos
    if (numerosApenas.length >= 8) {
      // Formatação do telefone fixo com o DDD (se houver) e o número (exemplo: (11) 1234-5678)
      if (numerosApenas.length == 8) {
        // Número sem DDD
        return '${numerosApenas.substring(0, 4)}-${numerosApenas.substring(4)}';
      } else {
        // Número com DDD
        return '(${numerosApenas.substring(0, 2)}) ${numerosApenas.substring(2, 6)}-${numerosApenas.substring(6)}';
      }
    } else {
      // Retorna o número de telefone original se não puder ser formatado
      return telefone;
    }
  }
}
