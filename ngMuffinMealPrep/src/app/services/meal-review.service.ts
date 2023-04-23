// src/app/services/meal-review.service.ts
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { MealReview } from '../models/meal-review';

@Injectable({
  providedIn: 'root'
})
export class MealReviewService {
  private apiUrl = 'http://localhost:8090/api/meals';

  constructor(private http: HttpClient) { }

  createMealReview(mealReview: MealReview, mealId: number, userId: number): Observable<MealReview> {
    return this.http.post<MealReview>(`${this.apiUrl}/${mealId}/mealReview/${userId}`, mealReview);
  }

  getMealReviewsByMealId(mealId: number): Observable<MealReview[]> {
    return this.http.get<MealReview[]>(`${this.apiUrl}/${mealId}/mealReview`);
  }
}

