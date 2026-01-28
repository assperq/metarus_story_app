package com.example.adminapp.data.model

import com.google.gson.annotations.SerializedName
import kotlinx.serialization.Serializable

@Serializable
data class SimpleMaterialModel(
    val id: Int,
    val name: String,
    @SerializedName("type_id") val typeId: Int,
    val width: Float,
    val height: Float,
    @SerializedName("image_url") val imageUrl: String,
    @SerializedName("supplier_id") val supplierId: Int,
)
