package com.example.adminapp.presentation.items

data class FilterState(
    val searchQuery: String = "",
    val selectedTypeIds: Set<Int> = emptySet(),
    val selectedSupplierIds: Set<Int> = emptySet(),
    val offset: Int = 0
) {
    val hasActiveFilters: Boolean
        get() = searchQuery.isNotEmpty() || selectedTypeIds.isNotEmpty() || selectedSupplierIds.isNotEmpty()
}