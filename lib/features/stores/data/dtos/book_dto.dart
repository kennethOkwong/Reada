import 'package:reada/features/stores/domain/entities/book_entity.dart';
import 'package:reada/shared/helper_functions.dart';

class BookDto {
  final String? id;
  final String? title;
  final String? author;
  final String? isbn;
  final String? publisher;
  final int? pages;
  final String? yearOfPublication;
  final String? coverImage;
  final String? description;

  BookDto({
    this.id,
    this.title,
    this.author,
    this.isbn,
    this.publisher,
    this.pages,
    this.yearOfPublication,
    this.coverImage,
    this.description,
  });

  /// JSON → DTO
  factory BookDto.fromJson(Map<String, dynamic> json) {
    return BookDto(
      id: HelperFunctions.safeCast<String>(json['id']),
      title: HelperFunctions.safeCast<String>(json['title']),
      author: HelperFunctions.safeCast<String>(json['author']),
      isbn: HelperFunctions.safeCast<String>(json['isbn']),
      publisher: HelperFunctions.safeCast<String>(json['publisher']),
      pages: HelperFunctions.safeCast<int>(json['pages']),
      yearOfPublication:
          HelperFunctions.safeCast<String>(json['year_of_publication']),
      coverImage: HelperFunctions.safeCast<String>(json['cover_image']),
      description: HelperFunctions.safeCast<String>(json['description']),
    );
  }

  /// DTO → Domain
  Book toDomain() {
    return Book(
      id: HelperFunctions.requireField(id, 'id'),
      title: HelperFunctions.requireField(title, 'title'),
      author: HelperFunctions.requireField(author, 'author'),
      isbn: HelperFunctions.requireField(isbn, 'isbn'),
      publisher: HelperFunctions.requireField(publisher, 'publisher'),
      pages: HelperFunctions.requireField(pages, 'pages'),
      yearOfPublication: HelperFunctions.requireField(
          yearOfPublication, 'year_of_publication'),
      coverImage: HelperFunctions.requireField(coverImage, 'cover_image'),
      description: HelperFunctions.requireField(description, 'description'),
    );
  }

  /// JSON List → DTO List
  static List<BookDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BookDto.fromJson(json)).toList();
  }

  /// DTO List → Domain List
  static List<Book> toDomainList(List<BookDto> list) {
    return list.map((value) => value.toDomain()).toList();
  }
}
