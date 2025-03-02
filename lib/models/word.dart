class Word {
  final String value;
  String meaning;

  Word({
    required this.value,
    required this.meaning,
  }) {
    formatMeaning(meaning);
  }

  formatMeaning(String meaning) {
      final RegExp exp = RegExp(r"<[^>]*>");
      this.meaning = meaning.replaceAll(exp, '').replaceAll('\n', '');
  }
}
