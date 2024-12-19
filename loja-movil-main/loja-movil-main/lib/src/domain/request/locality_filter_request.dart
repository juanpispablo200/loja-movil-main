class LocalityFilterRequest {
  int? parishId;
  int? categoryId;
  int? routeId;

  LocalityFilterRequest({
    this.parishId,
    this.categoryId,
    this.routeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'parishId': parishId,
      'categoryId': categoryId,
      'routeId': routeId,
    };
  }
}
