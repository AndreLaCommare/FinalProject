import { Component } from '@angular/core';
import { Meal } from 'src/app/models/meal';
import { MealPlan } from 'src/app/models/meal-plan';
import { AuthService } from 'src/app/services/auth.service';
import { MealPlanService } from 'src/app/services/meal-plan.service';
import { MealService } from 'src/app/services/meal.service';

@Component({
  selector: 'app-meal-plan',
  templateUrl: './meal-plan.component.html',
  styleUrls: ['./meal-plan.component.css']
})
export class MealPlanComponent {

  mealPlans: MealPlan[] = [];
  selected: MealPlan | null = null;
  newMealPlan: MealPlan = new MealPlan();
  selectedMeal: Meal | null = null;
  mealList: Meal [] = [];
  mealsToAddToMealPlan: Meal[] = [];

  loggedIn(): boolean{
    return this.auth.checkLogin();
  }


  constructor(private mealPlanService: MealPlanService, private auth: AuthService, private mealService: MealService){}

  ngOnInit(): void {
    this.reload();
    this.findAllMeals();

  }
  reload(){

    this.mealPlanService.index().subscribe({
      next: (data) => {
        this.mealPlans = data;
        console.log(this.mealPlans);
      },


  error: (fail) => {
    console.error('Error reloading');
    console.error(fail);
  }
  });
}
displaySingleMealPlan(mealPlan: MealPlan){
  this.selected = mealPlan;
  console.log(this.selected)

}
displayTable(){
  this.selected = null;
  this.selectedMeal = null;
}

addMealPlan(newMealPlan: MealPlan){
  newMealPlan.meals = this.mealsToAddToMealPlan;
  console.log(this.mealsToAddToMealPlan)
  console.log(newMealPlan);
 this.mealsToAddToMealPlan = [];
  this.mealPlanService.create(newMealPlan).subscribe({
    next:(createdMealPlan) => {
      this.reload();
    },
    error:(err) =>{
      console.error(err)
    }
  });
}
displaySingleMeal(meal: Meal){
  this.selectedMeal = meal;

}

addMealToMealPlan(meal: Meal){
  this.mealsToAddToMealPlan.push(meal)
}

findAllMeals(){
  this.mealService.index().subscribe({
   next: (meals) =>{
     console.log(meals)
     this.mealList = meals;
   }
  });
 }


}
