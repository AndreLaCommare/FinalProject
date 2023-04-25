import { Pipe, PipeTransform } from '@angular/core';
import { Meal } from '../models/meal';

@Pipe({
  name: 'enabledMeals'
})
export class EnabledMealsPipe implements PipeTransform {


  transform(meals: Meal[]): Meal[] {
   let  results: Meal[] = [];
   for(let meal of meals){
    if(meal.enabled){
      results.push(meal);
    }
   }
   return results;
  }

}
