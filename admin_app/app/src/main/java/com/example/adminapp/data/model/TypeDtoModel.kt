package com.example.adminapp.data.model

import kotlinx.serialization.Serializable

@Serializable
data class TypeDtoModel(
    val id: Int,
    val name: String,
)

@Serializable
data class SupplierDtoModel(
    val id: Int,
    val name: String,
)