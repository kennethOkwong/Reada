import 'package:reada/app/result.dart';
import 'package:reada/features/stores/data/dtos/add_store_request_dto.dart';
import 'package:reada/features/stores/data/dtos/book_dto.dart';
import 'package:reada/features/stores/data/dtos/bookcase_dto.dart';
import 'package:reada/features/stores/data/dtos/shelf_dto.dart';
import 'package:reada/features/stores/data/dtos/store_dto.dart';

abstract class StoreDataSource {
  /// Create a new store
  Future<Success<StoreDto>> addStore({required AddStoreRequestDto requestData});

  /// Fetch all stores for the current user or organization
  Future<Success<List<StoreDto>>> getStores();

  /// Add a new bookcase to a store
  Future<Success<BookcaseDto>> addBookcase({required BookcaseDto data});

  /// Fetch all bookcases in a specific store
  Future<Success<List<BookcaseDto>>> getBookcases({required String storeId});

  /// Fetch all shelves within a specific bookcase
  Future<Success<List<ShelfDto>>> getShelves({required String bookcaseId});

  /// Fetch detailed information about a specific book
  Future<Success<BookDto>> getBookDetails({required String bookId});
}
