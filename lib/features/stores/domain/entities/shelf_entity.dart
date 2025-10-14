import 'package:reada/features/stores/domain/entities/book_entity.dart';

class Shelf {
  final String id;
  final String bookcaseId;
  final String label;
  final List<Book> books;

  Shelf({
    required this.id,
    required this.bookcaseId,
    required this.label,
    required this.books,
  });
}
