package com.example.adminapp.presentation.screens.material_screen

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Description
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material.icons.filled.Error
import androidx.compose.material.icons.filled.Image
import androidx.compose.material.icons.filled.Save
import androidx.compose.material.icons.filled.Straighten
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExposedDropdownMenuBox
import androidx.compose.material3.ExposedDropdownMenuDefaults
import androidx.compose.material3.FilterChip
import androidx.compose.material3.FilterChipDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.example.adminapp.data.model.SupplierDtoModel
import com.example.adminapp.data.model.TypeDtoModel
import com.example.adminapp.presentation.screens.material_list_screen.LoadingScreen
import com.example.adminapp.presentation.viewmodels.MaterialEditViewModel
import kotlinx.coroutines.flow.collectLatest
import org.koin.compose.viewmodel.koinViewModel
import kotlin.collections.find
import kotlin.collections.isNotEmpty

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MaterialEditScreen(
    materialId: Int? = null,
    onBackClick: () -> Unit,
    onSaveSuccess: () -> Unit,
    onDeleteSuccess: () -> Unit,
    modifier: Modifier = Modifier,
    viewModel: MaterialEditViewModel = koinViewModel()
) {
    // Состояния загрузки
    val isLoading by viewModel.isLoading.collectAsState()
    val isSaving by viewModel.isSaving.collectAsState()
    val isDeleting by viewModel.isDeleting.collectAsState()

    // Данные
    val types by viewModel.types.collectAsState()
    val suppliers by viewModel.suppliers.collectAsState()
    val error by viewModel.error.collectAsState()
    val showDeleteDialog by viewModel.showDeleteDialog.collectAsState()
    val showImageDialog by viewModel.showImageDialog.collectAsState()

    // Форма
    val name by viewModel.name.collectAsState()
    val nameError by viewModel.nameError.collectAsState()
    val typeId by viewModel.typeId.collectAsState()
    val typeError by viewModel.typeError.collectAsState()
    val width by viewModel.width.collectAsState()
    val widthError by viewModel.widthError.collectAsState()
    val height by viewModel.height.collectAsState()
    val heightError by viewModel.heightError.collectAsState()
    val imageUrl by viewModel.imageUrl.collectAsState()
    val supplierId by viewModel.supplierId.collectAsState()
    val supplierError by viewModel.supplierError.collectAsState()
    val isValid by viewModel.isValid.collectAsState()
    val isNew by viewModel.isNew.collectAsState()

    LaunchedEffect(Unit) {
       if (materialId != null) viewModel.loadMaterial(materialId)
        viewModel.uiEvents.collectLatest { event ->
            when (event) {
                MaterialEditViewModel.UiEvent.SaveSuccess -> {
                    onSaveSuccess()
                }
                MaterialEditViewModel.UiEvent.DeleteSuccess -> {
                    onDeleteSuccess()
                }
                is MaterialEditViewModel.UiEvent.Error -> {}
            }
        }
    }

    Scaffold(
        topBar = {
            MaterialEditTopBar(
                isNew = isNew,
                isLoading = isLoading || isSaving || isDeleting,
                isValid = isValid,
                onBackClick = onBackClick,
                onSaveClick = { viewModel.saveMaterial() },
                onDeleteClick = { viewModel.showDeleteDialog() },
                canDelete = !isNew
            )
        },
        modifier = modifier
    ) { paddingValues ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
        ) {
            when {
                isLoading -> {
                    LoadingScreen()
                }

                else -> {
                    MaterialEditForm(
                        name = name,
                        nameError = nameError,
                        typeId = typeId,
                        typeError = typeError,
                        width = width,
                        widthError = widthError,
                        height = height,
                        heightError = heightError,
                        imageUrl = imageUrl,
                        supplierId = supplierId,
                        supplierError = supplierError,
                        types = types,
                        suppliers = suppliers,
                        onUpdateName = viewModel::updateName,
                        onUpdateType = viewModel::updateType,
                        onUpdateWidth = viewModel::updateWidth,
                        onUpdateHeight = viewModel::updateHeight,
                        onUpdateImageUrl = viewModel::updateImageUrl,
                        onUpdateSupplier = viewModel::updateSupplier,
                        onImageClick = { viewModel.showImageDialog() }
                    )
                }
            }

            if (showDeleteDialog) {
                DeleteConfirmationDialog(
                    isDeleting = isDeleting,
                    onConfirm = { viewModel.deleteMaterial() },
                    onDismiss = { viewModel.hideDeleteDialog() }
                )
            }

            if (showImageDialog) {
                ImageUrlDialog(
                    currentUrl = imageUrl,
                    onConfirm = { url ->
                        viewModel.updateImageUrl(url)
                        viewModel.hideImageDialog()
                    },
                    onDismiss = { viewModel.hideImageDialog() }
                )
            }

            error?.let { errorMessage ->
                ErrorSnackbar(
                    message = errorMessage,
                    onDismiss = { viewModel.clearError() }
                )
            }
        }
    }
}