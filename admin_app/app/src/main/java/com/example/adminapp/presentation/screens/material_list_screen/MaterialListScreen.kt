package com.example.adminapp.presentation.screens.material_list_screen

import android.util.Log
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.runtime.snapshotFlow
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.adminapp.presentation.viewmodels.MaterialsViewModel
import org.koin.compose.viewmodel.koinViewModel
import kotlin.collections.isNotEmpty

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MaterialsScreen(
    onMaterialClick: (Int) -> Unit,
    onAddClick: () -> Unit,
    modifier: Modifier = Modifier,
    viewModel: MaterialsViewModel = koinViewModel()
) {
    val materials by viewModel.materials.collectAsState()
    val types by viewModel.types.collectAsState()
    val suppliers by viewModel.suppliers.collectAsState()
    val filterState by viewModel.filterState.collectAsState()
    val isLoading by viewModel.isLoading.collectAsState()
    val isLoadingMore by viewModel.isLoadingMore.collectAsState()
    val hasMore by viewModel.hasMore.collectAsState()
    val showFilterDialog by viewModel.showFilterDialog.collectAsState()
    val error by viewModel.error.collectAsState()

    // Состояние для TextField
    var searchText by remember { mutableStateOf(filterState.searchQuery) }

    // Состояние LazyColumn
    val lazyListState = rememberLazyListState()

    LaunchedEffect(lazyListState, hasMore, isLoadingMore) {
        snapshotFlow { lazyListState.layoutInfo }
            .collect { layoutInfo ->
                val totalItemsCount = layoutInfo.totalItemsCount
                val visibleItemsInfo = layoutInfo.visibleItemsInfo

                if (visibleItemsInfo.isNotEmpty()) {
                    val lastVisibleItem = visibleItemsInfo.last()
                    val lastVisibleItemIndex = lastVisibleItem.index

                    // DEBUG
                    Log.d("PAGINATION",
                        "lastVisible: $lastVisibleItemIndex, total: $totalItemsCount, " +
                                "hasMore: $hasMore, isLoadingMore: $isLoadingMore")


                    if (lastVisibleItemIndex >= totalItemsCount - 1 &&
                        hasMore &&
                        !isLoadingMore) {
                        Log.d("PAGINATION", "Loading more materials...")
                        viewModel.loadMoreMaterials()
                    }
                }
            }
    }

    LaunchedEffect(filterState.searchQuery) {
        searchText = filterState.searchQuery
    }

    Scaffold(
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Материалы") },
                actions = {
                    IconButton(
                        onClick = { viewModel.refreshMaterials() },
                        enabled = !isLoading
                    ) {
                        Icon(Icons.Default.Refresh, contentDescription = "Обновить")
                    }
                }
            )
        },
        floatingActionButton = {
            FloatingActionButton(
                onClick = onAddClick
            ) {
                Icon(Icons.Default.Add, contentDescription = "Добавить")
            }
        },
        modifier = modifier
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
        ) {
            // Показать ошибку если есть
            error?.let { errorMessage ->
                ErrorMessage(
                    message = errorMessage,
                    onDismiss = { viewModel.dismissError() },
                    modifier = Modifier.padding(horizontal = 16.dp, vertical = 8.dp)
                )
            }

            // Поиск
            SearchBar(
                query = searchText,
                onQueryChange = { newText ->
                    searchText = newText
                    viewModel.onSearchQueryChanged(newText)
                },
                modifier = Modifier.padding(horizontal = 16.dp, vertical = 8.dp)
            )

            // Фильтры
            FilterSection(
                filterState = filterState,
                onFilterClick = { viewModel.showFilterDialog() },
                onClearFilter = viewModel::clearFilter,
                types = types,
                suppliers = suppliers,
                modifier = Modifier.padding(horizontal = 16.dp, vertical = 4.dp)
            )

            // Содержимое
            when {
                isLoading && materials.isEmpty() -> {
                    LoadingScreen(modifier = Modifier.fillMaxSize())
                }

                materials.isEmpty() -> {
                    EmptyState(
                        hasFilters = filterState.hasActiveFilters,
                        onClearFilters = { viewModel.clearFilter("all") },
                        modifier = Modifier.fillMaxSize()
                    )
                }

                else -> {
                    MaterialListWithPagination(
                        materials = materials,
                        isLoadingMore = isLoadingMore,
                        hasMore = hasMore,
                        onMaterialClick = onMaterialClick,
                        lazyListState = lazyListState,
                        modifier = Modifier.fillMaxSize()
                    )
                }
            }
        }

        // Диалог фильтров
        if (showFilterDialog) {
            FilterBottomSheet(
                types = types,
                suppliers = suppliers,
                filterState = filterState,
                onDismiss = { viewModel.dismissFilterDialog() },
                onApply = {
                    viewModel.applyFilter(it)
                    viewModel.dismissFilterDialog()
                },
                onClearAll = { viewModel.clearFilter("all") }
            )
        }
    }
}

@Composable
fun LoadingScreen(modifier: Modifier = Modifier) {
    Box(
        modifier = modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        CircularProgressIndicator()
    }
}


