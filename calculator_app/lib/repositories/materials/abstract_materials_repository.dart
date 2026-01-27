import 'package:calculator_app/repositories/materials/models/filter.dart';
import 'package:calculator_app/repositories/materials/models/material_full_view/material.dart';
import 'package:calculator_app/repositories/materials/models/material_list_item/material_list_item.dart';
import 'package:calculator_app/repositories/materials/models/material_type/material_type.dart';
import 'package:calculator_app/repositories/materials/models/paginated_response/paginated_response.dart';
import 'package:calculator_app/repositories/materials/models/supplier/supplier.dart';

abstract interface class AbstractMaterialsRepository {
  Future<List<MaterialType>> getAllTypes();
  Future<List<Supplier>> getAllSuppliers();
  Future<PaginatedResponse<MaterialListItem>> getMaterials({
    required int offset,
    String? query,
    MaterialFilter? filter,
  });
  Future<MaterialFullView> singleMaterial(int id);
}
