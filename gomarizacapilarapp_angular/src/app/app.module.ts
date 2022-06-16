import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { LoginComponent } from './pages/public/login/login/login.component';
import { HomeComponent } from './pages/private/home/home/home.component';
import { MaterialImportsModule } from './modules/material-imports/material-imports.module';
import { HttpClientModule } from '@angular/common/http';
import { NavbarComponent } from './pages/shared/navbar/navbar.component';
import { AppointmentComponent } from './pages/private/appointment/appointment/appointment.component';
import { ServiceComponent } from './pages/private/service/service/service.component';
import { UserComponent } from './pages/private/user/user/user.component';
import { LocationComponent } from './pages/private/location/location/location.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HomeComponent,
    NavbarComponent,
    AppointmentComponent,
    ServiceComponent,
    UserComponent,
    LocationComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialImportsModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
