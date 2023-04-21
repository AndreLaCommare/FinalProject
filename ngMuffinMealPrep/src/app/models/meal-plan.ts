export class MealPlan {
  id: number;
  title: string;
  description: string;
  enabled: boolean;
  visible: boolean;
  created_at: string;
  updated_at: string;

  constructor(
    id: number = 0,
    title: string = '',
    description: string = '',
    enabled: boolean = false,
    visible: boolean = false,
    created_at: string = '',
    updated_at: string = ''
  ) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.enabled = enabled;
    this.visible = visible;
    this.created_at = created_at;
    this.updated_at = updated_at;
  }
}
