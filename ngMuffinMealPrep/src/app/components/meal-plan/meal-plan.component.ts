import { Component } from '@angular/core';
import { Diet } from 'src/app/models/diet';
import { Meal } from 'src/app/models/meal';
import { MealPlan } from 'src/app/models/meal-plan';
import { PlanReview } from 'src/app/models/plan-review';
import { AuthService } from 'src/app/services/auth.service';
import { DietService } from 'src/app/services/diet.service';
import { MealPlanService } from 'src/app/services/meal-plan.service';
import { MealService } from 'src/app/services/meal.service';
import { PlanReviewService } from 'src/app/services/plan-review.service';

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
  planReviews: PlanReview[] = [];
  newReview: PlanReview = new PlanReview();
  diets: Diet[] = [];
  selectedDiet: Diet | null = null;


  loggedIn(): boolean{
    return this.auth.checkLogin();
  }


  constructor(private mealPlanService: MealPlanService, private auth: AuthService, private mealService: MealService, private planReviewService: PlanReviewService, private dietService: DietService
    ){}

  ngOnInit(): void {
    this.reload();
    this.findAllMeals();
    this.findAllMealsInMealPlan();
    this.loadPlanReviews();
    this.loadDiets();
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
  this.loadPlanReviews();
  console.log(this.selected)

}
displayTable(){
  this.selected = null;
  this.selectedMeal = null;
}

addMealPlan(newMealPlan: MealPlan){
   console.log(this.findAllMealsInMealPlan());
  newMealPlan.meals = this.mealsToAddToMealPlan;
  this.mealPlans.push(newMealPlan);

  console.log(this.mealsToAddToMealPlan)
  console.log(newMealPlan);
 this.mealsToAddToMealPlan = [];
 if (this.selectedDiet) {
  newMealPlan.diet = this.selectedDiet;
}
  this.mealPlanService.create(newMealPlan).subscribe({
    next:(createdMealPlan) => {
      console.log(createdMealPlan)
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

 findAllMealsInMealPlan(){
  this.mealService.index().subscribe({
    next: (meals) =>{
      for(let meal of meals){
        if(this.mealsToAddToMealPlan.includes(meal)){
          this.selected?.meals.push(meal);
        }
      }


    }
   });

 }

 loadPlanReviews(): void {
  if (this.selected) {
    this.planReviewService.getPlanReviews(this.selected.id).subscribe(
      (reviews) => {
        this.planReviews = reviews;
      },
      (error) => {
        console.error('Error fetching plan reviews:', error);
      }
    );
  }
}

createPlanReview(planReview: PlanReview): void {
  if (this.selected) {
    this.planReviewService.createPlanReview(this.selected.id, planReview).subscribe({
      next: (newReview) => {
        this.planReviews.push(newReview);
      },
      error: (error) => {
        console.error('Error creating plan review:', error);
      },
    });
  }
}

onSubmitReview(): void {
  if (this.selected) {
    const planReview = new PlanReview(undefined, this.newReview.comment, this.newReview.stars);
    this.createPlanReview(planReview);
    this.newReview = new PlanReview();
  }
}

loadDiets(): void {
  this.dietService.index().subscribe((diets) => {
    this.diets = diets;
  });
}

onDietSelected(diet: Diet| null): void {
  if(diet) {}
  this.selectedDiet = diet;
  console.log('Diets:', this.diets);
}

}
