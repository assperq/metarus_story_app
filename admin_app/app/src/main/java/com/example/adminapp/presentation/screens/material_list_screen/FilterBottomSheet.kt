package com.example.adminapp.presentation.screens.material_list_screen

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Clear
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.BottomSheetDefaults
import androidx.compose.material3.Button
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FilterChip
import androidx.compose.material3.FilterChipDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.rememberModalBottomSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.adminapp.data.model.SupplierDtoModel
import com.example.adminapp.data.model.TypeDtoModel
import com.example.adminapp.presentation.items.FilterState
import kotlin.collections.forEach

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun FilterBottomSheet(
    types: List<TypeDtoModel>,
    suppliers: List<SupplierDtoModel>,
    filterState: FilterState,
    onDismiss: () -> Unit,
    onApply: (FilterState) -> Unit,
    onClearAll: () -> Unit,
) {
    var localSearchQuery by remember { mutableStateOf(filterState.searchQuery) }
    var localSelectedTypeIds by remember { mutableStateOf(filterState.selectedTypeIds) }
    var localSelectedSupplierIds by remember { mutableStateOf(filterState.selectedSupplierIds) }

    ModalBottomSheet(
        onDismissRequest = onDismiss,
        sheetState =  rememberModalBottomSheetState(),
        dragHandle = { BottomSheetDefaults.DragHandle() }
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp)
                .verticalScroll(rememberScrollState()),
            verticalArrangement = Arrangement.spacedBy(24.dp)
        ) {
            // Заголовок
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = "Фильтры",
                    style = MaterialTheme.typography.titleLarge
                )

                if (filterState.hasActiveFilters) {
                    TextButton(
                        onClick = {
                            localSearchQuery = ""
                            localSelectedTypeIds = emptySet()
                            localSelectedSupplierIds = emptySet()
                            onClearAll()
                        }
                    ) {
                        Text("Сбросить все")
                    }
                }
            }

            // Поиск
            OutlinedTextField(
                value = localSearchQuery,
                onValueChange = { localSearchQuery = it },
                modifier = Modifier.fillMaxWidth(),
                label = { Text("Поиск по названию") },
                leadingIcon = {
                    Icon(Icons.Default.Search, contentDescription = "Поиск")
                },
                trailingIcon = {
                    if (localSearchQuery.isNotEmpty()) {
                        IconButton(
                            onClick = { localSearchQuery = "" }
                        ) {
                            Icon(Icons.Default.Clear, contentDescription = "Очистить")
                        }
                    }
                },
                singleLine = true
            )

            // Типы материалов
            if (types.isNotEmpty()) {
                Column(
                    verticalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    Text(
                        text = "Типы материалов",
                        style = MaterialTheme.typography.titleMedium
                    )

                    FlowRow(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(8.dp),
                        verticalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        types.forEach { type ->
                            FilterChip(
                                selected = localSelectedTypeIds.contains(type.id),
                                onClick = {
                                    localSelectedTypeIds = if (localSelectedTypeIds.contains(type.id)) {
                                        localSelectedTypeIds - type.id
                                    } else {
                                        localSelectedTypeIds + type.id
                                    }
                                },
                                label = { Text(type.name) },
                                colors = FilterChipDefaults.filterChipColors(
                                    selectedContainerColor = MaterialTheme.colorScheme.primary,
                                    selectedLabelColor = MaterialTheme.colorScheme.onPrimary
                                )
                            )
                        }
                    }
                }
            }

            // Поставщики
            if (suppliers.isNotEmpty()) {
                Column(
                    verticalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    Text(
                        text = "Поставщики",
                        style = MaterialTheme.typography.titleMedium
                    )

                    FlowRow(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(8.dp),
                        verticalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        suppliers.forEach { supplier ->
                            FilterChip(
                                selected = localSelectedSupplierIds.contains(supplier.id),
                                onClick = {
                                    localSelectedSupplierIds = if (localSelectedSupplierIds.contains(supplier.id)) {
                                        localSelectedSupplierIds - supplier.id
                                    } else {
                                        localSelectedSupplierIds + supplier.id
                                    }
                                },
                                label = { Text(supplier.name) },
                                colors = FilterChipDefaults.filterChipColors(
                                    selectedContainerColor = MaterialTheme.colorScheme.primary,
                                    selectedLabelColor = MaterialTheme.colorScheme.onPrimary
                                )
                            )
                        }
                    }
                }
            }

            // Кнопки действий
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(vertical = 16.dp),
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                OutlinedButton(
                    onClick = onDismiss,
                    modifier = Modifier.weight(1f)
                ) {
                    Text("Отмена")
                }

                Button(
                    onClick = {
                        val newFilterState = FilterState(
                            searchQuery = localSearchQuery,
                            selectedTypeIds = localSelectedTypeIds,
                            selectedSupplierIds = localSelectedSupplierIds
                        )
                        onApply(newFilterState)
                    },
                    modifier = Modifier.weight(1f)
                ) {
                    Text("Применить")
                }
            }
        }
    }
}