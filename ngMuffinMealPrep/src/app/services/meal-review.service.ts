// src/app/services/meal-review.service.ts
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { MealReview } from '../models/meal-review';
import { AuthService } from './auth.service';
import { environment } from 'src/environments/environment';


@Injectable({
  providedIn: 'root'
})
export class MealReviewService {
  private url = environment.baseUrl + 'api/meals';

  constructor(private http: HttpClient, private auth: AuthService) { }

  createMealReview(mealReview: MealReview, mealId: number, userId: number): Observable<MealReview> {
    console.log('Sending JSON payload:', JSON.stringify(mealReview));
    console.log(mealId)
    console.log(userId)
    return this.http.post<MealReview>(`${this.url}/${mealId}/mealReviews`, mealReview, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealReviewService.createMealReview(): error creating meal review: ' + err)
        );
      })
    );
  }

  getMealReviewsByMealId(mealId: number): Observable<MealReview[]> {
    return this.http.get<MealReview[]>(`${this.url}/${mealId}/mealReviews`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MealReviewService.getMealReviewsByMealId(): error fetching meal reviews by mealId: ' + err)
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

