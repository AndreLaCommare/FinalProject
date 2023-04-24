import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { RegisterComponent } from './components/register/register.component';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { HomeComponent } from './components/home/home.component';
import { NavigationComponent } from './components/navigation/navigation.component';
import { ProfileComponent } from './components/profile/profile.component';
import { MealComponent } from './components/meal/meal.component';
import { MealPlanComponent } from './components/meal-plan/meal-plan.component';
import { GroceryItemComponent } from './components/grocery-item/grocery-item.component';
import { NgbDropdownModule } from '@ng-bootstrap/ng-bootstrap';
import { ShoppingListComponent } from './components/shopping-list/shopping-list.component';
import { AdminComponent } from './components/admin/admin.component';
import { EnabledMealsPipe } from './pipes/enabled-meals.pipe';
@NgModule({
  declarations: [
    AppComponent,
    RegisterComponent,
    LoginComponent,
    LogoutComponent,
    HomeComponent,
    NavigationComponent,
    ProfileComponent,
    MealComponent,
    MealPlanComponent,
    GroceryItemComponent,
    ShoppingListComponent,
    AdminComponent,
    EnabledMealsPipe
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    NgbModule,
    NgbDropdownModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
