class Constants {
  //static const String IP = '192.168.25.50';
  static const String IP = 'projetocrescer.ddns.net';

  static const String TITLE_APP = 'PROJETO CRESCER';

  static const String URL_LIST_PENALIDADES = 'http://' +
      IP +
      '/sistemaalunos/penalidade/listagempormatricula/matricula';

  static const String URL_LIST_USUARIOS =
      'http://' + IP + '/sistemaalunos/usuario/listarusuarioapp';

  static const String URL_FOTOS =
      'http://' + IP + '/sistemaalunos//web-pages/documentos/fotos/';

  static const String URL_LIST_PENDENCIAS = 'http://' +
      IP +
      '/sistemaalunos/pendencias/listagempormatricula/matricula/';

  static const String URL_LIST_FREQUENCIA = 'http://' +
      IP +
      '/sistemaalunos/frequencia/listagempormatricula/matricula/';

  static const String URL_AGENDAMENTO =
      'http://' + IP + '/sistemaalunos/agendamentoatendimento/cadastrar';

  static const String URL_LIST_AGENDAMENTOS = 'http://' +
      IP +
      '/sistemaalunos/agendamentoatendimento/listagempormatricula/matricula';

  // static const String URL_HORARIOS_ATENDIMENTO = 'http://' +
  //     IP +
  //     '/sistemaalunos/horariosatendimento/listartodosbeforetoday/';

  static const String URL_COMUNICADOS = 'http://' +
      IP +
      '/sistemaalunos/comunicado/listagempormatricula/matricula/';
  static const String URL_VIEW_COMUNICADO =
      'http://' + IP + '/sistemaalunos/comunicado/visualizarcomunicado/';

  static const String URL_AGENDAR_REFEICAO =
      'http://' + IP + '/confirmarrefeicao/refeicao/agendarpeloapp/';

  /*Implementado depois*/
  static const String URL_DADOS_ALUNO =
      'http://' + IP + '/sistemaalunos/api/aluno/matricula/';
}
