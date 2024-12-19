class IdRequest {
  int? id;

  IdRequest({
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
