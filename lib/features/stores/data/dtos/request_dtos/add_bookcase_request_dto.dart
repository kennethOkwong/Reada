class AddBookcaseRequestDto {
  final int? storeId;
  final String? title;
  final int? shelvesCount;

  const AddBookcaseRequestDto({
    this.storeId,
    this.title,
    this.shelvesCount,
  });

  factory AddBookcaseRequestDto.empty() {
    return const AddBookcaseRequestDto(shelvesCount: 1);
  }

  AddBookcaseRequestDto copyWith({
    int? storeId,
    String? title,
    int? shelvesCount,
  }) {
    return AddBookcaseRequestDto(
      title: title ?? this.title,
      storeId: storeId ?? this.storeId,
      shelvesCount: shelvesCount ?? this.shelvesCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store_id': storeId,
      'title': title,
      'shelves_count': shelvesCount,
    };
  }
}
