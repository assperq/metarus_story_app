package com.example.adminapp.presentation.viewmodels

import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.adminapp.data.model.SimpleMaterialModel
import com.example.adminapp.data.model.SupplierDtoModel
import com.example.adminapp.data.model.TypeDtoModel
import com.example.adminapp.domain.MaterialRepository
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch

class MaterialEditViewModel(
    private val repository: MaterialRepository
) : ViewModel() {

    // Состояния загрузки
    private val _isLoading = MutableStateFlow(true)
    private val _isSaving = MutableStateFlow(false)
    private val _isDeleting = MutableStateFlow(false)

    // Данные
    private val _types = MutableStateFlow<List<TypeDtoModel>>(emptyList())
    private val _suppliers = MutableStateFlow<List<SupplierDtoModel>>(emptyList())

    // Форма
    private val _id = MutableStateFlow(0)
    private val _name = MutableStateFlow("")
    private val _typeId = MutableStateFlow(0)
    private val _width = MutableStateFlow("")
    private val _height = MutableStateFlow("")
    private val _imageUrl = MutableStateFlow("")
    private val _supplierId = MutableStateFlow(0)

    // Ошибки валидации
    private val _nameError = MutableStateFlow<String?>(null)
    private val _typeError = MutableStateFlow<String?>(null)
    private val _widthError = MutableStateFlow<String?>(null)
    private val _heightError = MutableStateFlow<String?>(null)
    private val _supplierError = MutableStateFlow<String?>(null)

    private val _error = MutableStateFlow<String?>(null)

    private val _showDeleteDialog = MutableStateFlow(false)
    private val _showImageDialog = MutableStateFlow(false)

    private val _uiEvents = MutableSharedFlow<UiEvent>()

    val isLoading: StateFlow<Boolean> = _isLoading.asStateFlow()
    val isSaving: StateFlow<Boolean> = _isSaving.asStateFlow()
    val isDeleting: StateFlow<Boolean> = _isDeleting.asStateFlow()
    val types: StateFlow<List<TypeDtoModel>> = _types.asStateFlow()
    val suppliers: StateFlow<List<SupplierDtoModel>> = _suppliers.asStateFlow()
    val error: StateFlow<String?> = _error.asStateFlow()
    val showDeleteDialog: StateFlow<Boolean> = _showDeleteDialog.asStateFlow()
    val showImageDialog: StateFlow<Boolean> = _showImageDialog.asStateFlow()

    // Публичные поля формы
    val id: StateFlow<Int> = _id.asStateFlow()
    val name: StateFlow<String> = _name.asStateFlow()
    val nameError: StateFlow<String?> = _nameError.asStateFlow()
    val typeId: StateFlow<Int> = _typeId.asStateFlow()
    val typeError: StateFlow<String?> = _typeError.asStateFlow()
    val width: StateFlow<String> = _width.asStateFlow()
    val widthError: StateFlow<String?> = _widthError.asStateFlow()
    val height: StateFlow<String> = _height.asStateFlow()
    val heightError: StateFlow<String?> = _heightError.asStateFlow()
    val imageUrl: StateFlow<String> = _imageUrl.asStateFlow()
    val supplierId: StateFlow<Int> = _supplierId.asStateFlow()
    val supplierError: StateFlow<String?> = _supplierError.asStateFlow()

    val isNew: StateFlow<Boolean> = _id.map { it == 0 }.stateIn(
        scope = viewModelScope,
        started = SharingStarted.WhileSubscribed(5000),
        initialValue = true
    )

    val isValid: StateFlow<Boolean> = combine(
        _name, _typeId, _width, _height, _supplierId
    ) { name, typeId, width, height, supplierId ->
        name.isNotBlank() &&
                typeId > 0 &&
                width.toFloatOrNull() != null &&
                height.toFloatOrNull() != null &&
                supplierId > 0
    }.stateIn(
        scope = viewModelScope,
        started = SharingStarted.WhileSubscribed(5000),
        initialValue = false
    )

    val uiEvents: SharedFlow<UiEvent> = _uiEvents.asSharedFlow()

    sealed class UiEvent {
        data object SaveSuccess : UiEvent()
        data object DeleteSuccess : UiEvent()
        data class Error(val message: String) : UiEvent()
    }

    init {
        loadData()
    }

    private fun loadData() {
        _isLoading.value = true

        viewModelScope.launch {
            try {
                loadTypes()
                loadSuppliers()
            } catch (e: Exception) {
                _error.value = e.message ?: "Ошибка загрузки"
            } finally {
                _isLoading.value = false
            }
        }
    }

    private suspend fun loadTypes() {
        try {
            val response = repository.getAllTypes()
            _types.value = response.data
        } catch (e: Exception) {
            _error.value = e.message ?: "Ошибка загрузки"
        }
    }

    private suspend fun loadSuppliers() {
        try {
            val response = repository.getAllSuppliers()
            _suppliers.value = response.data
        } catch (e: Exception) {
            _error.value = e.message ?: "Ошибка загрузки"
        }
    }

    suspend fun loadMaterial(id: Int) {
        try {
            val material = repository.getSingleMaterial(id)
            _id.value = material.id
            _name.value = material.name
            _typeId.value = material.typeId
            _width.value = material.width.toString()
            _height.value = material.height.toString()
            _imageUrl.value = material.imageUrl
            _supplierId.value = material.supplierId
        } catch (e: Exception) {
            _error.value = e.message ?: "Ошибка загрузки материала"
        }
    }

    fun updateName(name: String) {
        _name.value = name
        _nameError.value = null
    }

    fun updateType(typeId: Int) {
        _typeId.value = typeId
        _typeError.value = null
    }

    fun updateWidth(width: String) {
        _width.value = width
        _widthError.value = null
    }

    fun updateHeight(height: String) {
        _height.value = height
        _heightError.value = null
    }

    fun updateImageUrl(url: String) {
        _imageUrl.value = url
    }

    fun updateSupplier(supplierId: Int) {
        _supplierId.value = supplierId
        _supplierError.value = null
    }

    // Валидация
    private fun validateForm(): Boolean {
        var isValid = true

        if (_name.value.isBlank()) {
            _nameError.value = "Введите название"
            isValid = false
        }

        if (_typeId.value <= 0) {
            _typeError.value = "Выберите тип"
            isValid = false
        }

        if (_width.value.isBlank()) {
            _widthError.value = "Введите ширину"
            isValid = false
        } else if (_width.value.toFloatOrNull() == null || _width.value.toFloat() <= 0) {
            _widthError.value = "Некорректная ширина"
            isValid = false
        }

        if (_height.value.isBlank()) {
            _heightError.value = "Введите высоту"
            isValid = false
        } else if (_height.value.toFloatOrNull() == null || _height.value.toFloat() <= 0) {
            _heightError.value = "Некорректная высота"
            isValid = false
        }

        if (_supplierId.value <= 0) {
            _supplierError.value = "Выберите поставщика"
            isValid = false
        }

        return isValid
    }

    private fun toSimpleMaterialModel(): SimpleMaterialModel {
        return SimpleMaterialModel(
            id = _id.value,
            name = _name.value.trim(),
            typeId = _typeId.value,
            width = _width.value.toFloat(),
            height = _height.value.toFloat(),
            imageUrl = _imageUrl.value.trim(),
            supplierId = _supplierId.value
        )
    }

    fun saveMaterial() {
        viewModelScope.launch {
            if (!validateForm()) return@launch

            _isSaving.value = true
            _error.value = null

            try {
                val material = toSimpleMaterialModel()
                val success = if (_id.value > 0) {
                    updateMaterial(material)
                } else {
                    addMaterial(material)
                }

                if (success) {
                    _uiEvents.emit(UiEvent.SaveSuccess)
                } else {
                    _uiEvents.emit(UiEvent.Error("Не удалось сохранить материал"))
                }
            } catch (e: Exception) {
                _uiEvents.emit(UiEvent.Error(e.message ?: "Ошибка сохранения"))
            } finally {
                _isSaving.value = false
            }
        }
    }

    private suspend fun addMaterial(material: SimpleMaterialModel): Boolean {
        return try {
            val response = repository.addMaterial(material)
            if (response.result) {
                _id.value = material.id
                true
            } else {
                false
            }
        } catch (e: Exception) {
            false
        }
    }

    private suspend fun updateMaterial(material: SimpleMaterialModel): Boolean {
        return try {
            val response = repository.updateMaterial(material)
            response.result
        } catch (e: Exception) {
            false
        }
    }

    fun showDeleteDialog() {
        _showDeleteDialog.value = true
    }

    fun hideDeleteDialog() {
        _showDeleteDialog.value = false
    }

    fun deleteMaterial() {
        viewModelScope.launch {
            val materialId = _id.value
            if (materialId <= 0) return@launch
            _isDeleting.value = true

            try {
                val response = repository.deleteMaterial(materialId)

                if (response.result) {
                    _uiEvents.emit(UiEvent.DeleteSuccess)
                } else {
                    _uiEvents.emit(UiEvent.Error("Не удалось удалить материал"))
                }
            } catch (e: Exception) {
                Log.d("LOG", "DELETING: ${e.message}")
                _uiEvents.emit(UiEvent.Error(e.message ?: "Ошибка удаления"))
            } finally {
                _isDeleting.value = false
                _showDeleteDialog.value = false
            }
        }
    }

    fun showImageDialog() {
        _showImageDialog.value = true
    }

    fun hideImageDialog() {
        _showImageDialog.value = false
    }

    fun clearError() {
        _error.value = null
    }
}