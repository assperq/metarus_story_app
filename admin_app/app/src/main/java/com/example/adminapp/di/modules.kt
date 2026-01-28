package com.example.adminapp.di

import com.example.adminapp.data.datasource.remote.MaterialService
import com.example.adminapp.data.repository.MaterialRepositoryImpl
import com.example.adminapp.domain.MaterialRepository
import com.example.adminapp.presentation.viewmodels.MaterialEditViewModel
import com.example.adminapp.presentation.viewmodels.MaterialsViewModel
import org.koin.dsl.module
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import kotlin.jvm.java

val materialModule = module {
    single<MaterialService> {
        Retrofit.Builder()
            .baseUrl("http://10.0.2.2:8000/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(MaterialService::class.java)
    }

    single<MaterialRepository> { MaterialRepositoryImpl(get()) }
    single<MaterialsViewModel> { MaterialsViewModel(get()) }
    factory<MaterialEditViewModel> { MaterialEditViewModel(get()) }
}