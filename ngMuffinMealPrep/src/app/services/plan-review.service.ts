import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { PlanReview } from '../models/plan-review';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class PlanReviewService {
  private url = environment.baseUrl + 'api/mealPlans';
  constructor(private http: HttpClient, private auth: AuthService) {}

  createPlanReview(mealPlanId: number, planReview: PlanReview): Observable<PlanReview> {
    return this.http.post<PlanReview>(`${this.url}/${mealPlanId}/reviews`, planReview, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('PlanReviewService.createMealReview(): error creating plan review: ' + err)
        );
      })
    );
  }

  getPlanReviews(mealPlanId: number): Observable<PlanReview[]> {
    return this.http.get<PlanReview[]>(`${this.url}/${mealPlanId}/reviews`);
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
