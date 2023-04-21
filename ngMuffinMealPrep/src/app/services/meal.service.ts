import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { Meal } from '../models/meal';


@Injectable({
  providedIn: 'root'
})
export class MealService {

  private url = environment.baseUrl + 'api/meals';
  constructor(private http: HttpClient, private auth: AuthService) { }

  index(): Observable<Meal[]> {
    // Return defensive copy of private array
    return this.http.get<Meal[]>(this.url + '?sorted=true').pipe(
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

  show(todoId: number): Observable<Meal> {
    // Return defensive copy of private array
    return this.http.get<Meal>(this.url + '/' + todoId).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealService.show(): error retrieving meal: ' + err)
        );
      })
    );
  };




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
