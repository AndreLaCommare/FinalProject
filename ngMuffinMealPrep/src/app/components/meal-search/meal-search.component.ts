import { ShoppingListService } from 'src/app/services/shopping-list.service';
import { Component } from '@angular/core';
import { GroceryItem } from 'src/app/models/grocery-item';
import { Meal } from 'src/app/models/meal';
import { AuthService } from 'src/app/services/auth.service';
import { MealService } from 'src/app/services/meal.service';
import { User } from 'src/app/models/user';
import { MealReview } from 'src/app/models/meal-review';
import { MealReviewService } from 'src/app/services/meal-review.service';

@Component({
  selector: 'app-meal-search',
  templateUrl: './meal-search.component.html',
  styleUrls: ['./meal-search.component.css']
})
export class MealSearchComponent {
  resultMeals: Meal[] = [];
  selected: Meal | null = null;
  currentUser: User | null = null;
  newReview: MealReview = new MealReview();
  mealReviews: MealReview[] = [];

  constructor(private mealService: MealService, private auth: AuthService, private shoppingListService: ShoppingListService, private mealReviewService: MealReviewService){

  }
ngOnInit(){
  this.populateResults();
  this.getLoggedInUser();
}


  displaySingleMeal(meal: Meal){
    this.selected = meal;
    //this.getMealReviewsByMealId(meal.id);

  }

  populateResults(){

    this.mealService.search().subscribe({
      next:(resultMeals) => {
        this.resultMeals = resultMeals;

      },
      error:(err) => {
        console.error(err);
      }
    })


  }

  getLoggedInUser( ){
    this.auth.getLoggedInUser().subscribe( {
      next: (user) =>{this.currentUser = user;
      },
      error: (nojoy)=>{
        console.error(nojoy)
      }});
  }

  loggedIn(): boolean{
    return this.auth.checkLogin();
  }

  addGroceryToShoppingList(grocery: GroceryItem){
    console.log(this.currentUser)
      this.currentUser?.groceries.push(grocery)
    this.updateUserShoppingList(this.currentUser)
  }

  updateUserShoppingList(user: User|null){
    this.shoppingListService.update(user).subscribe({
      next: (update) => {


        this.ngOnInit();

      }

    })
  }

  createMealReview(mealReview: MealReview, mealId: number, userId: number) {
    this.mealReviewService.createMealReview(mealReview, mealId, userId).subscribe({
      next: (createdReview) => {
        this.getMealReviewsByMealId(mealId);
      },
      error: (err) => {
        console.error('Error creating meal review:', err);
      },
    });
  }

  onSubmitReview() {
    if (this.selected && this.currentUser) {
      this.createMealReview(this.newReview, this.selected.id, this.currentUser.id);
      this.newReview = new MealReview();
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

  displayTable(){
    this.selected = null;
  }
}
