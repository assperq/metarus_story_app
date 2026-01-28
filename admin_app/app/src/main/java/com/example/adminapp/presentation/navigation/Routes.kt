package com.example.adminapp.presentation.navigation

sealed class Route(val route: String) {
    data object Home : Route("material")
    data class DetailMaterial(val id : String = "{id}") : Route("material/edit/$id")
}