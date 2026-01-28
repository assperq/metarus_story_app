package com.example.adminapp.data.datasource.remote

import com.example.adminapp.data.model.MaterialListModelDto
import com.example.adminapp.data.model.PaginatedResponse
import com.example.adminapp.data.model.SimpleDataResponse
import com.example.adminapp.data.model.SimpleMaterialModel
import com.example.adminapp.data.model.SimpleResponse
import com.example.adminapp.data.model.SupplierDtoModel
import com.example.adminapp.data.model.TypeDtoModel
import com.google.gson.annotations.SerializedName
import retrofit2.http.Body
import retrofit2.http.DELETE
import retrofit2.http.GET
import retrofit2.http.PATCH
import retrofit2.http.PUT
import retrofit2.http.Path
import retrofit2.http.Query


interface MaterialService {
    @GET("materials")
    suspend fun getAllMaterials(
        @Query("type_ids") typeIds: List<Int>?,
        @Query("supplier_ids") supplierIds: List<Int>?,
        @Query("name") query: String?,
        @Query("offset") offset: Int
    ) : PaginatedResponse<MaterialListModelDto>

    @GET("materials/types")
    suspend fun getAllTypes() : SimpleDataResponse<TypeDtoModel>

    @GET("suppliers")
    suspend fun getAllSuppliers() : SimpleDataResponse<SupplierDtoModel>

    @GET("materials/simple/{id}")
    suspend fun getSingleMaterial(@Path("id") id: Int) : SimpleMaterialModel

    @PUT("materials/add")
    suspend fun addMaterial(@Body material: SimpleMaterialModel) : SimpleResponse
    @DELETE("materials/delete/{material_id}")
    suspend fun deleteMaterial(@Path("material_id") materialId: Int): SimpleResponse
    @PATCH("materials/patch")
    suspend fun updateMaterial(@Body new_material: SimpleMaterialModel) : SimpleResponse
}