package com.example.adminapp.presentation.navigation

import android.R.attr.defaultValue
import android.R.attr.type
import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.navArgument
import com.example.adminapp.presentation.screens.material_list_screen.MaterialsScreen
import com.example.adminapp.presentation.screens.material_screen.MaterialEditScreen
import com.example.adminapp.presentation.viewmodels.MaterialsViewModel
import org.koin.compose.viewmodel.koinViewModel


@Composable
fun SetupNavigationGraph(navHostController: NavHostController, viewModel: MaterialsViewModel = koinViewModel()) {
    NavHost(navHostController, Route.Home.route) {
        composable(Route.Home.route) {
            MaterialsScreen(onMaterialClick = {
                navHostController.navigate(Route.DetailMaterial(it.toString()).route)
            }, onAddClick = {
                navHostController.navigate(Route.DetailMaterial("new").route)
            })
        }

        composable(Route.DetailMaterial().route, arguments = listOf(
            navArgument("id") {
                type = NavType.StringType
                nullable = true
                defaultValue = null
            }
        )) { backStackEntry ->
            val idString = backStackEntry.arguments?.getString("id")
            val materialId = when {
                idString == null || idString == "new" -> null
                else -> idString.toIntOrNull()
            }
            MaterialEditScreen(
                materialId = materialId,
                onBackClick = { navHostController.popBackStack() },
                onSaveSuccess = {
                    viewModel.refreshMaterials()
                    navHostController.popBackStack()
                },
                onDeleteSuccess = {
                    viewModel.refreshMaterials()
                    navHostController.popBackStack()
                }
            )
        }
    }
}