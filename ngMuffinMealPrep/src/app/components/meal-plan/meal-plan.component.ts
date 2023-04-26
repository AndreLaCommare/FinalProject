import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Diet } from 'src/app/models/diet';
import { Meal } from 'src/app/models/meal';
import { MealPlan } from 'src/app/models/meal-plan';
import { MealReview } from 'src/app/models/meal-review';
import { PlanReview } from 'src/app/models/plan-review';
import { AuthService } from 'src/app/services/auth.service';
import { DietService } from 'src/app/services/diet.service';
import { MealPlanService } from 'src/app/services/meal-plan.service';
import { MealReviewService } from 'src/app/services/meal-review.service';
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

  mealReviews: MealReview[] = [];

  diets: Diet[] = [];
  selectedDiet: Diet | null = null;
  selectedDietName: string | null = null;



  loggedIn(): boolean{
    return this.auth.checkLogin();
  }



  constructor(private mealPlanService: MealPlanService, private auth: AuthService, private mealService: MealService, private planReviewService: PlanReviewService, private dietService: DietService, private mealReviewService: MealReviewService, private currentRoute: ActivatedRoute, private router: Router

    ){}

  ngOnInit(): void {
    //this.reload();
    let keyword = this.currentRoute.snapshot.paramMap.get("keyword");
    let mealPlanId = this.currentRoute.snapshot.paramMap.get("mealPlanId");
    console.log("got keyword:" + keyword);
    if(keyword){
      console.log("got keyword:" + keyword);
      this.populateResults(keyword);

    }else if(mealPlanId){
      this.findMealPlanById(parseInt(mealPlanId));

    }else{

      this.reload();

    }


    this.findAllMeals();
     this.findAllMealsInMealPlan();
    this.loadPlanReviews();
    this.loadDiets();
  }

  populateResults(keyword: string){

    this.mealPlanService.search(keyword).subscribe({
      next:(resultMealPlans) => {
        this.mealPlans = resultMealPlans;

      },
      error:(err) => {
        console.error(err);
      }
    })


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
  if (this.selectedDiet) {
   newMealPlan.diet = this.selectedDiet;
   newMealPlan.diets.push(this.selectedDiet);
 }
  this.mealPlans.push(newMealPlan);

  console.log(this.mealsToAddToMealPlan)
  console.log(newMealPlan);
 this.mealsToAddToMealPlan = [];
  this.mealPlanService.create(newMealPlan).subscribe({
    next:(createdMealPlan) => {
      console.log(createdMealPlan)
      window.location.reload();
      this.reload();

    },
    error:(err) =>{
      console.error(err)
    }
  });
}
displaySingleMeal(meal: Meal){
  this.router.navigateByUrl("/meals/" + meal.id);
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


getMealReviewsByMealId(mealId: number) {
  this.mealReviewService.getMealReviewsByMealId(mealId).subscribe({
    next: (reviews) => {
      this.mealReviews = reviews;
    },
    error: (err) => {
      console.error('Error fetching meal reviews:', err);
    },
  });
}


loadDiets(): void {
  this.dietService.index().subscribe((diets) => {
    this.diets = diets;
  });
}

onDietSelected(diet: Diet| null): void {
  if(diet) {

    this.selectedDiet = diet;
  }
  console.log('Diets:', this.diets);
}

findMealPlanById(mealPlanId: number){
  this.mealPlanService.show(mealPlanId).subscribe({
    next:(mealPlan) =>{
      this.selected = mealPlan;
    },
    error:(err) =>{
      console.error(err);
    }
  });
}




}
