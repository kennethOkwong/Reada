import 'dart:convert';
import 'dart:developer';

import 'package:reada/app/result.dart';
import 'package:reada/features/stores/data/data_source/store_data_source.dart';
import 'package:reada/features/stores/data/dtos/add_store_request_dto.dart';
import 'package:reada/features/stores/data/dtos/book_dto.dart';
import 'package:reada/features/stores/data/dtos/bookcase_dto.dart';
import 'package:reada/features/stores/data/dtos/shelf_dto.dart';
import 'package:reada/features/stores/data/dtos/store_dto.dart';
import 'package:reada/services/api%20service/error_handling/exception_handler.dart';
import 'package:reada/services/api%20service/error_handling/exceptions.dart';
import 'package:reada/services/local_storage_service.dart';

class StoreLocalDataSource implements StoreDataSource {
  final LocalStorageService _localStorageService = LocalStorageService();

  /// ---------------------------
  /// STORE METHODS
  /// ---------------------------

  @override
  Future<Success<StoreDto>> addStore({
    required AddStoreRequestDto requestData,
  }) async {
    try {
      final storeKey =
          await _localStorageService.getUserScopedKey(LocalStorageKeys.store);

      final value = await _localStorageService.getStorageValue(storeKey);
      final stores = value != null
          ? (jsonDecode(value) as List)
              .map((e) => StoreDto.fromJson(e))
              .toList()
          : <StoreDto>[];

      final idx = stores.indexWhere(
          (s) => s.name?.toLowerCase() == requestData.storeName?.toLowerCase());
      if (idx >= 0) {
        throw const ReadaUnknownException(
            message: "Store with the same name already exists");
      }
      final id = stores.length + 1;
      StoreDto dto = StoreDto.fromJson(requestData.toJson());
      StoreDto dtoWithId = dto.copyWith(id: id);
      stores.add(dtoWithId);

      await _localStorageService.saveStorageValue(
        storeKey,
        jsonEncode(
          stores.map((e) => e.toJson()).toList(),
        ),
      );
      return Success(data: dtoWithId);
    } catch (e, s) {
      throw ExceptionHandler.mapToReadaException(e, s);
    }
  }

  @override
  Future<Success<List<StoreDto>>> getStores() async {
    try {
      log('Here');

      final storeKey =
          await _localStorageService.getUserScopedKey(LocalStorageKeys.store);
      log(storeKey);
      final value = await _localStorageService.getStorageValue(storeKey);
      if (value == null) return const Success(data: <StoreDto>[]);
      log(value);
      final decoded = jsonDecode(value) as List;
      final stores = decoded.map((e) => StoreDto.fromJson(e)).toList();

      return Success(data: stores);
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      throw ExceptionHandler.mapToReadaException(e, s);
    }
  }

  /// ---------------------------
  /// BOOKCASE METHODS
  /// ---------------------------

  @override
  Future<Success<BookcaseDto>> addBookcase({required BookcaseDto data}) async {
    try {
      final key = await _localStorageService
          .getUserScopedKey(LocalStorageKeys.bookcase);

      final value = await _localStorageService.getStorageValue(key);
      final bookcases = value != null
          ? (jsonDecode(value) as List)
              .map((e) => BookcaseDto.fromJson(e))
              .toList()
          : <BookcaseDto>[];

      final idx = bookcases.indexWhere((b) => b.title == data.title);
      if (idx >= 0) {
        bookcases[idx] = data;
      } else {
        bookcases.add(data);
      }

      await _localStorageService.saveStorageValue(
        key,
        jsonEncode(bookcases.map((e) => e.toJson()).toList()),
      );

      return Success(data: data);
    } catch (e, s) {
      throw ExceptionHandler.mapToReadaException(e, s);
    }
  }

  @override
  Future<Success<List<BookcaseDto>>> getBookcases(
      {required String storeId}) async {
    try {
      final key = await _localStorageService
          .getUserScopedKey(LocalStorageKeys.bookcase);
      final value = await _localStorageService.getStorageValue(key);
      if (value == null) return const Success(data: <BookcaseDto>[]);

      final decoded = jsonDecode(value) as List;
      final bookcases = decoded
          .map((e) => BookcaseDto.fromJson(e))
          .where((b) => b.storeId == storeId)
          .toList();

      return Success(data: bookcases);
    } catch (e, s) {
      throw ExceptionHandler.mapToReadaException(e, s);
    }
  }

  /// ---------------------------
  /// SHELF METHODS
  /// ---------------------------

  @override
  Future<Success<List<ShelfDto>>> getShelves(
      {required String bookcaseId}) async {
    try {
      final key =
          await _localStorageService.getUserScopedKey(LocalStorageKeys.shelf);
      final value = await _localStorageService.getStorageValue(key);
      if (value == null) return const Success(data: <ShelfDto>[]);

      final decoded = jsonDecode(value) as List;
      final shelves = decoded
          .map((e) => ShelfDto.fromJson(e))
          .where((s) => s.bookcaseId == bookcaseId)
          .toList();

      return Success(data: shelves);
    } catch (e, s) {
      throw ExceptionHandler.mapToReadaException(e, s);
    }
  }

  /// ---------------------------
  /// BOOK METHODS
  /// ---------------------------

  @override
  Future<Success<BookDto>> getBookDetails({required String bookId}) async {
    try {
      final key =
          await _localStorageService.getUserScopedKey(LocalStorageKeys.book);
      final value = await _localStorageService.getStorageValue(key);
      if (value == null) {
        throw Exception("Book not found");
      }

      final decoded = jsonDecode(value) as List;
      final books = decoded.map((e) => BookDto.fromJson(e)).toList();

      final book = books.firstWhere(
        (b) => b.id == bookId,
        orElse: () => throw Exception("Book not found"),
      );

      return Success(data: book);
    } catch (e, s) {
      throw ExceptionHandler.mapToReadaException(e, s);
    }
  }
}
