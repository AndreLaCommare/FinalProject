import { HttpClient } from '@angular/common/http';
import { EventEmitter, Injectable, Output } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { MealPlan } from '../models/meal-plan';

@Injectable({
  providedIn: 'root',
})
export class MealPlanService {
  private url = environment.baseUrl + 'api/mealPlans';
  @Output() refreshMealPlans: EventEmitter<any> = new EventEmitter();

  constructor(private http: HttpClient, private auth: AuthService) {}

  index(): Observable<MealPlan[]> {
    return this.http.get<MealPlan[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('MealPlanService.index(): error retrieving meal plans: ' + err)
        );
      })
    );
  }

  create(mealPlan: MealPlan): Observable<MealPlan> {
    console.log(mealPlan.meals)
    return this.http.post<MealPlan>(this.url, mealPlan, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log("in service")
        console.log(err);
        return throwError(
          () =>
            new Error('MealPlanService.create(): error creating meal plan: ' + err)
        );
      })
    );
  }

  show(mealPlanId: number): Observable<MealPlan> {
    return this.http.get<MealPlan>(this.url + '/' + mealPlanId).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('MealPlanService.show(): error retrieving meal plan: ' + err)
        );
      })
    );
  }


  update(mealPlan: MealPlan): Observable<MealPlan>{
    console.log(mealPlan)
    return this.http.put<MealPlan>(this.url + '/' + mealPlan.id, mealPlan, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('MealPlanService.put: error updating meal plan: ' + err)
        );
      })
    );
  }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }
}
