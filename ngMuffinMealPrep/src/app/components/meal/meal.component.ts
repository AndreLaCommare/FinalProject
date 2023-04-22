import { GroceryItemService } from './../../services/grocery-item.service';
import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { GroceryItem } from 'src/app/models/grocery-item';
import { Meal } from 'src/app/models/meal';
import { MealService } from 'src/app/services/meal.service';
import { NgbDropdown } from '@ng-bootstrap/ng-bootstrap';
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

  loggedIn(): boolean{
    return this.auth.checkLogin();
  }

  constructor(private mealService: MealService, private auth: AuthService, private groceryItemService: GroceryItemService){}

  ngOnInit(): void {
    this.reload();
    this.findAllGroceryItems();

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

}
