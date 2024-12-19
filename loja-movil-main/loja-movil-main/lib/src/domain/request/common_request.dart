class CommonRequest {
  int? id;
  String? criteria;

  CommonRequest({
    this.id,
    this.criteria,
  });

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'criteria': criteria,
    };
  }
}
