class Word {
  final String value;
  String meaning;
  List<String>? answers;

  Word({
    required this.value,
    required this.meaning,
    this.answers,
  }) {
    formatMeaning(meaning);
  }

  formatMeaning(String meaning) {
      final RegExp exp = RegExp(r"<[^>]*>");
      this.meaning = meaning.replaceAll(exp, '').replaceAll('\n', '');
  }
}
