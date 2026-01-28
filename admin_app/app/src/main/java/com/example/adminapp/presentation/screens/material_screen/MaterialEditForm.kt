package com.example.adminapp.presentation.screens.material_screen

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Description
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.adminapp.data.model.SupplierDtoModel
import com.example.adminapp.data.model.TypeDtoModel

@Composable
fun MaterialEditForm(
    name: String,
    nameError: String?,
    typeId: Int,
    typeError: String?,
    width: String,
    widthError: String?,
    height: String,
    heightError: String?,
    imageUrl: String,
    supplierId: Int,
    supplierError: String?,
    types: List<TypeDtoModel>,
    suppliers: List<SupplierDtoModel>,
    onUpdateName: (String) -> Unit,
    onUpdateType: (Int) -> Unit,
    onUpdateWidth: (String) -> Unit,
    onUpdateHeight: (String) -> Unit,
    onUpdateImageUrl: (String) -> Unit,
    onUpdateSupplier: (Int) -> Unit,
    onImageClick: () -> Unit,
    modifier: Modifier = Modifier
) {
    Column(
        modifier = modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState())
            .padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(20.dp)
    ) {
        SectionTitle(text = "Основная информация")
        OutlinedTextField(
            value = name,
            onValueChange = onUpdateName,
            modifier = Modifier.fillMaxWidth(),
            label = { Text("Название материала *") },
            isError = nameError != null,
            supportingText = { nameError?.let { Text(it) } },
            singleLine = true,
            leadingIcon = {
                Icon(Icons.Default.Description, contentDescription = null)
            }
        )

        SectionTitle(text = "Тип материала *")
        if (types.isNotEmpty()) {
            TypesGrid(
                types = types,
                selectedTypeId = typeId,
                onTypeSelected = onUpdateType
            )
            typeError?.let {
                Text(
                    text = it,
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.error,
                    modifier = Modifier.padding(top = 4.dp)
                )
            }
        } else {
            Text(
                text = "Типы не загружены",
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }

        SectionTitle(text = "Размеры (метры)")
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            DimensionField(
                value = width,
                onValueChange = onUpdateWidth,
                label = "Ширина *",
                error = widthError,
                modifier = Modifier.weight(1f)
            )

            DimensionField(
                value = height,
                onValueChange = onUpdateHeight,
                label = "Высота *",
                error = heightError,
                modifier = Modifier.weight(1f)
            )
        }

        SectionTitle(text = "Изображение")
        ImageUrlField(
            imageUrl = imageUrl,
            onImageClick = onImageClick,
            modifier = Modifier.fillMaxWidth()
        )

        SectionTitle(text = "Поставщик *")
        if (suppliers.isNotEmpty()) {
            SupplierDropdown(
                suppliers = suppliers,
                selectedSupplierId = supplierId,
                onSupplierSelected = onUpdateSupplier,
                error = supplierError,
                modifier = Modifier.fillMaxWidth()
            )
        } else {
            Text(
                text = "Поставщики не загружены",
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }

        Spacer(modifier = Modifier.height(20.dp))
    }
}