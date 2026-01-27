import 'package:calculator_app/repositories/materials/abstract_materials_repository.dart';
import 'package:calculator_app/repositories/materials/models/api_endpoints.dart';
import 'package:calculator_app/repositories/materials/models/filter.dart';
import 'package:calculator_app/repositories/materials/models/material_full_view/material.dart';
import 'package:calculator_app/repositories/materials/models/material_list_item/material_list_item.dart';
import 'package:calculator_app/repositories/materials/models/material_type/material_type.dart';
import 'package:calculator_app/repositories/materials/models/paginated_response/paginated_response.dart';
import 'package:calculator_app/repositories/materials/models/simple_response/simple_response.dart';
import 'package:calculator_app/repositories/materials/models/supplier/supplier.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class MaterialsRepositoryImpl implements AbstractMaterialsRepository {
  @override
  Future<PaginatedResponse<MaterialListItem>> getMaterials({
    required int offset,
    String? query,
    MaterialFilter? filter,
  }) async {
    final dio = GetIt.I<Dio>();
    final queryParameters = <String, dynamic>{ApiParameters.offset: offset};

    if (query != null && query.isNotEmpty) {
      queryParameters[ApiParameters.search] = query;
    }

    if (filter != null) {
      if (filter.typeIds != null && filter.typeIds!.isNotEmpty) {
        queryParameters[ApiParameters.type] = filter.typeIds!;
      }
      if (filter.supplierIds != null && filter.supplierIds!.isNotEmpty) {
        queryParameters[ApiParameters.supplier] = filter.supplierIds!;
      }
    }

    final response = await dio.get(
      ApiEndpoints.materials,
      queryParameters: queryParameters,
    );

    return PaginatedResponse.fromJson(
      response.data,
      (json) => MaterialListItem.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<List<Supplier>> getAllSuppliers() async {
    var res = await _getData(ApiEndpoints.suppliers);
    return SimpleResponse<Supplier>.fromJson(
      res.data,
      (json) => Supplier.fromJson(json as Map<String, dynamic>),
    ).data;
  }

  @override
  Future<List<MaterialType>> getAllTypes() async {
    var res = await _getData(ApiEndpoints.types);
    return SimpleResponse<MaterialType>.fromJson(
      res.data,
      (json) => MaterialType.fromJson(json as Map<String, dynamic>),
    ).data;
  }

  @override
  Future<MaterialFullView> singleMaterial(int id) async {
    var res = await _getData(ApiEndpoints.materialsById(id));
    return MaterialFullView.fromJson(res.data);
  }

  Future<Response<dynamic>> _getData(
    String path, [
    int offset = 0,
    int limit = 20,
  ]) async {
    return await GetIt.I<Dio>().get(
      path,
      queryParameters: {
        ApiParameters.offset: offset,
        ApiParameters.limit: limit,
      },
    );
  }
}
