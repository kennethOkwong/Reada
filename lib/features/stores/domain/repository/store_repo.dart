import 'package:reada/app/result.dart';
import 'package:reada/features/stores/data/dtos/request_dtos/add_bookcase_request_dto.dart';
import 'package:reada/features/stores/data/dtos/request_dtos/add_store_request_dto.dart';
import 'package:reada/features/stores/domain/entities/book_entity.dart';
import 'package:reada/features/stores/domain/entities/bookcase_entity.dart';
import 'package:reada/features/stores/domain/entities/shelf_entity.dart';
import 'package:reada/features/stores/domain/entities/store_entity.dart';

abstract class StoreRepository {
  /// Create a new store
  Future<Success<Store>> addStore({required AddStoreRequestDto data});

  /// Fetch all stores for the current user or organization
  Future<Success<List<Store>>> getStores();

  /// Add a new bookcase to a store
  Future<Success<Bookcase>> addBookcase(
      {required AddBookcaseRequestDto requestData});

  /// Fetch all bookcases in a specific store
  Future<Success<List<Bookcase>>> getBookcases({required int storeId});

  /// Fetch all shelves within a specific bookcase
  Future<Success<List<Shelf>>> getShelves({required String bookcaseId});

  /// Fetch detailed information about a specific book
  Future<Success<Book>> getBookDetails({required String bookId});
}
