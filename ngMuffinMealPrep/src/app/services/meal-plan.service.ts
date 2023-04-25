import { HttpClient } from '@angular/common/http';
import { EventEmitter, Injectable, Output } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { MealPlan } from '../models/meal-plan';
import { Meal } from '../models/meal';

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



  adminDelete(mealPlanId: number): Observable<void>{
    return this.http.delete<void>(this.url + "/admin/" + mealPlanId, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealPlanService.adminDelete(): error disabling meal plan: ' + err)
        );
      })
    );
  }

  reactivate(mealPlan: MealPlan): Observable<MealPlan>{
    return this.http.put<MealPlan>(this.url + "/admin/" + mealPlan.id, mealPlan, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.reactivate(): error re-enabling User: ' + err)
        );
      })
    );
  }

  addMealToPlan(meal: Meal, mealPlan: MealPlan): Observable<MealPlan>{
    return this.http.put<MealPlan>(this.url + '/' + mealPlan.id + '/' + 'meals' + "/" + meal.id, mealPlan, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.reactivate(): error re-enabling User: ' + err)
        );
      })
    );
  }

  deleteMealFromPlan(meal: Meal, mealPlan: MealPlan): Observable<MealPlan>{
    return this.http.delete<MealPlan>(this.url + '/' + mealPlan.id + '/' + 'meals' + "/"+ meal.id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.reactivate(): error re-enabling User: ' + err)
        );
      })
    );
  }


  deletePlan(mealPlanId: number): Observable<void>{
    return this.http.delete<void>(this.url + "/" + mealPlanId, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.reactivate(): error re-enabling User: ' + err)
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


  search(keyword: string): Observable<MealPlan[]>{

    return this.http.get<MealPlan[]>(this.url + "/search/" + keyword).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealPlanService.search(): error retrieving mealplans: ' + err)
        );
      })
    );

  }
}
