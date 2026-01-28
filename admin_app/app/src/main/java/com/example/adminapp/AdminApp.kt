package com.example.adminapp

import android.app.Application
import com.example.adminapp.di.materialModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.GlobalContext.startKoin

class AdminApp : Application() {

    override fun onCreate() {
        super.onCreate()
        startKoin {
            modules(materialModule)
            androidContext(applicationContext)
        }
    }
}