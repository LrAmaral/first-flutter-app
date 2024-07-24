class Aula {
  final String data;
  final String descricao;

  Aula({required this.data, required this.descricao});

  static List<Aula> gerarAulas(String codigoDisciplina) {
    if (codigoDisciplina == 'ALGD1') {
      return [
        Aula(data: '07/08/09', descricao: 'Introdução a Algoritmos'),
        Aula(data: '14/08/09', descricao: 'Estruturas de Dados'),
        // Adicione mais aulas conforme necessário
      ];
    }
    // Adicione mais verificações para outras disciplinas conforme necessário
    return [];
  }
}
