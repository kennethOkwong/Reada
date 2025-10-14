import 'package:reada/features/stores/domain/entities/store_entity.dart';
import 'package:reada/shared/helper_functions.dart';

class StoreDto {
  final int? id;
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;

  StoreDto({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  /// JSON → DTO
  factory StoreDto.fromJson(Map<String, dynamic> json) {
    return StoreDto(
      id: HelperFunctions.safeCast<int>(json['id']),
      name: HelperFunctions.safeCast<String>(json['name']),
      address: HelperFunctions.safeCast<String>(json['address']),
      latitude: HelperFunctions.safeCast<double>(json['latitude']),
      longitude: HelperFunctions.safeCast<double>(json['longitude']),
    );
  }

  /// DTO → Domain
  Store toDomain() {
    return Store(
      id: HelperFunctions.requireField(id, 'id'),
      name: HelperFunctions.requireField(name, 'name'),
      address: HelperFunctions.requireField(address, 'address'),
      latitude: HelperFunctions.requireField(latitude, 'latitude'),
      longitude: HelperFunctions.requireField(longitude, 'longitude'),
    );
  }

  /// JSON List → DTO List
  static List<StoreDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => StoreDto.fromJson(json)).toList();
  }

  /// DTO List → Domain List
  static List<Store> toDomainList(List<StoreDto> list) {
    return list.map((value) => value.toDomain()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  StoreDto copyWith({
    int? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
  }) {
    return StoreDto(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
