import 'package:reada/app/result.dart';
import 'package:reada/features/stores/data/data_source/store_data_source.dart';
import 'package:reada/features/stores/data/dtos/add_store_request_dto.dart';
import 'package:reada/features/stores/data/dtos/bookcase_dto.dart';
import 'package:reada/features/stores/domain/entities/book_entity.dart';
import 'package:reada/features/stores/domain/entities/bookcase_entity.dart';
import 'package:reada/features/stores/domain/entities/shelf_entity.dart';
import 'package:reada/features/stores/domain/entities/store_entity.dart';
import 'package:reada/features/stores/domain/repository/store_repo.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreDataSource storeDataSource;

  StoreRepositoryImpl(this.storeDataSource);

  @override
  Future<Success<Store>> addStore({required AddStoreRequestDto data}) async {
    final response = await storeDataSource.addStore(requestData: data);
    final domain = response.data!.toDomain();
    return Success(data: domain);
  }

  @override
  Future<Success<List<Store>>> getStores() async {
    final response = await storeDataSource.getStores();
    final domain = response.data!.map((dto) => dto.toDomain()).toList();
    return Success(data: domain);
  }

  @override
  Future<Success<BookcaseDto>> addBookcase({required BookcaseDto data}) async {
    return await storeDataSource.addBookcase(data: data);
  }

  @override
  Future<Success<List<Bookcase>>> getBookcases(
      {required String storeId}) async {
    final response = await storeDataSource.getBookcases(storeId: storeId);
    final domain = response.data!.map((dto) => dto.toDomain()).toList();
    return Success(data: domain);
  }

  @override
  Future<Success<List<Shelf>>> getShelves({required String bookcaseId}) async {
    final response = await storeDataSource.getShelves(bookcaseId: bookcaseId);
    final domain = response.data!.map((dto) => dto.toDomain()).toList();
    return Success(data: domain);
  }

  @override
  Future<Success<Book>> getBookDetails({required String bookId}) async {
    final response = await storeDataSource.getBookDetails(bookId: bookId);
    final domain = response.data!.toDomain();
    return Success(data: domain);
  }
}
