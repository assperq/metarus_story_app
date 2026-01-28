package com.example.adminapp.data.model

import com.google.gson.annotations.SerializedName
import kotlinx.serialization.Serializable

@Serializable
data class MaterialListModelDto(
    val id: Int,
    val name: String,
    val type: String,
    val width: Float,
    val height: Float,
    @SerializedName("image_url") val imageUrl: String,
    val supplier: String,
)
