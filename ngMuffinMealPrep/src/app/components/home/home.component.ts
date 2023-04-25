import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Meal } from 'src/app/models/meal';
import { MealPlan } from 'src/app/models/meal-plan';
import { MealPlanService } from 'src/app/services/meal-plan.service';
import { MealService } from 'src/app/services/meal.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  meals: Meal[] = [];
  mealPlans: MealPlan[] = [];
  shuffledMeals: Meal[] = [];
  shuffledMealPlans: MealPlan[] = [];

  constructor(
    private mealService: MealService,
    private mealPlanService: MealPlanService,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.loadMeals();
    this.loadMealPlans();
  }

  loadMeals(): void {
    this.mealService.index().subscribe(meals => {
      this.meals = meals;
      this.shuffledMeals = this.shuffleArray(meals);

    });
  }

  loadMealPlans(): void {
    this.mealPlanService.index().subscribe(mealPlans => {
      this.mealPlans = mealPlans;
      this.shuffledMealPlans = this.shuffleArray(mealPlans);

    });
  }

  shuffleArray(array: any[]): any[] {
    return array.sort(() => Math.random() - 0.5);
  }
  displaySingleMeal(meal: Meal){
    this.router.navigateByUrl("/meals/" + meal.id);


  }
  displaySingleMealPlan(mealPlan: MealPlan){
    this.router.navigateByUrl("/mealPlans/" + mealPlan.id);


  }


}
