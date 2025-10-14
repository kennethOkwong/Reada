import 'package:reada/features/stores/domain/entities/bookcase_entity.dart';
import 'package:reada/shared/helper_functions.dart';

class BookcaseDto {
  final int? id;
  final String? storeId;
  final String? title;
  final int? shelves;

  const BookcaseDto({
    this.id,
    this.storeId,
    this.title,
    this.shelves,
  });

  factory BookcaseDto.fromJson(Map<String, dynamic> json) {
    return BookcaseDto(
      id: HelperFunctions.safeCast<int>(json['id']),
      storeId: HelperFunctions.safeCast<String>(json['storeId']),
      title: HelperFunctions.safeCast<String>(json['title']),
      shelves: HelperFunctions.safeCast<int>(json['shelves']),
    );
  }

  factory BookcaseDto.empty() {
    return BookcaseDto(
      id: id,
      title: '',
      shelves: 0,
    );
  }

  BookcaseDto copyWith({
    String? caseId,
    String? title,
    int? shelves,
  }) {
    return BookcaseDto(
      caseId: caseId ?? this.caseId,
      title: title ?? this.title,
      shelves: shelves ?? this.shelves,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'caseId': caseId,
      'title': title,
      'shelves': shelves,
    };
  }

  Bookcase toDomain() {
    return Bookcase(
      id: id,
      storeId: storeId,
      title: title,
      shelvesCount: shelvesCount,
    );
  }
}
