import 'package:reada/app/locator.dart';
import 'package:reada/features/stores/domain/repository/store_repo.dart';
import 'package:reada/features/stores/domain/usecase/add_bookcase_usecase.dart';
import 'package:reada/features/stores/domain/usecase/add_store_usecase.dart';
import 'package:reada/features/stores/domain/usecase/get_book_details.dart';
import 'package:reada/features/stores/domain/usecase/get_bookcases_usecase.dart';
import 'package:reada/features/stores/domain/usecase/get_shelves_usecase.dart';
import 'package:reada/features/stores/domain/usecase/get_stores_usecase.dart';

final _storeRepository = locator<StoreRepository>();

/// usecases
final addStoreUseCase = AddStoreUseCase(_storeRepository);
final getStoresUseCase = GetStoresUseCase(_storeRepository);
final addBookcaseUseCase = AddBookcaseUseCase(_storeRepository);
final getBookcasesUseCase = GetBookcasesUseCase(_storeRepository);
final getShelvesUseCase = GetShelvesUseCase(_storeRepository);
final getBookDetailsUseCase = GetBookDetailsUseCase(_storeRepository);
