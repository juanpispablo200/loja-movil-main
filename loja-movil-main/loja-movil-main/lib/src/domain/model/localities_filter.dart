class LocaltiesFilter {
  int id;
  String name;
  String code;
  String? icon;

  LocaltiesFilter({required this.id, required this.name, required this.code, this.icon});

  factory LocaltiesFilter.fromJson(Map<String, dynamic> json) => LocaltiesFilter(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "icon": icon,
      };
}
