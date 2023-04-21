export class Meal {

  id: number;
  name: string;
  description: string;
  imageUrl: string;
  instructions: string;
  enabled: boolean;
  visible: boolean;
  prepTime: number;
  cookTime: number;


  constructor(
    id: number =0,
    name: string = '',
    description: string = '',
  imageUrl: string = '',
  instructions: string = '',
  enabled: boolean = false,
  visible: boolean = false,
  prepTime: number = 0,
  cookTime: number = 0,

  ){
    this.id = id;
    this.name =name ;
    this.description = description;
    this.imageUrl = imageUrl;
    this.instructions = instructions;
    this.enabled = enabled;
    this.visible = visible
    this.prepTime = prepTime;
    this.cookTime = cookTime;
  }


}
