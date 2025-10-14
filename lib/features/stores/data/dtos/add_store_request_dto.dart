import 'package:reada/features/stores/data/dtos/bookcase_dto.dart';

class AddStoreRequestDto {
  final String? storeName;
  final String? storeAddress;
  final String? latitude;
  final String? longitude;

  const AddStoreRequestDto({
    this.storeName,
    this.storeAddress,
    this.latitude,
    this.longitude,
  });

  factory AddStoreRequestDto.empty() {
    return const AddStoreRequestDto(
      storeName: '',
      storeAddress: '',
      latitude: '',
      longitude: '',
    );
  }

  AddStoreRequestDto copyWith({
    String? storeName,
    String? storeAddress,
    String? latitude,
    String? longitude,
    List<BookcaseDto>? bookcases,
  }) {
    return AddStoreRequestDto(
      storeName: storeName ?? this.storeName,
      storeAddress: storeAddress ?? this.storeAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': storeName,
      'address': storeAddress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
