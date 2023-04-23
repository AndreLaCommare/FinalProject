// src/app/models/meal-review.model.ts
export class MealReview {
  id: number;
  user: number;
  meal: number;
  comment: string;
  stars: number;
  enabled: boolean;
  createdAt: string;
  updatedAt: string;

  constructor(
    id: number = 0,
    user: number = 0,
    meal: number = 0,
    comment: string = '',
    stars: number = 0,
    enabled: boolean = false,
    createdAt: string = '',
    updatedAt: string = ''
  ) {
    this.id = id;
    this.user = user;
    this.meal = meal;
    this.comment = comment;
    this.stars = stars;
    this.enabled = enabled;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }
}
