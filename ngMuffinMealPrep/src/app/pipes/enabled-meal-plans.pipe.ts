import { Pipe, PipeTransform } from '@angular/core';
import { MealPlan } from '../models/meal-plan';

@Pipe({
  name: 'enabledMealPlans'
})
export class EnabledMealPlansPipe implements PipeTransform {

  transform(mealPlans: MealPlan[] | undefined): MealPlan[] {
    if(!mealPlans){
      return [];
    }
    let  results: MealPlan[] = [];
    for(let mealPlan of mealPlans){
     if(mealPlan.enabled){
       results.push(mealPlan);
     }
    }
    return results;
   }

}
