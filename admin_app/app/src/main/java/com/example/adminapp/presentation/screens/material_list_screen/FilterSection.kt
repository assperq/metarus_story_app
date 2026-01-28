package com.example.adminapp.presentation.screens.material_list_screen

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Clear
import androidx.compose.material3.FilterChip
import androidx.compose.material3.FilterChipDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.InputChip
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.adminapp.data.model.SupplierDtoModel
import com.example.adminapp.data.model.TypeDtoModel
import com.example.adminapp.presentation.items.FilterState
import kotlin.collections.forEach

@Composable
fun FilterSection(
    filterState: FilterState,
    onFilterClick: () -> Unit,
    onClearFilter: (String) -> Unit,
    types: List<TypeDtoModel>,
    suppliers: List<SupplierDtoModel>,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier) {
        // Кнопка фильтров
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            FilterChip(
                selected = filterState.hasActiveFilters,
                onClick = onFilterClick,
                label = {
                    Text(
                        text = if (filterState.hasActiveFilters) "Фильтры ✓" else "Фильтры",
                        style = MaterialTheme.typography.labelMedium
                    )
                },
                colors = FilterChipDefaults.filterChipColors(
                    selectedContainerColor = MaterialTheme.colorScheme.primary,
                    selectedLabelColor = MaterialTheme.colorScheme.onPrimary
                )
            )

            if (filterState.hasActiveFilters) {
                TextButton(
                    onClick = { onClearFilter("all") }
                ) {
                    Text("Сбросить все")
                }
            }
        }

        // Активные фильтры
        if (filterState.hasActiveFilters) {
            FlowRow(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(top = 8.dp),
                horizontalArrangement = Arrangement.spacedBy(8.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                // Поиск
                if (filterState.searchQuery.isNotEmpty()) {
                    InputChip(
                        selected = true,
                        onClick = { onClearFilter("search") },
                        label = {
                            Text("Поиск: ${filterState.searchQuery}")
                        },
                        trailingIcon = {
                            Icon(Icons.Default.Clear, contentDescription = "Удалить")
                        }
                    )
                }

                // Типы
                types.forEach { type ->
                    if (filterState.selectedTypeIds.contains(type.id)) {
                        InputChip(
                            selected = true,
                            onClick = { onClearFilter("type_${type.id}") },
                            label = { Text(type.name) },
                            trailingIcon = {
                                Icon(Icons.Default.Clear, contentDescription = "Удалить")
                            }
                        )
                    }
                }

                // Поставщики
                suppliers.forEach { supplier ->
                    if (filterState.selectedSupplierIds.contains(supplier.id)) {
                        InputChip(
                            selected = true,
                            onClick = { onClearFilter("supplier_${supplier.id}") },
                            label = { Text(supplier.name) },
                            trailingIcon = {
                                Icon(Icons.Default.Clear, contentDescription = "Удалить")
                            }
                        )
                    }
                }
            }
        }
    }
}