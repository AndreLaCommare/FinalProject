import { Pipe, PipeTransform } from '@angular/core';
import { MealPlan } from './models/meal-plan';

@Pipe({
  name: 'mealPlanDiet'
})
export class MealPlanDietPipe implements PipeTransform {

  transform(mealPlans: MealPlan[], dietName: string | null): MealPlan[] {

    if (!dietName || dietName === 'all') {
      return mealPlans;
    }
    let results: MealPlan[] = [];
    for (let mealPlan of mealPlans) {
      if (mealPlan.diets[0] && mealPlan.diets[0].name === dietName) {
        results.push(mealPlan);
      }
    }
    return results;
  }
}
