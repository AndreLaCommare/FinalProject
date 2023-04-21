import { Meal } from "./meal";
import { User } from "./user";

export class MealPlan {
  id: number;
  title: string;
  description: string;
  enabled: boolean;
  visible: boolean;
  created_at: string;
  updated_at: string;
  planCreator: User | null;
  copiedFromPlan: MealPlan | null;
  meals: Meal[];

  constructor(
    id: number = 0,
    title: string = '',
    description: string = '',
    enabled: boolean = false,
    visible: boolean = false,
    created_at: string = '',
    updated_at: string = '',
    planCreator: User | null = null,
    copiedFromPlan: MealPlan | null = null,
    meals: Meal[] = []
  ) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.enabled = enabled;
    this.visible = visible;
    this.created_at = created_at;
    this.updated_at = updated_at;
    this.planCreator = planCreator;
    this.copiedFromPlan = copiedFromPlan;
    this.meals = meals;
  }
}
