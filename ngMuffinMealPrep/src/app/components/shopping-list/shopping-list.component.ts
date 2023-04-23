import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { GroceryItemService } from 'src/app/services/grocery-item.service';
import { MealService } from 'src/app/services/meal.service';

@Component({
  selector: 'app-shopping-list',
  templateUrl: './shopping-list.component.html',
  styleUrls: ['./shopping-list.component.css']
})
export class ShoppingListComponent implements OnInit{
  currentUser: User | null = null;

  constructor(
    private auth: AuthService,
    private currentRoute : ActivatedRoute,){}

  ngOnInit(){
   this.getLoggedInUser();

  }



  getLoggedInUser( ){
    this.auth.getLoggedInUser().subscribe( {
      next: (user) =>{this.currentUser = user;
        console.log(user)
        console.log(this.currentUser)
      },
      error: (nojoy)=>{
        console.error(nojoy)
      }});
  }
}
