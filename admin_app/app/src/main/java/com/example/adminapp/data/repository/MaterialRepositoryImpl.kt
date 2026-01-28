package com.example.adminapp.data.repository

import com.example.adminapp.data.datasource.remote.MaterialService
import com.example.adminapp.data.model.MaterialListModelDto
import com.example.adminapp.data.model.PaginatedResponse
import com.example.adminapp.data.model.SimpleDataResponse
import com.example.adminapp.data.model.SimpleMaterialModel
import com.example.adminapp.data.model.SimpleResponse
import com.example.adminapp.data.model.SupplierDtoModel
import com.example.adminapp.data.model.TypeDtoModel
import com.example.adminapp.domain.MaterialRepository

class MaterialRepositoryImpl(
    val service: MaterialService
) : MaterialRepository {
    override suspend fun getAllMaterials(
        offset: Int,
        typeIds: List<Int>?,
        supplierIds: List<Int>?,
        query: String?,
    ): PaginatedResponse<MaterialListModelDto> {
        return service.getAllMaterials(
            typeIds, supplierIds, query, offset
        )
    }

    override suspend fun getAllTypes(): SimpleDataResponse<TypeDtoModel> {
        return service.getAllTypes()
    }

    override suspend fun getAllSuppliers(): SimpleDataResponse<SupplierDtoModel> {
        return service.getAllSuppliers()
    }

    override suspend fun getSingleMaterial(id: Int): SimpleMaterialModel {
        return service.getSingleMaterial(id)
    }

    override suspend fun addMaterial(material: SimpleMaterialModel): SimpleResponse {
        return service.addMaterial(material)
    }

    override suspend fun deleteMaterial(materialId: Int): SimpleResponse {
        return service.deleteMaterial(materialId)
    }

    override suspend fun updateMaterial(newMaterial: SimpleMaterialModel): SimpleResponse {
        return service.updateMaterial(newMaterial)
    }
}