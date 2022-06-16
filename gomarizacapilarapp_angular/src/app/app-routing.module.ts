import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AppointmentComponent } from './pages/private/appointment/appointment/appointment.component';
import { HomeComponent } from './pages/private/home/home/home.component';
import { LocationComponent } from './pages/private/location/location/location.component';
import { ServiceComponent } from './pages/private/service/service/service.component';
import { UserComponent } from './pages/private/user/user/user.component';
import { LoginComponent } from './pages/public/login/login/login.component';

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'home', component: HomeComponent },
  { path: 'appointment', component: AppointmentComponent },
  { path: 'service', component: ServiceComponent },
  { path: 'user', component: UserComponent },
  { path: 'location', component: LocationComponent },
  { path: '', redirectTo: 'login', pathMatch: 'full' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
