class Book {
  final String id;
  final String title;
  final String author;
  final String isbn;
  final String publisher;
  final int pages;
  final String yearOfPublication;

  final String coverImage;
  final String description;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.publisher,
    required this.pages,
    required this.yearOfPublication,
    required this.coverImage,
    required this.description,
  });
}
