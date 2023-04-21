import { GroceryItem } from 'src/app/models/grocery-item';
import { GroceryItemService } from './../../services/grocery-item.service';
import { Component } from '@angular/core';

@Component({
  selector: 'app-grocery-item',
  templateUrl: './grocery-item.component.html',
  styleUrls: ['./grocery-item.component.css']
})
export class GroceryItemComponent {

  groceryItems: GroceryItem[] =[];

  constructor(private groceryItemService: GroceryItemService){}

  findAll(){
    this.groceryItemService.findAll().subscribe({
      next: (data) => {
        this.groceryItems = data;
      },
      error:(fail) => {
        console.error('Error reloading');
        console.error(fail);
      }
    })
  }
}
