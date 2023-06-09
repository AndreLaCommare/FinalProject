import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { ProfileComponent } from './components/profile/profile.component';
import { MealComponent } from './components/meal/meal.component';
import { MealPlanComponent } from './components/meal-plan/meal-plan.component';
import { ShoppingListComponent } from './components/shopping-list/shopping-list.component';
import { AdminComponent } from './components/admin/admin.component';
import { RegisterComponent } from './components/register/register.component';




const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: HomeComponent },
  { path: 'profile', component: ProfileComponent },
  { path: 'meals', component: MealComponent },
  { path: 'meals/:mealId', component: MealComponent },
  { path: 'meals/search/:keyword', component: MealComponent},
  { path: 'mealPlans', component: MealPlanComponent },
  { path: 'mealPlans/:mealPlanId', component: MealPlanComponent },
  { path: 'mealPlans/search/:keyword', component: MealPlanComponent},
  { path: 'shoppingList', component: ShoppingListComponent},
  { path: 'admin', component: AdminComponent},
  { path: 'register', component: RegisterComponent},





];

@NgModule({

  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
