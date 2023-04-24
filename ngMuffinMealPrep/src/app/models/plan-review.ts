import { MealPlan } from './meal-plan';
import { User } from './user';

export class PlanReview {
  comment: string;
  stars: number;
  enabled: boolean;
  createdAt: string;
  updatedAt: string;
  user: User;
  mealPlan: MealPlan;

  constructor(
    user: User = new User(),
    comment: string = '',
    stars: number = 0,
    enabled: boolean = false,
    createdAt: string = '',
    updatedAt: string = '',
    mealPlan: MealPlan = new MealPlan()
  ) {
    this.comment = comment;
    this.stars = stars;
    this.enabled = enabled;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.mealPlan = mealPlan;
    this.user = user;
  }
}
