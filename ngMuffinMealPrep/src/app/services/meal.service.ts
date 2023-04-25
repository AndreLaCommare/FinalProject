import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { Meal } from '../models/meal';
import { GroceryItem } from '../models/grocery-item';


@Injectable({
  providedIn: 'root'
})
export class MealService {

  private url = environment.baseUrl + 'api/meals';
  constructor(private http: HttpClient, private auth: AuthService) { }
  private querySubject: string ='';

  setQuery(query: string){
    this.querySubject = query;
  }

  index(): Observable<Meal[]> {
    // Return defensive copy of private array
    return this.http.get<Meal[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealService.index(): error retrieving meals: ' + err)
        );
      })
    );
  };

  create(meal: Meal): Observable<Meal>{

    return this.http.post<Meal>(this.url, meal, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealService.create(): error creating meal: ' + err)
        );
      })
    );
  }

  show(mealId: number): Observable<Meal> {
    // Return defensive copy of private array
    return this.http.get<Meal>(this.url + '/' + mealId).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealService.show(): error retrieving meal: ' + err)
        );
      })
    );
  };

  createGroceryForMeal(grocery : GroceryItem, groceryId: number, mealId : number): Observable <GroceryItem> {
    return this.http.post<GroceryItem>(this.url + '/' + mealId + '/groceryItems/' + groceryId, grocery).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealService.createGroceryForMeal(): error adding grocery to meal: ' + err)
        );
      })
    );
  }

  update(meal: Meal): Observable<Meal>{
    return this.http.put<Meal>(this.url + '/' + meal.id, meal, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealService.createGroceryForMeal(): error adding grocery to meal: ' + err)
        );
      })
    );
  }

  delete(mealId: number): Observable<void>{
    return this.http.delete<void>(this.url + "/" + mealId, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealService.delete(): error disabling meal: ' + err)
        );
      })
    );
  }

  adminDelete(mealId: number): Observable<void>{
    return this.http.delete<void>(this.url + "/admin/" + mealId, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealService.adminDelete(): error disabling meal: ' + err)
        );
      })
    );
  }

  reactivate(meal: Meal): Observable<Meal>{
    return this.http.put<Meal>(this.url + "/admin/" + meal.id, meal, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.reactivate(): error re-enabling User: ' + err)
        );
      })
    );
  }

  search(): Observable<Meal[]>{

    return this.http.get<Meal[]>(this.url + "/search/" + this.querySubject).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealService.search(): error retrieving meals: ' + err)
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
