package com.example.adminapp.domain

import com.example.adminapp.data.model.MaterialListModelDto
import com.example.adminapp.data.model.PaginatedResponse
import com.example.adminapp.data.model.SimpleDataResponse
import com.example.adminapp.data.model.SimpleMaterialModel
import com.example.adminapp.data.model.SimpleResponse
import com.example.adminapp.data.model.SupplierDtoModel
import com.example.adminapp.data.model.TypeDtoModel
import retrofit2.http.Query


interface MaterialRepository {
    suspend fun getAllMaterials(
        offset: Int,
        typeIds: List<Int>? = null,
        supplierIds: List<Int>? = null,
        query: String? = null,
    ) : PaginatedResponse<MaterialListModelDto>
    suspend fun getAllTypes() : SimpleDataResponse<TypeDtoModel>
    suspend fun getAllSuppliers() : SimpleDataResponse<SupplierDtoModel>

    suspend fun getSingleMaterial(id: Int) : SimpleMaterialModel

    suspend fun addMaterial(material: SimpleMaterialModel) : SimpleResponse
    suspend fun deleteMaterial(materialId: Int) : SimpleResponse
    suspend fun updateMaterial(newMaterial: SimpleMaterialModel) : SimpleResponse
}