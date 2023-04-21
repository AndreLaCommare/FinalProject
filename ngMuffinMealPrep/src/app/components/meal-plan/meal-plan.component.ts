import { Component } from '@angular/core';
import { Meal } from 'src/app/models/meal';
import { MealPlan } from 'src/app/models/meal-plan';
import { AuthService } from 'src/app/services/auth.service';
import { MealPlanService } from 'src/app/services/meal-plan.service';

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
  loggedIn(): boolean{
    return this.auth.checkLogin();
  }


  constructor(private mealPlanService: MealPlanService, private auth: AuthService){}

  ngOnInit(): void {
    this.reload();

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

}
displayTable(){
  this.selected = null;
  this.selectedMeal = null;
}

addMealPlan(newMealPlan: MealPlan){
  console.log(newMealPlan);
  this.mealPlanService.create(newMealPlan).subscribe({
    next:(createdMeal) => {
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


}
