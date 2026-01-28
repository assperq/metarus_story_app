package com.example.adminapp.presentation.viewmodels

import android.util.Log
import androidx.lifecycle.ViewModel
import com.example.adminapp.data.model.SimpleMaterialModel
import com.example.adminapp.domain.MaterialRepository
import com.example.adminapp.presentation.items.FilterState
import androidx.lifecycle.viewModelScope
import com.example.adminapp.data.model.MaterialListModelDto
import com.example.adminapp.data.model.SupplierDtoModel
import com.example.adminapp.data.model.TypeDtoModel
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch

class MaterialsViewModel(
    private val repository: MaterialRepository
) : ViewModel() {

    private val _materials = MutableStateFlow<List<MaterialListModelDto>>(emptyList())
    private val _types = MutableStateFlow<List<TypeDtoModel>>(emptyList())
    private val _suppliers = MutableStateFlow<List<SupplierDtoModel>>(emptyList())
    private val _filterState = MutableStateFlow(FilterState())
    private val _isLoading = MutableStateFlow(false)
    private val _isLoadingMore = MutableStateFlow(false)
    private val _hasMore = MutableStateFlow(true)
    private val _showFilterDialog = MutableStateFlow(false)
    private val _error = MutableStateFlow<String?>(null)

    val materials: StateFlow<List<MaterialListModelDto>> = _materials.asStateFlow()
    val types: StateFlow<List<TypeDtoModel>> = _types.asStateFlow()
    val suppliers: StateFlow<List<SupplierDtoModel>> = _suppliers.asStateFlow()
    val filterState: StateFlow<FilterState> = _filterState.asStateFlow()
    val isLoading: StateFlow<Boolean> = _isLoading.asStateFlow()
    val isLoadingMore: StateFlow<Boolean> = _isLoadingMore.asStateFlow()
    val hasMore: StateFlow<Boolean> = _hasMore.asStateFlow()
    val showFilterDialog: StateFlow<Boolean> = _showFilterDialog.asStateFlow()
    val error: StateFlow<String?> = _error.asStateFlow()

    private var currentPage = 0
    private val pageSize = 20
    private var searchJob: Job? = null

    init {
        loadInitialData()
    }

    private fun loadInitialData() {
        viewModelScope.launch {
            _isLoading.value = true
            try {
                loadTypesAndSuppliers()
                loadMaterials(resetPagination = true)
            } catch (e: Exception) {
                _error.value = e.message ?: "Ошибка загрузки"
            } finally {
                _isLoading.value = false
            }
        }
    }

    private suspend fun loadTypesAndSuppliers() {
        try {
            val typesResponse = repository.getAllTypes()
            val suppliersResponse = repository.getAllSuppliers()

            _types.value = typesResponse.data
            _suppliers.value = suppliersResponse.data
        } catch (e: Exception) {
            Log.d("Log", e.message.toString())
        }
    }

    private suspend fun loadMaterials(resetPagination: Boolean = false, loadMore: Boolean = false) {
        try {
            if (resetPagination) {
                currentPage = 0
                _hasMore.value = true
            }

            if (loadMore) {
                _isLoadingMore.value = true
            } else if (!resetPagination) {
                _isLoading.value = true
            }

            val filter = _filterState.value

            val response = repository.getAllMaterials(
                offset = currentPage * pageSize,
                typeIds = if (filter.selectedTypeIds.isNotEmpty())
                    filter.selectedTypeIds.toList() else null,
                supplierIds = if (filter.selectedSupplierIds.isNotEmpty())
                    filter.selectedSupplierIds.toList() else null,
                query = filter.searchQuery.ifEmpty { null }
            )

            val newMaterials = response.data
            val totalCount = response.total

            if (resetPagination) {
                _materials.value = newMaterials
            } else {
                _materials.value = _materials.value + newMaterials
            }

            _hasMore.value = totalCount != 0
            if (newMaterials.isNotEmpty()) {
                currentPage++
            }

            _error.value = null
        } catch (e: Exception) {
            _error.value = e.message ?: "Ошибка сети"
        } finally {
            _isLoading.value = false
            _isLoadingMore.value = false
        }
    }

    fun onSearchQueryChanged(query: String) {
        _filterState.value = _filterState.value.copy(searchQuery = query)

        searchJob?.cancel()
        searchJob = viewModelScope.launch {
            delay(500)
            loadMaterials(resetPagination = true)
        }
    }

    fun loadMoreMaterials() {
        if (!_isLoadingMore.value && _hasMore.value) {
            viewModelScope.launch {
                loadMaterials(loadMore = true)
            }
        }
    }

    fun refreshMaterials() {
        viewModelScope.launch {
            loadMaterials(resetPagination = true)
        }
    }

    fun showFilterDialog() {
        _showFilterDialog.value = true
    }

    fun dismissFilterDialog() {
        _showFilterDialog.value = false
    }

    fun applyFilter(newFilterState: FilterState) {
        _filterState.value = newFilterState
        viewModelScope.launch {
            loadMaterials(resetPagination = true)
        }
    }

    fun clearFilter(filterKey: String) {
        when {
            filterKey == "all" -> {
                _filterState.value = FilterState()
            }
            filterKey == "search" -> {
                _filterState.value = _filterState.value.copy(searchQuery = "")
            }
            filterKey.startsWith("type_") -> {
                val typeId = filterKey.removePrefix("type_").toIntOrNull()
                typeId?.let {
                    _filterState.value = _filterState.value.copy(
                        selectedTypeIds = _filterState.value.selectedTypeIds - it
                    )
                }
            }
            filterKey.startsWith("supplier_") -> {
                val supplierId = filterKey.removePrefix("supplier_").toIntOrNull()
                supplierId?.let {
                    _filterState.value = _filterState.value.copy(
                        selectedSupplierIds = _filterState.value.selectedSupplierIds - it
                    )
                }
            }
        }

        viewModelScope.launch {
            loadMaterials(resetPagination = true)
        }
    }

    fun dismissError() {
        _error.value = null
    }


//    suspend fun addMaterial(material: SimpleMaterialModel): Boolean {
//        return try {
//            val response = repository.addMaterial(material)
//            loadMaterials(resetPagination = true)
//            response.result
//        } catch (e: Exception) {
//            false
//        }
//    }
//
//    suspend fun deleteMaterial(materialId: Int): Boolean {
//        return try {
//            val response = repository.deleteMaterial(materialId)
//            loadMaterials(resetPagination = true)
//            response.result
//        } catch (e: Exception) {
//            false
//        }
//    }
//
//    suspend fun updateMaterial(material: SimpleMaterialModel): Boolean {
//        return try {
//            val response = repository.updateMaterial(material)
//            loadMaterials(resetPagination = true)
//            response.result
//        } catch (e: Exception) {
//            false
//        }
//    }
}