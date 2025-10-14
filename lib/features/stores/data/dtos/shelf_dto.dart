import 'package:reada/features/stores/data/dtos/book_dto.dart';
import 'package:reada/features/stores/domain/entities/shelf_entity.dart';
import 'package:reada/shared/helper_functions.dart';

class ShelfDto {
  final String? id;
  final String? bookcaseId;
  final String? label;
  final List<BookDto>? books;

  ShelfDto({
    this.id,
    this.bookcaseId,
    this.label,
    this.books,
  });

  /// JSON → DTO
  factory ShelfDto.fromJson(Map<String, dynamic> json) {
    return ShelfDto(
      id: HelperFunctions.safeCast<String>(json['id']),
      bookcaseId: HelperFunctions.safeCast<String>(json['bookcase_id']),
      label: HelperFunctions.safeCast<String>(json['label']),
      books: json['books'] != null
          ? BookDto.fromJsonList(json['books'] as List<dynamic>)
          : [],
    );
  }

  /// DTO → Domain
  Shelf toDomain() {
    return Shelf(
      id: HelperFunctions.requireField(id, 'id'),
      bookcaseId: HelperFunctions.requireField(bookcaseId, 'bookcase_id'),
      label: HelperFunctions.requireField(label, 'label'),
      books: books != null ? BookDto.toDomainList(books!) : [],
    );
  }

  /// JSON List → DTO List
  static List<ShelfDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ShelfDto.fromJson(json)).toList();
  }

  /// DTO List → Domain List
  static List<Shelf> toDomainList(List<ShelfDto> list) {
    return list.map((value) => value.toDomain()).toList();
  }
}
