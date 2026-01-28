package com.example.adminapp.data.model

import kotlinx.serialization.Serializable

@Serializable
data class PaginatedResponse<T>(
    val total: Int,
    val offset: Int,
    val data: List<T>
)
