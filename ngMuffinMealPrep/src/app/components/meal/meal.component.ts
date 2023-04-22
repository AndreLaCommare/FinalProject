import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { GroceryItem } from 'src/app/models/grocery-item';
import { Meal } from 'src/app/models/meal';
import { MealService } from 'src/app/services/meal.service';

@Component({
  selector: 'app-meal',
  templateUrl: './meal.component.html',
  styleUrls: ['./meal.component.css']
})
export class MealComponent implements OnInit{

  meals: Meal[] = [];
  selected: Meal | null = null;
  newMeal: Meal = new Meal();
  loggedIn(): boolean{
    return this.auth.checkLogin();
  }

  constructor(private mealService: MealService, private auth: AuthService){}

  ngOnInit(): void {
    this.reload();

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

}
