String _toStr(dynamic v) {
  if (v == null) return '';
  if (v is String) return v;
  return v.toString();
}

String? _toStrOrNull(dynamic v) {
  if (v == null) return null;
  return _toStr(v);
}

int _toInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.parse(v);
  return 0;
}

bool _toBool(dynamic v) {
  if (v is bool) return v;
  if (v is int) return v == 1;
  if (v is String) return v.toLowerCase() == 'true' || v == '1';
  return false;
}

// ─── Modello Chitarra (sola lettura dal server) ───────────────────────────────
class Chitarra {
  String id;
  String nome;
  String tipo;
  String marca;
  int stelle;
  int corde;
  bool custodia;
  bool amplificatore;
  bool accordatore;
  bool mancina;
  String descrizione;

  Chitarra({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.marca,
    required this.stelle,
    required this.corde,
    required this.custodia,
    required this.amplificatore,
    required this.accordatore,
    required this.mancina,
    required this.descrizione,
  });

  factory Chitarra.fromJson(Map<String, dynamic> j) => Chitarra(
        id: _toStr(j['id']),
        nome: j['nome'] as String,
        tipo: j['tipo'] as String,
        marca: j['marca'] as String,
        stelle: _toInt(j['stelle']),
        corde: _toInt(j['corde']),
        custodia: _toBool(j['custodia']),
        amplificatore: _toBool(j['amplificatore']),
        accordatore: _toBool(j['accordatore']),
        mancina: _toBool(j['mancina']),
        descrizione: j['descrizione'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nome': nome,
        'tipo': tipo,
        'marca': marca,
        'stelle': stelle,
        'corde': corde,
        'custodia': custodia ? 1 : 0,
        'amplificatore': amplificatore ? 1 : 0,
        'accordatore': accordatore ? 1 : 0,
        'mancina': mancina ? 1 : 0,
        'descrizione': descrizione,
      };

  factory Chitarra.fromMap(Map<String, dynamic> m) => Chitarra(
        id: _toStr(m['id']),
        nome: m['nome'] as String,
        tipo: m['tipo'] as String,
        marca: m['marca'] as String,
        stelle: _toInt(m['stelle']),
        corde: _toInt(m['corde']),
        custodia: m['custodia'] == 1,
        amplificatore: m['amplificatore'] == 1,
        accordatore: m['accordatore'] == 1,
        mancina: m['mancina'] == 1,
        descrizione: m['descrizione'] as String,
      );
}

// ─── Modello Preferito ────────────────────────────────────────────────────────
class Preferito {
  String? id;
  String chitarraId;
  String note;
  String priorita;
  String dataAggiunta;

  Preferito({
    this.id,
    required this.chitarraId,
    required this.note,
    required this.priorita,
    required this.dataAggiunta,
  });

  factory Preferito.fromJson(Map<String, dynamic> j) => Preferito(
        id: _toStrOrNull(j['id']),
        chitarraId: _toStr(j['chitarraId']),
        note: j['note'] as String,
        priorita: j['priorita'] as String,
        dataAggiunta: j['dataAggiunta'] as String,
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'chitarraId': chitarraId,
        'note': note,
        'priorita': priorita,
        'dataAggiunta': dataAggiunta,
      };

  Map<String, dynamic> toMap() => toJson();

  factory Preferito.fromMap(Map<String, dynamic> m) => Preferito.fromJson(m);
}