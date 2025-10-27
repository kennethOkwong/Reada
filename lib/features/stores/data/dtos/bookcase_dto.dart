import 'package:reada/features/stores/domain/entities/bookcase_entity.dart';
import 'package:reada/shared/helper_functions.dart';

class BookcaseDto {
  final int? id;
  final int? storeId;
  final String? title;
  final int? shelvesCount;

  const BookcaseDto({
    this.id,
    this.storeId,
    this.title,
    this.shelvesCount,
  });

  factory BookcaseDto.fromJson(Map<String, dynamic> json) {
    return BookcaseDto(
      id: HelperFunctions.safeCast<int>(json['id']),
      storeId: HelperFunctions.safeCast<int>(json['store_id']),
      title: HelperFunctions.safeCast<String>(json['title']),
      shelvesCount: HelperFunctions.safeCast<int>(json['shelves_count']),
    );
  }

  factory BookcaseDto.empty() {
    return const BookcaseDto();
  }

  BookcaseDto copyWith({
    int? id,
    int? storeId,
    String? title,
    int? shelvesCount,
  }) {
    return BookcaseDto(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      title: title ?? this.title,
      shelvesCount: shelvesCount ?? this.shelvesCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'title': title,
      'shelves_count': shelvesCount,
    };
  }

  Bookcase toDomain() {
    return Bookcase(
      id: HelperFunctions.requireField(id, 'id'),
      storeId: HelperFunctions.requireField(storeId, 'store_id'),
      title: HelperFunctions.requireField(title, 'title'),
      shelvesCount: HelperFunctions.requireField(shelvesCount, 'shelves_count'),
    );
  }
}
