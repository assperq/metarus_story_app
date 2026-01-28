package com.example.adminapp.data.model

import kotlinx.serialization.Serializable

@Serializable
data class SimpleResponse(
    val result: Boolean
)

@Serializable
data class SimpleDataResponse<T>(
    val data : List<T>
)