class Todo {
  int id;
  String nome;
  String endereco;
  String cidade;
  String estado;
  int cep;
  int fone;
  int celular;
  bool zap1;
  bool zap2;
  bool aviso1;
  bool aviso2;
  bool aviso3;
  bool aviso4;
  bool aviso5;
  bool aviso6;

  Todo({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.cidade,
    required this.estado,
    required this.cep,
    required this.fone,
    required this.celular,
    required this.zap1,
    required this.zap2,
    required this.aviso1,
    required this.aviso2,
    required this.aviso3,
    required this.aviso4,
    required this.aviso5,
    required this.aviso6,
  });

  factory Todo.fromJson(Map<String, dynamic> map) {
    return Todo(
        id: map['id'],
        nome: map['nome'.toString()],
        endereco: map['endereco'.toString()],
        cidade: map['cidade'.toString()],
        estado: map['estado'.toString()],
        cep: map['cep'],
        fone: map['fone'],
        celular: map['celular'],
        zap1: map['zap1'],
        zap2: map['zap2'],
        aviso1: map['aviso1'],
        aviso2: map['aviso2'],
        aviso3: map['aviso3'],
        aviso4: map['aviso4'],
        aviso5: map['aviso5'],
        aviso6: map['aviso6']);
  }

  Map<String, dynamic> toJson() => {
        id.toString(): id,
        nome: nome,
        endereco: endereco,
        cidade: cidade,
        estado: estado,
        cep.toString(): cep,
        fone.toString(): fone,
        celular.toString(): celular,
        zap1.toString(): zap1,
        zap2.toString(): zap2,
        aviso1.toString(): aviso1,
        aviso2.toString(): aviso2,
        aviso3.toString(): aviso3,
        aviso4.toString(): aviso4,
        aviso5.toString(): aviso5,
        aviso6.toString(): aviso6,
      };
}

class Historico {
  int hisid;
  DateTime createdAt;
  int hisIdPaciente;
  String hisPathThumb;
  String hisPathServer;
  bool hisfoto;

  Historico({
    required this.hisid,
    required this.createdAt,
    required this.hisIdPaciente,
    required this.hisPathThumb,
    required this.hisPathServer,
    required this.hisfoto,
  });

  factory Historico.fromJson(Map<String, dynamic> map) {
    return Historico(
      hisid: map['his_id'],
      createdAt: map['his_createdAt'.toString()],
      hisIdPaciente: map['his_idPaciente'.toString()],
      hisPathThumb: map['his_idPathThumb'.toString()],
      hisPathServer: map['his_idPathServer'.toString()],
      hisfoto: map['his_foto'.toString()],
    );
  }
}
