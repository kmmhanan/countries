class Flag {
  final String png;
  final String svg;
  final String alt;

  Flag({
    required this.png,
    required this.svg,
    required this.alt,
  });

  factory Flag.fromJson(Map<String, dynamic> json) {
    return Flag(
      png: json['png'],
      svg: json['svg'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'png': png,
      'svg': svg,
      'alt': alt,
    };
  }
}
