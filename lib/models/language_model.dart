class Languages {
  final Map<String, String> values;

  Languages({required this.values});

  factory Languages.fromJson(Map<String, dynamic> json) {
    return Languages(
      values: Map<String, String>.from(json),
    );
  }

  Map<String, dynamic> toJson() {
    return values;
  }
}
