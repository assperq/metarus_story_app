package com.example.adminapp.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.navigation.compose.rememberNavController
import com.example.adminapp.presentation.navigation.SetupNavigationGraph
import com.example.adminapp.presentation.screens.material_list_screen.MaterialsScreen
import com.example.adminapp.presentation.theme.AppTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            AppTheme {
                val navController = rememberNavController()
                SetupNavigationGraph(navController)
            }
        }
    }
}