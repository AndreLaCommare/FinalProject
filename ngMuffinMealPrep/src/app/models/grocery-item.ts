export class GroceryItem {
  id: number;
  name: string;
  created_at: string;

  constructor(
    id: number = 0,
    name: string = '',
    created_at: string = ''
    )

    {
    this.id = id;
    this.name = name;
    this.created_at = created_at;
  }
}

