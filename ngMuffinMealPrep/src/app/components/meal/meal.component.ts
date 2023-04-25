import { GroceryItemService } from './../../services/grocery-item.service';
import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { GroceryItem } from 'src/app/models/grocery-item';
import { Meal } from 'src/app/models/meal';
import { MealService } from 'src/app/services/meal.service';
import { NgbDropdown } from '@ng-bootstrap/ng-bootstrap';
import { User } from 'src/app/models/user';
import { ActivatedRoute } from '@angular/router';
import { ShoppingListService } from 'src/app/services/shopping-list.service';
import { MealReview } from 'src/app/models/meal-review';
import { MealReviewService } from 'src/app/services/meal-review.service';

@Component({
  selector: 'app-meal',
  templateUrl: './meal.component.html',
  styleUrls: ['./meal.component.css']
})
export class MealComponent implements OnInit{

  meals: Meal[] = [];
  selected: Meal | null = null;
  newMeal: Meal = new Meal();
  groceryItemList: GroceryItem [] = [];
  itemsToAddToMeal: GroceryItem [] =[];
  newGroceryItemName: string = '';
addedGroceryItems: GroceryItem[] = [];
currentUser: User | null = null;
mealReviews: MealReview[] = [];
newReview: MealReview = new MealReview();


  loggedIn(): boolean{
    return this.auth.checkLogin();
  }

  constructor(private mealService: MealService,
     private auth: AuthService,
     private groceryItemService: GroceryItemService,
     private currentRoute : ActivatedRoute,
     private shoppingListService: ShoppingListService,
     private mealReviewService: MealReviewService
     ){}

  ngOnInit(): void {
    let keyword = this.currentRoute.snapshot.paramMap.get("keyword");

    console.log("got keyword:" + keyword);
    if(keyword){
      console.log("got keyword:" + keyword);
      this.populateResults(keyword);

    }else{

      this.reload();

    }

    // this.findAllGroceryItems();
    this.getLoggedInUser();


  }

  populateResults(keyword: string){

    this.mealService.search(keyword).subscribe({
      next:(resultMeals) => {
        this.meals = resultMeals;

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
    reload(){

      this.mealService.index().subscribe({
        next: (data) => {
          this.meals = data;
          console.log(this.meals);
        },


    error: (fail) => {
      console.error('Error reloading');
      console.error(fail);
    }
    });
  }

    displaySingleMeal(meal: Meal){
      this.selected = meal;
      this.getMealReviewsByMealId(meal.id);

    }
    displayTable(){
      this.selected = null;
    }

    addMeal(newMeal: Meal){
      newMeal.groceryItems = this.addedGroceryItems;
      this.itemsToAddToMeal = []
      console.log(this.addedGroceryItems)
      console.log(newMeal);
      this.mealService.create(newMeal).subscribe({
        next:(createdMeal) => {
          this.reload();
        },
        error:(err) =>{
          console.error(err)
        }
      });
    }

    addItemToMeal(groceryItem: GroceryItem){
      this.addedGroceryItems.push(groceryItem)
    }

    createAndAddGroceryItem(name: string) {
      if (name) {
        const newGroceryItem: GroceryItem = {
          id: 0,
          name: name,
          created_at: ''
        };
        this.groceryItemService.create(newGroceryItem).subscribe(
          createdItem => {
            this.addedGroceryItems.push(createdItem);
            this.newGroceryItemName = '';
            this.findAllGroceryItems();
          },
          error => {
            console.error('Error creating new grocery item:', error);
          }
        );
      }
    }


    addGroceryToMeal(newGrocery: GroceryItem, currentMeal: Meal){
      console.log(newGrocery);
      this.mealService.createGroceryForMeal(newGrocery, newGrocery.id, currentMeal.id).subscribe({
        next:(updatedMeal) => {
          this.reload();
        },
        error:(err) => {
          console.error(err);
        }
      })
    }

    findAllGroceryItems(){
     this.groceryItemService.findAll().subscribe({
      next: (itemList) =>{
        console.log(itemList)
        this.groceryItemList = itemList;
      }
     });
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

    onSubmitReview() {
      if (this.selected && this.currentUser) {
        this.createMealReview(this.newReview, this.selected.id, this.currentUser.id);
        this.newReview = new MealReview();
      }
    }


}
