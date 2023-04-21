import { Component, OnInit } from '@angular/core';
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

  constructor(private mealService: MealService){}

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

}
